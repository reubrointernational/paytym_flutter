import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paytym/models/login/user_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/constants/enums.dart';
import '../../core/dialog_helper.dart';
import '../../network/base_client.dart';
import '../../network/end_points.dart';
import '../../routes/app_routes.dart';

class ReportsController extends GetxController with BaseController {
  final ReceivePort _port = ReceivePort();
  String sharePath = '';
  final isDownloading = false.obs;
  final isSharing = false.obs;

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

  resetControllerAndGoToLogin() {
    Get.find<LoginController>().loginResponseModel = null;
    Get.find<LoginController>().userModel = UserModel();

    Get.offAllNamed(Routes.login);
  }

  downloadPdf(String url) async {
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

  sharePdf(String url) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    if (File('$tempPath/payslip.pdf').existsSync()) {
      File('$tempPath/payslip.pdf').deleteSync();
    }
    sharePath = '$tempPath/payslip.pdf';
    isSharing.value = true;
    await FlutterDownloader.enqueue(
      url: url,
      savedDir: tempPath,
      showNotification: false,
      openFileFromNotification: false,
      fileName: 'payslip.pdf',
    );
  }

  //for downlo

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
}
