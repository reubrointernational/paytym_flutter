import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paytym/models/login/user_model.dart';
import 'package:paytym/models/report/payslip_response_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/constants/enums.dart';
import '../../core/dialog_helper.dart';
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
  final reportTab = Reports.payslip.obs;
  final payslipResponseModel = PayslipResponseModel().obs;

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
    // update();
  }

  fetchPayslip() async {
    showLoading();

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
    }
  }

  resetControllerAndGoToLogin() {
    Get.find<LoginController>().loginResponseModel = null;
    Get.find<LoginController>().userModel = UserModel();

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

  getTab() {
    if (reportTab.value == Reports.payslip) {
      return const PaySlipPage();
    } else if (reportTab.value == Reports.deduction) {
      return const DeductionPage();
    } else if (reportTab.value == Reports.attendance) {
      return const AttendancePage();
    }
    return Container();
  }

  onClickMenuItem(ReportsDropDown value) {
    if (value == ReportsDropDown.payment) {
      //
    } else if (value == ReportsDropDown.advance) {
      DialogHelper.showBottomSheet(const ReportsBottomsheet());
    } else if (value == ReportsDropDown.logout) {
      logout();
    }
  }
}
