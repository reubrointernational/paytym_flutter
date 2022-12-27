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

import '../../core/constants/enums.dart';
import '../../core/dialog_helper.dart';
import '../../models/message_only_response_model.dart';
import '../../network/base_client.dart';
import '../../network/end_points.dart';
import '../../routes/app_routes.dart';
import 'attendance_tab.dart';
import 'deduction_tab.dart';
import 'payslip_tab.dart';
import 'widgets/reports_bottomsheet.dart';

class ReportsController extends GetxController with BaseController {
  final ReceivePort _port = ReceivePort();
  String sharePath = '';
  final isDownloading = false.obs;
  final isSharing = false.obs;
  final payslipResponseModel = PayslipResponseModel().obs;
  final requestAdvanceFormKey = GlobalKey<FormState>();
  RequestAdvanceModel requestAdvanceModel = RequestAdvanceModel();
  final deductionResponseModel = DeductionResponseModel().obs;

  showLogoutDialog() {
    DialogHelper.showConfirmDialog(
      onConfirm: logout,
    );
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
      isDownloading.value = true;
      await FlutterDownloader.enqueue(
        url: url,
        savedDir: '/storage/emulated/0/Download',
        showNotification: false,
        openFileFromNotification: false,
        // fileName: 'payslip.pdf',
      );
    }
  }

  sharePdf(String? url, String? type) async {
    if (type == 'pdf' || type == 'png') {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      if (File('$tempPath/payslip.$type').existsSync()) {
        File('$tempPath/payslip.$type').deleteSync();
      }
      sharePath = '$tempPath/payslip.$type';
      isSharing.value = true;
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

  void requestAdvance() {
    if (requestAdvanceFormKey.currentState!.validate()) {
      requestAdvanceFormKey.currentState!.save();
      requestAdvanceOrSalary(false);
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

      if (status == DownloadTaskStatus.complete && sharePath.isNotEmpty) {
        Share.shareXFiles([XFile(sharePath)]);
        sharePath = '';
        isSharing.value = false;
      } else if (status == DownloadTaskStatus.complete && sharePath.isEmpty) {
        isDownloading.value = false;
        DialogHelper.showToast(desc: 'Download completed');
      } else if (status == DownloadTaskStatus.failed) {
        sharePath = '';
        isSharing.value = false;
        isDownloading.value = false;
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

  onClickMenuItem(ReportsDropDown value) {
    if (value == ReportsDropDown.payment) {
      DialogHelper.showBottomSheet(const ReportsBottomsheet(
        isSalary: true,
      ));
    } else if (value == ReportsDropDown.advance) {
      DialogHelper.showBottomSheet(const ReportsBottomsheet(
        isSalary: false,
      ));
    } else if (value == ReportsDropDown.logout) {
      showLogoutDialog();
    }
  }
}
