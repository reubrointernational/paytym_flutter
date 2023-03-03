import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paytym/models/report/payslip_response_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/enums.dart';
import '../../../core/constants/icons.dart';
import '../../../core/constants/strings.dart';
import '../../../core/dialog_helper.dart';
import '../../../models/report/deduction/deduction_response_model.dart';
import '../../../models/report/files/employee_files_list_model.dart';
import '../../../models/report/medical_list_admin_model.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';

class ReportsController extends GetxController
    with BaseController, GetTickerProviderStateMixin {
  final ReceivePort _port = ReceivePort();
  String sharePath = '';

  late TabController controller;
  late TabController subTabController;
  final medicalResponseModel =
      MedicalListAdminModel(message: '', extraDetails: []).obs;

  //Sharing or downloading enum will be idle at the start
  final isSharingOrDownloading = SharingOrDownloading.idle.obs;
  final payslipResponseModel = PayslipResponseModel().obs;
  final fileListResponseModel =
      EmployeeFilesListModel(files: [], message: '').obs;

  final deductionResponseModel = DeductionResponseModel().obs;

  final selectedDropdownYear = years.first.obs;
  final selectedDropdownMonth = monthsList.first.obs;
  final selectedDropdownDay = daysDummyList.first.obs;


  final RxList<int> splitPaymentAmountList = <int>[1, 0, 0].obs;

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

  getMedical() async {
    showLoading();
    var model = {
      'employer_id': '4'
      // '${Get.find<LoginController>().loginResponseModel?.employee?.employer_id}'
    };
    Get.find<BaseClient>().onError = getMedical;
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.medicalList, jsonEncode(model),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      medicalResponseModel.value =
          medicalListAdminModelFromJson(responseString);
      medicalResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  fetchFiles() async {
    if (fileListResponseModel.value.message.isEmpty) {
      showLoading();
      Get.find<BaseClient>().onError = fetchFiles;
      var requestModel = {
        'status': '0',
        //todo change employer id
        'employee_id': '3'
        // '${Get.find<LoginController>().loginResponseModel?.employee?.id}'
      };
      var responseString = await Get.find<BaseClient>()
          .post(ApiEndPoints.employeeFileList, jsonEncode(requestModel),
              Get.find<LoginController>().getHeader())
          .catchError(handleError);
      if (responseString == null) {
        return;
      } else {
        hideLoading();
        fileListResponseModel.value =
            employeeFilesListModelFromJson(responseString);
        fileListResponseModel.refresh();
        Get.find<BaseClient>().onError = null;
      }
    }
  }

  String getImagePath(int index) {
    if (index == 0) {
      return IconPath.windcavePng;
    } else if (index == 1) {
      return IconPath.mPesaPng;
    } else {
      return IconPath.myCashPng;
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

  String? notEmptyValidator(String value) {
    return (value.isEmpty) ? 'Value cannot be empty' : null;
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

    controller = TabController(length: 4, vsync: this);
    subTabController = TabController(length: 12, vsync: this);

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
    controller.dispose();
    subTabController.dispose();

    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.onClose();
  }
}
