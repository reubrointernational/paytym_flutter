import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paytym/models/login/user_model.dart';
import 'package:paytym/models/report/deduction_response_model.dart';
import 'package:paytym/models/report/payslip_response_model.dart';
import 'package:paytym/models/report/request_advance_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/network/shared_preference_helper.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/enums.dart';
import '../../../core/dialog_helper.dart';
import '../../../models/message_only_response_model.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../../../routes/app_routes.dart';
import '../widgets/reason_bottomsheet.dart';


class ReportsControllerAdmin extends GetxController with BaseController {
  final ReceivePort _port = ReceivePort();
  String sharePath = '';

  //Sharing or downloading enum will be idle at the start
  final isSharingOrDownloading = SharingOrDownloading.idle.obs;
  final payslipResponseModel = PayslipResponseModel().obs;
  final requestAdvanceFormKey = GlobalKey<FormState>();
  RequestAdvanceModel requestAdvanceModel = RequestAdvanceModel();
  final deductionResponseModel = DeductionResponseModel().obs;
  String quitCompanyReason = '';

  showLogoutDialog() {
    DialogHelper.showConfirmDialog(
      onConfirm: logout,
    );
  }

//for bottomsheet
  showBottomSheetForReason() {
    DialogHelper.showBottomSheet(const ReasonBottomSheetAdmin());
  }

  logout() async {
    showLoading();
    var responseString = await Get.find<BaseClient>()
        .post(
            ApiEndPoints.logout, null, Get.find<LoginController>().getHeader())
        .catchError(handleError);

    if (responseString == null) {
      return;
    } else {
      hideLoading();
      resetControllerAndGoToLogin();
    }
  }

  fetchPayslip() async {
    showLoading();
    Get.find<BaseClient>().onError = fetchPayslip;
    var responseString = await Get.find<BaseClient>()
        .post(
            ApiEndPoints.payslip, null, Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      payslipResponseModel.value = payslipResponseModelFromJson(responseString);
      payslipResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  requestAdvanceOrSalary(bool isSalary) async {
    showLoading();

    var responseString = await Get.find<BaseClient>()
        .post(
            isSalary
                ? ApiEndPoints.requestPayment
                : ApiEndPoints.requestAdvance,
            requestAdvanceModelToJson(requestAdvanceModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      DialogHelper.showToast(
          desc: messageOnlyResponseModelFromJson(responseString).message!);
      requestAdvanceModel = RequestAdvanceModel();
      Get.back();
    }
  }
//todo add onError in getattendance as well. Don't forget '()' will not be present on function

  getDeduction() async {
    if (deductionResponseModel.value.deductions == null) {
      showLoading();
      Get.find<BaseClient>().onError = getDeduction;
      var responseString = await Get.find<BaseClient>()
          .post(ApiEndPoints.deductions, null,
              Get.find<LoginController>().getHeader())
          .catchError(handleError);
      if (responseString == null) {
        return;
      } else {
        hideLoading();
        deductionResponseModel.value =
            deductionResponseModelFromJson(responseString);
        deductionResponseModel.refresh();
        Get.find<BaseClient>().onError = null;
      }
    }
  }

  String formatNumber(String value) {
    final formatNum = NumberFormat('#.00');
    return formatNum.format(int.parse(value));
  }

  resetControllerAndGoToLogin() {
    Get.find<LoginController>().loginResponseModel = null;
    Get.find<LoginController>().userModel = UserModel();
    Get.find<SharedPreferenceHelper>().deleteAll();
    Get.offAllNamed(Routes.login);
  }

  downloadPdf(String? url) async {
    if (url != null && url.isNotEmpty) {
      sharePath = '';
      isSharingOrDownloading.value = SharingOrDownloading.downloading;
      await FlutterDownloader.enqueue(
        url: url,
        saveInPublicStorage: true,
        savedDir: '/storage/emulated/0/Download',
        showNotification: true,
        openFileFromNotification: false,
        // fileName: 'payslip.pdf',
      );
    }
  }

  sharePdf(String? url, String? type) async {
    if (type == 'pdf' || type == 'png') {
      isSharingOrDownloading.value = SharingOrDownloading.sharing;
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      if (File('$tempPath/payslip.$type').existsSync()) {
        File('$tempPath/payslip.$type').deleteSync();
      }
      sharePath = '$tempPath/payslip.$type';
      await FlutterDownloader.enqueue(
        url: url!,
        savedDir: tempPath,
        showNotification: false,
        openFileFromNotification: false,
        fileName: 'payslip.$type',
      );
    }
  }

  String? amountValidator(String value) {
    if (value.isEmpty) {
      return 'Value cannot be empty';
    } else if (int.parse(
            payslipResponseModel.value.payroll?.salary ?? '10000') <
        int.parse(value)) {
      return 'Request amount should be less than salary';
    } else if (int.parse(value) < 50) {
      return 'Request amount should be greater than 50';
    }
    return GetUtils.isLengthLessThan(value, 2) ? "Enter a valid number" : null;
  }

  String? notEmptyValidator(String value) {
    return (value.isEmpty) ? 'Value cannot be empty' : null;
  }

  void requestAdvance() {
    if (requestAdvanceFormKey.currentState!.validate()) {
      requestAdvanceFormKey.currentState!.save();
      requestAdvanceOrSalary(false);
    }
  }

  Future<void> requestQuitFromCompany() async {
    if (requestAdvanceFormKey.currentState!.validate()) {
      requestAdvanceFormKey.currentState!.save();
      if (quitCompanyReason.isNotEmpty) {
        showLoading();
        String json = jsonEncode({'requests': quitCompanyReason});
        var responseString = await Get.find<BaseClient>()
            .post(ApiEndPoints.quitCompany, json,
                Get.find<LoginController>().getHeader())
            .catchError(handleError);
        if (responseString == null) {
          return;
        } else {
          hideLoading();
          DialogHelper.showToast(desc: 'Request submitted successfully');
          Get.back();
        }
      }
    }
  }

  void requestPayment() {
    requestAdvanceModel = RequestAdvanceModel(
        amount: payslipResponseModel.value.payroll?.salary ?? '0');
    requestAdvanceOrSalary(true);
  }

  String? descriptionValidator(String value) {
    return GetUtils.isLengthLessThan(value, 5)
        ? "Enter a valid description"
        : null;
  }

  String getDate(String date) {
    final DateTime now = DateTime.parse(date);
    return DateFormat('dd-MM-yyyy').format(now);
  }

  @override
  void onReady() {
    super.onReady();
    fetchPayslip();
  }

  //for downloading

  @override
  void onInit() {
    super.onInit();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // String id = data[0];
      DownloadTaskStatus status = data[1];
      // int progress = data[2];

      //download completed
      if (status == DownloadTaskStatus.complete) {
        //Download completed from Share button
        if (isSharingOrDownloading.value == SharingOrDownloading.sharing) {
          Share.shareXFiles([XFile(sharePath)]);
          sharePath = '';
          //Download completed from download button
        } else if (isSharingOrDownloading.value ==
            SharingOrDownloading.downloading) {
          DialogHelper.showToast(desc: 'Download completed');
        }
        isSharingOrDownloading.value = SharingOrDownloading.idle;
      } else if (status == DownloadTaskStatus.failed) {
        sharePath = '';
        isSharingOrDownloading.value = SharingOrDownloading.idle;
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  void onClose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.onClose();
  }

  // onClickMenuItem(ReportsDropDown value) {
  //   if (value == ReportsDropDown.payment || value == ReportsDropDown.advance) {
  //     DialogHelper.showBottomSheet(ReportsBottomsheet(
  //       isSalary: value == ReportsDropDown.payment,
  //     ));
  //   } else if (value == ReportsDropDown.logout) {
  //     showLogoutDialog();
  //   } else {
  //     DialogHelper.showBottomSheet(const QuitCompanyBottomSheet());
  //   }
  // }
}
