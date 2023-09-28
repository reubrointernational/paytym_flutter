import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paytym/models/message_only_response_model.dart';
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
import '../../../models/report/file_upload_request.dart';
import '../../../models/report/files/employee_files_list_model.dart';
import '../../../models/report/files/files_type_list.dart';
import '../../../models/report/medical_list_admin_model.dart';
import '../../../models/report/overtime_list_response_model.dart';
import '../../../models/split_payment/split_payment_response.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import 'package:http/http.dart' as http;

class ReportsController extends GetxController
    with BaseController, GetTickerProviderStateMixin {
  final ReceivePort _port = ReceivePort();
  String sharePath = '';
  FilesTypeListModel filesTypeListModel =
      FilesTypeListModel(fileTypes: [], message: '');

  late TabController controller;
  late TabController subTabController;
  final medicalResponseModel =
      MedicalListAdminModel(message: '', extraDetails: []).obs;
  int clickedIndex = -1;
  final filePath = ''.obs;
  final selectedIndex = 0.obs;

  //Sharing or downloading enum will be idle at the start
  final isSharingOrDownloading = SharingOrDownloading.idle.obs;
  final payslipResponseModel = PayslipResponseModel().obs;
  final fileListResponseModel =
      EmployeeFilesListModel(files: [], message: '').obs;

  final splitAmount = [0, 0, 0].obs;
  final splitPaymentResponseModel = SplitPaymentResponseModel().obs;
  final deductionResponseModel = DeductionResponseModel().obs;
  final attendanceResponseModel = AttendanceEmployeeResponseModel().obs;
  Map<String, double> pieChartData = {
    'OnTime': 0.0,
    'Leaves': 0.0,
    'Late': 0.0,
    'EarlyOut': 0.0
  };

  final selectedDropdownYear = years[0].obs;
  final selectedDropdownMonth = monthsList[DateTime.now().month - 1].obs;
  final selectedDropdownDay = Rxn<String>();
  final dateList = <String>[].obs;

  final RxList<int> splitPaymentAmountList = <int>[1, 0, 0].obs;
  final overtimeResponseModel =
      OvertimeListResponseModel(message: '', employeeList: []).obs;

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

  getOvertime() async {
    showLoading();
    var model = {
      'employee_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.id}'
    };
    Get.find<BaseClient>().onError = getOvertime;
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.getOvertime, jsonEncode(model),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      overtimeResponseModel.value =
          overtimeListResponseModelFromJson(responseString);
      overtimeResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  Future<FilesTypeListModel?> fetchFileTypeList() async {
    Get.find<BaseClient>().onError = fetchFileTypeList;
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.fileTypeListEmployee, null,
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return null;
    } else {
      hideLoading();
      Get.find<BaseClient>().onError = null;
      filesTypeListModel = filesTypeListModelFromJson(responseString);
      return filesTypeListModel;
    }
  }

  uploadFiles() async {
    showLoading();
    var request = http.MultipartRequest(
        "POST", Uri.parse(ApiEndPoints.uploadFilesEmployee));
    FileUploadRequestModel fileUploadRequestModel = FileUploadRequestModel(
      employerId: Get.find<LoginController>()
              .loginResponseModel
              ?.employee
              ?.employerId
              .toString() ??
          '',
      fileTypeId:
          filesTypeListModel.fileTypes[selectedIndex.value].id.toString(),
      userId: Get.find<LoginController>()
          .loginResponseModel!
          .employee!
          .id
          .toString(),
      //0 for upload and 1 for delete
      status: '0',
      id: '',
    );
    request.fields.addAll(fileUploadRequestModel.toJson());
    request.headers.addAll(Get.find<LoginController>().getHeader()!);
    var multipartFile =
        await http.MultipartFile.fromPath('file', filePath.value);
    print("multipartfile:${filePath.value.toString()}");
    request.files.add(multipartFile);
    var streamResponse = await request.send();
    await http.Response.fromStream(streamResponse);
    filePath.value = '';
    hideLoading();
    DialogHelper.showToast(desc: 'File uploaded');
    Get.back();
    fetchFiles();
  }

  deleteFiles(int id) async {
    showLoading();
    Map<String, dynamic> map = {
      'id': id.toString(),
      'status': '1',
    };

    Get.find<BaseClient>().onError = fetchFileTypeList;
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.uploadFilesEmployee, jsonEncode(map),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      DialogHelper.showToast(desc: 'File deleted');
      Get.find<BaseClient>().onError = null;
      Get.find<ReportsController>().fileListResponseModel.value.files?.remove(
          Get.find<ReportsController>()
              .fileListResponseModel
              .value
              .files
              ?.firstWhere((element) => element.id == id));
      Get.find<ReportsController>().fileListResponseModel.refresh();
    }
  }

  String getSplitAmount(int index) {
    if (index == 0) {
      return '${splitPaymentResponseModel.value.splitPaymentList?[0].bank.toString() ?? '0'}%';
    } else if (index == 1) {
      return '${splitPaymentResponseModel.value.splitPaymentList?[0].mpaisa.toString() ?? '0'}%';
    } else {
      return '${splitPaymentResponseModel.value.splitPaymentList?[0].mycash.toString() ?? '0'}%';
    }
  }

  fetchFilesFromPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      filePath.value = file.path!;
    }
  }

  getSumDeductionAmount(List deductionList) {
    bool isEmpty = (Get.find<ReportsController>()
                .deductionResponseModel
                .value
                .deductions
                ?.isEmpty ??
            true) ||
        (Get.find<ReportsController>()
                .deductionResponseModel
                .value
                .deductions
                ?.first
                .assignDeduction
                ?.isEmpty ??
            true);
    if (isEmpty) {
      return 0;
    }
    final result = (deductionList as List<AssignDeduction>)
        .fold(0, (value, element) => value + (element.rate ?? 0));
    return formatNumber(result.toString());
  }

  fetchPayslip() async {
    dateList.value = [];
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
        dateList.add(DateFormat('dd-MM-yyyy').format(payroll.createdAt!));
      }
      dateList.value = dateList.toSet().toList();
      selectedDropdownDay.value = dateList.first;
      dateList.refresh();
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

  // fetchFileTypeListAndFetchFiles([int? employeeId, bool? isFromEmployee]) async {
  //   showLoading();
  //   if (filesTypeListModel.value.message.isEmpty) {
  //     Get.find<BaseClient>().onError = fetchFileTypeListAndFetchFiles;
  //     var responseString = await Get.find<BaseClient>()
  //         .post(isFromEmployee==null?ApiEndPoints.fileTypeList:ApiEndPoints.fileTypeListEmployee, null,
  //             Get.find<LoginController>().getHeader())
  //         .catchError(handleError);
  //     if (responseString == null) {
  //       return;
  //     } else {
  //       filesTypeListModel.value = filesTypeListModelFromJson(responseString);
  //       fetchFiles(filesTypeListModel.value, employeeId);
  //     }
  //   } else {
  //     fetchFiles(filesTypeListModel.value, employeeId);
  //   }
  // }

  fetchFiles([int? employeeId]) async {
    print("fetchFiles called");
    // Get.find<BaseClient>().onError = () {
    //   fetchFiles(fileTypes);
    // };
    var requestModel = {
      'status': '0',
      //0 employee, 1 for HR

      'employee_id': employeeId == null
          ? '${Get.find<LoginController>().loginResponseModel?.employee?.id}'
          : employeeId.toString()
    };
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.employeeFileList, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    hideLoading();
    if (responseString == null) {
      return;
    } else {
      print("fetchFiles Response: $responseString");
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

  setSplitPayment(BuildContext context) async {
    if (splitAmount
            .reduce((previousValue, element) => previousValue + element) ==
        100) {
      Navigator.pop(context);
      showLoading();
      //Get.find<BaseClient>().onError = setSplitPayment(index);
      var requestModel = {
        'employer_id': Get.find<LoginController>()
            .loginResponseModel!
            .employee!
            .employerId
            .toString(),
        'employee_id': Get.find<LoginController>()
            .loginResponseModel!
            .employee!
            .id
            .toString(),
        'bank': splitAmount[0],
        'mycash': splitAmount[2],
        'mpaisa': splitAmount[1],
      };
      var responseString = await Get.find<BaseClient>()
          .post(
            ApiEndPoints.splitPayment,
            jsonEncode(requestModel),
            Get.find<LoginController>().getHeader(),
          )
          .catchError(handleError);
      hideLoading();
      if (responseString == null) {
        return;
      } else {
        DialogHelper.showToast(
            desc:
                messageOnlyResponseModelFromJson(responseString).message ?? '');
        getSplitPayment();
        //Get.find<BaseClient>().onError = null;
      }
    } else {
      DialogHelper.showToast(desc: 'Total percentage should be 100');
    }
  }

  getSplitPayment() async {
    showLoading();
    //Get.find<BaseClient>().onError = setSplitPayment(index);

    var responseString = await Get.find<BaseClient>().post(
      ApiEndPoints.splitPaymentList,
      jsonEncode({
        'employer_id': Get.find<LoginController>()
            .loginResponseModel
            ?.employee
            ?.employerId
            .toString()
      }),
      Get.find<LoginController>().getHeader(),
    );
    hideLoading();
    if (responseString == null) {
      return;
    } else {
      splitPaymentResponseModel.value =
          splitPaymentResponseModelFromJson(responseString);

      splitPaymentResponseModel.refresh();

      //Get.find<BaseClient>().onError = null;
    }
  }

//todo add onError in get attendance as well. Don't forget '()' will not be present on function

  getDeduction() async {
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

  getAttendance() async {
    showLoading();
    var requestModel = {
      'employer_id':
          Get.find<LoginController>().loginResponseModel!.employee!.employerId,
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

      pieChartData = {
        "OnTime": attendanceResponseModel.value.ontime!.toDouble(),
        "Leaves": attendanceResponseModel.value.leaves!.toDouble(),
        "Late": attendanceResponseModel.value.late!.toDouble(),
        "EarlyOut": attendanceResponseModel.value.earlyout!.toDouble(),
      };
      attendanceResponseModel.refresh();
    }
  }

  String formatNumber(String value) {
    final formatNum = NumberFormat('#.00');
    return formatNum.format(int.parse(value));
  }

  Future<void> downloadPdf(String? url) async {
    print("downloadPdf called");

    // await FlutterDownloader.initialize();

    if (url != null && url.isNotEmpty) {
      sharePath = '';
      isSharingOrDownloading.value = SharingOrDownloading.downloading;
      //
      // FlutterDownloader.registerCallback((taskId, status, progress) {
      //   print('Download $taskId is enqueued');
      //   if (status == DownloadTaskStatus.enqueued) {
      //     // Download is enqueued and waiting to start
      //     print('Download $taskId is enqueued');
      //   } else if (status == DownloadTaskStatus.running) {
      //     // Download is in progress
      //     print('Download $taskId is in progress. Progress: $progress');
      //   } else if (status == DownloadTaskStatus.complete) {
      //     // Download is complete
      //     print('Download $taskId is complete!');
      //   } else if (status == DownloadTaskStatus.failed) {
      //     // Download failed
      //     print('Download $taskId has failed');
      //   } else if (status == DownloadTaskStatus.canceled) {
      //     // Download was canceled
      //     print('Download $taskId was canceled');
      //   }
      // });

      final taskId = await FlutterDownloader.enqueue(
        url: url,
        saveInPublicStorage: true,
        savedDir: await DownloadPath().getDownloadPath(),
        showNotification: true,
        openFileFromNotification: true,
        fileName: 'paytym_doc_.pdf',
      );

      print("Downloadpdf: Task id:${taskId.toString()}");

      FlutterDownloader.registerCallback((id, status, progress) {
        print("registerCallback: Task id:${id.toString()}");
        // Handle download progress or completion here
        if (status == DownloadTaskStatus.complete) {
          print('Download task $id is complete.');
        }
      });
    }
  }

  sharePdf(String? url, String? type) async {
    print("sharePdf called");
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
    FlutterDownloader.initialize();
    controller = TabController(length: 4, vsync: this);
    subTabController = TabController(length: 12, vsync: this);

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // String id = data[0];
      print('port.listen test');
      DownloadTaskStatus status = data[1];
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
        print(
            'Download completed from Share button 2 :${isSharingOrDownloading.value.toString()}');
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
        ?.send([id, status, progress]);
  }

  @override
  void onClose() {
    controller.dispose();
    subTabController.dispose();

    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.onClose();
  }
}
