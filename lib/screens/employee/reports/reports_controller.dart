import 'dart:collection';
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
import '../../../core/download_path.dart';
import '../../../models/report/attendance/attendance_employee_response.dart';
import '../../../models/report/deduction/deduction_response_model.dart';
import '../../../models/report/files/employee_files_list_model.dart';
import '../../../models/report/files/files_type_list.dart';
import '../../../models/report/medical_list_admin_model.dart';
import '../../../models/split_payment/split_payment_response.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';

class ReportsController extends GetxController
    with BaseController, GetTickerProviderStateMixin {
  final ReceivePort _port = ReceivePort();
  String sharePath = '';
  final filesTypeListModel = FilesTypeListModel(fileTypes: [], message: '').obs;

  late TabController controller;
  late TabController subTabController;
  final medicalResponseModel =
      MedicalListAdminModel(message: '', extraDetails: []).obs;
  int clickedIndex = -1;

  //Sharing or downloading enum will be idle at the start
  final isSharingOrDownloading = SharingOrDownloading.idle.obs;
  final payslipResponseModel = PayslipResponseModel().obs;
  final fileListResponseModel =
      EmployeeFilesListModel(files: [], message: '').obs;

  final splitAmount = ''.obs;
  final splitPaymentResponseModel = SplitPaymentResponseModel().obs;
  final deductionResponseModel = DeductionResponseModel().obs;
  final attendanceResponseModel = AttendanceEmployeeResponseModel().obs;
  Map<String, double> pieChartData = {'': 2};

  final selectedDropdownYear = years[0].obs;
  final selectedDropdownMonth = monthsList[DateTime.now().month - 1].obs;
  final selectedDropdownDay = Rxn<String>();
  List<String> dateList = [];

  final RxList<int> splitPaymentAmountList = <int>[1, 0, 0].obs;

  String getMedicalDetails(int index) {
    switch (index) {
      case 0:
        return medicalResponseModel.value.extraDetails?.first.medicalIssues ??
            '';
      case 1:
        return medicalResponseModel.value.extraDetails?.first.allergies ?? '';
      case 2:
        return medicalResponseModel.value.extraDetails?.first.bloodGrp ?? '';
      case 3:
        return medicalResponseModel.value.extraDetails?.first.measurement ?? '';

      default:
        return '';
    }
  }

  fetchPayslip() async {
    showLoading();
    final map = {
      'year': selectedDropdownYear.value,
      'month': (monthsList.indexOf(selectedDropdownMonth.value) + 1).toString()
    };

    Get.find<BaseClient>().onError = fetchPayslip;
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.payslip, jsonEncode(map),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      payslipResponseModel.value = payslipResponseModelFromJson(responseString);
      payslipResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
      for (Payroll payroll in payslipResponseModel.value.payroll ?? []) {
        dateList.add(DateFormat('dd-MM-yyyy').format(payroll.endDate!));
      }
      selectedDropdownDay.value = dateList.first;
    }
  }

  getMedical() async {
    showLoading();
    var model = {
      'employee_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.id}',
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
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

  fetchFileTypeListAndFetchFiles([int? employeeId]) async {
    showLoading();
    if (filesTypeListModel.value.message.isEmpty) {
      Get.find<BaseClient>().onError = fetchFileTypeListAndFetchFiles;
      var responseString = await Get.find<BaseClient>()
          .post(ApiEndPoints.fileTypeList, null,
              Get.find<LoginController>().getHeader())
          .catchError(handleError);
      if (responseString == null) {
        return;
      } else {
        filesTypeListModel.value = filesTypeListModelFromJson(responseString);
        fetchFiles(filesTypeListModel.value, employeeId);
      }
    } else {
      fetchFiles(filesTypeListModel.value, employeeId);
    }
  }

  fetchFiles(FilesTypeListModel fileTypes, [int? employeeId]) async {
    Get.find<BaseClient>().onError = () {
      fetchFiles(fileTypes);
    };
    var requestModel = {
      'status': '0',
      //0 employee, 1 for HR

      'employee_id':
          employeeId == null?'${Get.find<LoginController>().loginResponseModel?.employee?.id}':employeeId.toString()
    };
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.employeeFileList, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    hideLoading();
    if (responseString == null) {
      return;
    } else {
      fileListResponseModel.value =
          employeeFilesListModelFromJson(responseString);
      fileListResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  String getImagePath(int index) {
    if (index == 1) {
      return IconPath.mPesaPng;
    } else {
      return IconPath.myCashPng;
    }
  }

  setSplitPayment(index) async {
    showLoading();
    //Get.find<BaseClient>().onError = setSplitPayment(index);
    var requestModel = {
      'employer_id': Get.find<LoginController>()
          .loginResponseModel!
          .employee!
          .employerId
          .toString(),
      'employee_id': '2',
      'amount': splitAmount.value,
      'payment_wallet': index.toString(),
    };
    var responseString = await Get.find<BaseClient>()
        .post(
          ApiEndPoints.splitPayment,
          jsonEncode(requestModel),
          Get.find<LoginController>().getHeader(),
        )
        .catchError(handleError);

    if (responseString == null) {
      return;
    } else {
      hideLoading();
      splitPaymentResponseModel.value =
          splitPaymentResponseModelFromJson(responseString);
      splitPaymentResponseModel.refresh();
      //Get.find<BaseClient>().onError = null;
    }
  }

//todo add onError in get attendance as well. Don't forget '()' will not be present on function

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

  getAttendance() async {
    if (attendanceResponseModel.value.history == null) {
      showLoading();
      var requestModel = {
        'employer_id': Get.find<LoginController>()
            .loginResponseModel!
            .employee!
            .employerId,
        'date': DateTime.now.toString(),
      };

      var responseString = await Get.find<BaseClient>()
          .post(
            ApiEndPoints.employeeAttendance,
            jsonEncode(requestModel),
            Get.find<LoginController>().getHeader(),
          )
          .catchError(handleError);

      if (responseString == null) {
        return;
      } else {
        hideLoading();
        attendanceResponseModel.value =
            attendanceEmployeeResponseModelFromJson(responseString);
        //print(attendanceResponseModel.value.ontime);
        attendanceResponseModel.refresh();

        pieChartData = {
          "OnTime": attendanceResponseModel.value.ontime + .0,
          "Leaves": attendanceResponseModel.value.leaves + .0,
          "Late": attendanceResponseModel.value.late + .0,
          "EarlyOut": attendanceResponseModel.value.earlyout + .0,
        };
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
        savedDir: await DownloadPath().getDownloadPath(),
        showNotification: true,
        openFileFromNotification: false,
        // fileName: 'paytym_doc_.pdf',
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

  String getTime(String date) {
    final DateTime now = DateTime.parse(date);
    return DateFormat('hh:mm a').format(now);
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

      DownloadTaskStatus status = DownloadTaskStatus(data[1] as int);
      // int progress = data[2];

      //download completed
      if (status == DownloadTaskStatus.complete) {
        //Download completed from Share button
        print('Download completed from Share button');
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
    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status.value, progress]);
  }

  @override
  void onClose() {
    controller.dispose();
    subTabController.dispose();

    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.onClose();
  }
}
