import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paytym/models/report/attendance/attendance_admin_response_model.dart';
import 'package:paytym/models/report/medical_list_admin_model.dart';
import 'package:paytym/models/report/overtime_approve_edit_request_model.dart';
import 'package:paytym/models/report/overtime_list_response_model.dart';
import 'package:paytym/models/report/payslip_response_model.dart';
import 'package:paytym/models/dashboard/request_advance_model.dart';
import 'package:paytym/models/report/projects/projects_list_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/enums.dart';
import '../../../core/constants/strings.dart';
import '../../../core/dialog_helper.dart';
import '../../../models/message_only_response_model.dart';
import '../../../models/report/attendance/attendance_accept_decline_request_model.dart';
import '../../../models/report/attendance/attendance_edit_request.dart';
import '../../../models/report/deduction/deduction_add_request_model.dart';
import '../../../models/report/deduction/deduction_list_admin_model.dart';
import '../../../models/report/file_upload_request.dart';
import '../../../models/report/files/files_type_list.dart';
import '../../../models/report/projects/project_details_model.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../../employee/dashboard/dashboard_controller.dart';
import '../chat/chat_controller.dart';
import '../widgets/reason_bottomsheet.dart';
import 'widgets/pay_payment.dart';
import 'widgets/pending_payroll_listview.dart';
import 'package:http/http.dart' as http;

//Contract period uses same api of list employee which is present in dashboard
//controller of admin session

class ReportsControllerAdmin extends GetxController with BaseController {
  final ReceivePort _port = ReceivePort();
  String sharePath = '';
  final selectedDate =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).toString().obs;
  final formKey = GlobalKey<FormState>();
  DeductionAddRequestModel deductionAddRequestModel = DeductionAddRequestModel(
    employerId: '',
    name: '',
    amount: '',
    percentage: '',
    description: '',
  );

  final fileNameDropdownIndex = 0.obs;
  final sliderValue = 0.0.obs;
  double sliderStartValue = 0;
  final projectDetails = ProjectDetailsModel().obs;

  List<String> reportsTabListAdmin = [
    'Projects',
    'Attendance',
    'Uploads',
    'Overtime',
    // 'Deduction',
    // 'Medical',
    // 'Contract period'
  ];

  List<Map<String, dynamic>> totalAttendance = [
    {
      'title': 'Present',
      'color': Colors.purple,
    },
    {
      'title': 'Late',
      'color': Colors.orange,
    },
    {
      'title': 'Absent',
      'color': Colors.pink,
    },
    {
      'title': 'Total',
      'color': Colors.indigo,
    },
  ];

  Future<void> selectDateTime(BuildContext context) async {
    DateTime startDate = DateTime.now();

    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2022),
      lastDate: startDate,
    );

    selectedDate.value =
        DateFormat('dd-MM-yyyy').format(dateTime ?? DateTime(00, 0, 0));

    getAttendance();
  }

  String getAttendanceCount(int index) {
    switch (index) {
      case 0:
        return Get.find<ReportsControllerAdmin>()
            .attendanceResponseModel
            .value
            .present
            .toString();
      case 1:
        return Get.find<ReportsControllerAdmin>()
            .attendanceResponseModel
            .value
            .late.toString();
      case 2:
        return Get.find<ReportsControllerAdmin>()
            .attendanceResponseModel
            .value
            .absent
            .toString();
      case 3:
        return Get.find<ReportsControllerAdmin>()
            .attendanceResponseModel
            .value
            .totalCount
            .toString();
      default:
        return '0';
    }
  }

  fillReportTab() {
    final capabilityList =
        Get.find<LoginController>().loginResponseModel?.capabilities;
    if (capabilityList?.first.viewPayroll == 1 &&
        !reportsTabListAdmin.contains('Payroll')) {
      reportsTabListAdmin.add('Payroll');
    }
    if (capabilityList?.first.deductions == 1 &&
        !reportsTabListAdmin.contains('Deduction')) {
      reportsTabListAdmin.add('Deduction');
    }
    if (capabilityList?.first.medical == 1 &&
        !reportsTabListAdmin.contains('Medical')) {
      reportsTabListAdmin.add('Medical');
    }
    if (capabilityList?.first.contractPeriod == 1 &&
        !reportsTabListAdmin.contains('Contract period')) {
      reportsTabListAdmin.add('Contract period');
    }
    return reportsTabListAdmin;
  }

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

  List<ExtraDetail>? getFilteredMedicalList() {
    List<ExtraDetail>? medicalList;
    if (Get.find<DashboardControllerAdmin>()
            .selectedDropdownDepartments
            .value !=
        null) {
      medicalList = medicalResponseModel.value.extraDetails
          ?.where((element) =>
              (element.users?.departmentId ?? 0) ==
              (Get.find<DashboardControllerAdmin>()
                      .deptwiseEmployeeMap[Get.find<DashboardControllerAdmin>()
                          .selectedDropdownDepartments
                          .value]
                      ?.first
                      .department
                      ?.id ??
                  0))
          .toList();
    }
    if (medicalList != null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      medicalList = medicalList.where((element) {
        return (element.users?.branchId ?? 0) ==
            (Get.find<DashboardControllerAdmin>()
                    .branchwiseEmployeeMap[Get.find<DashboardControllerAdmin>()
                        .selectedDropdownBranches
                        .value]
                    ?.first
                    .branch
                    ?.id ??
                1);
      }).toList();
    } else if (medicalList == null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      medicalList = medicalResponseModel.value.extraDetails
          ?.where((element) =>
              (element.users?.branchId ?? 0) ==
              (Get.find<DashboardControllerAdmin>()
                      .branchwiseEmployeeMap[
                          Get.find<DashboardControllerAdmin>()
                              .selectedDropdownBranches
                              .value]
                      ?.first
                      .branch
                      ?.id ??
                  0))
          .toList();
    }
    medicalList ??= medicalResponseModel.value.extraDetails;
    medicalList = medicalList
        ?.where(
          (element) =>
              element.users?.firstName?.toLowerCase().contains(
                  Get.find<DashboardControllerAdmin>()
                      .searchKeyword
                      .value
                      .toLowerCase()) ??
              false,
        )
        .toList();
    return medicalList;
  }

  List<History>? getFilteredAttendanceList() {
    List<History>? attendanceList;
    if (Get.find<DashboardControllerAdmin>()
            .selectedDropdownDepartments
            .value !=
        null) {
      attendanceList = attendanceResponseModel.value.history
          ?.where((element) =>
              (element.user?.departmentId ?? 0) ==
              (Get.find<DashboardControllerAdmin>()
                      .deptwiseEmployeeMap[Get.find<DashboardControllerAdmin>()
                          .selectedDropdownDepartments
                          .value]
                      ?.first
                      .department
                      ?.id ??
                  0))
          .toList();
    }
    if (attendanceList != null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      attendanceList = attendanceList.where((element) {
        return (element.user?.branchId ?? 0) ==
            (Get.find<DashboardControllerAdmin>()
                    .branchwiseEmployeeMap[Get.find<DashboardControllerAdmin>()
                        .selectedDropdownBranches
                        .value]
                    ?.first
                    .branch
                    ?.id ??
                1);
      }).toList();
    } else if (attendanceList == null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      attendanceList = attendanceResponseModel.value.history
          ?.where((element) =>
              (element.user?.branchId ?? 0) ==
              (Get.find<DashboardControllerAdmin>()
                      .branchwiseEmployeeMap[
                          Get.find<DashboardControllerAdmin>()
                              .selectedDropdownBranches
                              .value]
                      ?.first
                      .branch
                      ?.id ??
                  0))
          .toList();
    }
    attendanceList ??= attendanceResponseModel.value.history;
    attendanceList = attendanceList
        ?.where(
          (element) =>
              element.user?.firstName?.toLowerCase().contains(
                  Get.find<DashboardControllerAdmin>()
                      .searchKeyword
                      .value
                      .toLowerCase()) ??
              false,
        )
        .toList();
    return attendanceList;
  }

  changeSliderPosition(double value) {
    sliderValue.value = value;
  }

  sliderController() {
    if ((sliderValue.value - sliderStartValue).abs() > 95) {
      if (sliderValue.value > 95) {
        sliderValue.value = 100;
        showDialogue();
      } else if (sliderValue.value < 5) {
        sliderValue.value = 0;
        showDialogue();
      } else {
        sliderValue.value = sliderStartValue;
      }
    } else {
      sliderValue.value = sliderStartValue;
    }
  }

  showDialogue() {
    DialogHelper.showConfirmDialog(
      title: sliderValue.value == 100 ? 'Process Payroll' : 'Reverse Payroll',
      desc: sliderValue.value == 100
          ? 'Do you like to process payroll?'
          : 'Do you like to reverse process payroll?',
      onConfirm: () {
        //0 for process payroll and 1 for reverse payroll
        sliderValue.value == 100 ? processPayroll(1) : processPayroll(0);
        Get.find<DashboardControllerAdmin>().fetchEmployeeList();
      },
      onCancel: () {
        sliderValue.value = sliderValue.value == 100 ? 0 : 100;
      },
    );
  }

  final filePath = ''.obs;

  //Sharing or downloading enum will be idle at the start
  final isSharingOrDownloading = SharingOrDownloading.idle.obs;
  final payslipResponseModel = PayslipResponseModel().obs;
  final fileTypeListResponseModel = FilesTypeListModel(
          fileTypes: [FileTypes(id: 0, fileType: '')], message: '')
      .obs;
  final projectlistResponseModel =
      ProjectListModel(message: '', projectsLists: []).obs;

  RequestAdvanceModel requestAdvanceModel = RequestAdvanceModel();
  final deductionResponseModel = DeductionListAdminModel().obs;
  final overtimeResponseModel =
      OvertimeListResponseModel(message: '', employeeList: []).obs;
  final medicalResponseModel =
      MedicalListAdminModel(message: '', extraDetails: []).obs;
  final attendanceResponseModel =
      AttendanceAdminModel(message: '', history: []).obs;
  String quitCompanyReason = '';
  OvertimeApproveEditRequestModel overtimeApproveEditRequestModel =
      OvertimeApproveEditRequestModel(status: '0', id: '0');

  final selectedDepartment = departments.first.obs;
  final selectedBranch = branches.first.obs;

  final selectedDropdownYear = years.first.obs;
  final payrollClickedButton = 0.obs;

  final chatGroupList = dummy_data.obs;
  int selectedItemIndex = 0;
  String projectName = '';
  final projectDetailsResponseModel =
      ProjectDetailsModel(message: '', projectsListe: []).obs;
  double endProjectStatus = 0;
  double currentProjectStatus = 0;
  double projectPercentage = 0;

  TextEditingController checkInTimeController = TextEditingController();
  TextEditingController checkOutTimeController = TextEditingController();

  // Edit attendance for HR
  final editAttendanceDate = ''.obs;
  final editAttendanceCheckInTime = ''.obs;
  final editAttendanceCheckOutTime = ''.obs;
  final editAttendanceReason = ''.obs;

  // final projectDetailsResponseModel = ProjectDetailsModel(message: '', projectsListe: []).obs;

//for bottomsheet
  showBottomSheetForReason(ReasonButton reasonButton) {
    DialogHelper.showBottomSheet(ReasonBottomSheetAdmin(
      reasonButton: reasonButton,
    ));
  }

  String getTime(String? dateTime) {
    if (dateTime == null) return '-';
    DateTime? dt = DateTime.parse(dateTime);
    return DateFormat.jm().format(dt);
  }

  fetchFileTypeList() async {
    showLoading();
    Get.find<BaseClient>().onError = fetchFileTypeList;
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.fileTypeList, null,
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      fileTypeListResponseModel.value =
          filesTypeListModelFromJson(responseString);
      fileTypeListResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  fetchFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      filePath.value = file.path!;
    }
  }

  uploadFiles() async {
    showLoading();
    var request =
        http.MultipartRequest("POST", Uri.parse(ApiEndPoints.uploadFiles));
    FileUploadRequestModel fileUploadRequestModel = FileUploadRequestModel(
      employerId: Get.find<LoginController>()
              .loginResponseModel
              ?.employee
              ?.employerId
              .toString() ??
          '',
      fileTypeId: fileNameDropdownIndex.value.toString(),
      userId: Get.find<LoginController>()
              .loginResponseModel
              ?.employee
              ?.id
              .toString() ??
          '',
      status: '0',
      id: '4',
    );
    request.fields.addAll(fileUploadRequestModel.toJson());
    request.headers.addAll(Get.find<LoginController>().getHeader()!);
    var multipartFile =
        await http.MultipartFile.fromPath('file', filePath.value);
    request.files.add(multipartFile);
    var streamResponse = await request.send();
    var response = await http.Response.fromStream(streamResponse);
    hideLoading();
    DialogHelper.showToast(desc: 'File uploaded');
  }

  fetchProjects() async {
    showLoading();
    Get.find<BaseClient>().onError = fetchProjects;
    var requestModel = {
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
    };
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.projectsList, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    hideLoading();
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      projectlistResponseModel.value = projectListModelFromJson(responseString);
      projectlistResponseModel.refresh();

      Get.find<BaseClient>().onError = null;
    }
  }

  findProjectProgress(String startDate, String endDate) {
    DateTime startDateTime =
        startDate.isEmpty ? DateTime.now() : DateTime.parse(startDate);
    DateTime endDateTime =
        endDate.isEmpty ? DateTime.now() : DateTime.parse(endDate);
    DateTime currentDateTime = DateTime.now();
    Duration differenceStartToEnd = endDateTime.difference(startDateTime);
    Duration differenceStartToCurrent =
        currentDateTime.difference(startDateTime);
    endProjectStatus = differenceStartToEnd.inHours.isEqual(0)
        ? differenceStartToEnd.inHours.toDouble()
        : double.parse(differenceStartToEnd.toString().substring(0, 4));
    currentProjectStatus = differenceStartToCurrent.inHours.isEqual(0)
        ? differenceStartToCurrent.inHours.toDouble()
        : double.parse(differenceStartToCurrent.toString().substring(0, 4));
    findProjectPercentage();
  }

  findProjectPercentage() {
    double minValue = 0;
    double maxValue = endProjectStatus;
    double midValue = currentProjectStatus;
    double progress = ((midValue - minValue) * 100) / (maxValue - minValue);
    projectPercentage = progress.floorToDouble();
  }

  getStatus(int status) {
    if (status == 0) {
      return 'ongoing';
    } else if (status == 1) {
      return 'onhold';
    }
    return 'Completed';
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

  getOvertime() async {
    showLoading();
    var model = {
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
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

  approveOrDeclineOvertime(int index, ReasonButton reasonButton) async {
    if (reasonButton == ReasonButton.overtimeEdit) {
      if (Get.find<DashboardController>()
          .requestAdvanceFormKey
          .currentState!
          .validate()) {
        Get.find<DashboardController>()
            .requestAdvanceFormKey
            .currentState!
            .save();
      } else {
        return;
      }
    }

    showLoading();
    if (reasonButton == ReasonButton.overtimeApprove) {
      //approve
      overtimeApproveEditRequestModel.status = '1';
    } else if (reasonButton == ReasonButton.overtimeDecline) {
      //decline
      overtimeApproveEditRequestModel.status = '2';
    } else {
      //edit
      overtimeApproveEditRequestModel.status = '3';
      overtimeApproveEditRequestModel.employerId =
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}';
      //date is obtained from dashboard controller as bottomsheet fills dashboard controller
      overtimeApproveEditRequestModel.date =
          Get.find<DashboardController>().overtimeApproveEditRequestModel.date;

      //reason is obtained from dashboard controller as bottomsheet fills dashboard controller
      overtimeApproveEditRequestModel.reason = Get.find<DashboardController>()
          .overtimeApproveEditRequestModel
          .reason;

      //totalHours is obtained from dashboard controller as bottomsheet fills dashboard controller
      overtimeApproveEditRequestModel.totalHours =
          Get.find<DashboardController>()
              .overtimeApproveEditRequestModel
              .totalHours;
    }
    overtimeApproveEditRequestModel.id =
        overtimeResponseModel.value.employeeList[index].id.toString();

    var responseString = await Get.find<BaseClient>()
        .post(
            ApiEndPoints.approveOvertime,
            overtimeApproveEditRequestModelToJson(
                overtimeApproveEditRequestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      //close bottomsheet if editing
      if (reasonButton == ReasonButton.overtimeEdit) Get.back();
      //reset bottomsheet values
      Get.find<DashboardController>().overtimeApproveEditRequestModel =
          OvertimeApproveEditRequestModel(status: '0', id: '0');
      Get.find<DashboardController>().overtimeTextEditingController =
          TextEditingController();
      DialogHelper.showToast(
          desc: messageOnlyResponseModelFromJson(responseString).message ?? '');
    }
  }

  getDeduction() async {
    showLoading();
    var model = {
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
    };
    Get.find<BaseClient>().onError = getDeduction;
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.deductionsList, jsonEncode(model),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      deductionResponseModel.value =
          deductionListAdminModelFromJson(responseString);
      deductionResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  createDeduction() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoading();
      //todo - id should be there to know which employee
      deductionAddRequestModel.employerId =
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}';
      var responseString = await Get.find<BaseClient>()
          .post(
              ApiEndPoints.deductionAdd,
              deductionAddRequestModelToJson(deductionAddRequestModel),
              Get.find<LoginController>().getHeader())
          .catchError(handleError);
      hideLoading();
      if (responseString == null) {
        return;
      } else {
        await getDeduction();
        Get.back();
        deductionAddRequestModel = DeductionAddRequestModel(
          employerId: '',
          name: '',
          amount: '',
          percentage: '',
          description: '',
        );
      }
    }
  }

  deleteDeduction(int index) async {
    showLoading();
    var requestModel = {
      'id': '${deductionResponseModel.value.deductions?[index].id}'
    };

    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.deductionDelete, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    hideLoading();
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      deductionResponseModel.value.deductions?.removeAt(index);
      deductionResponseModel.refresh();
    }
  }

  getMedical() async {
    showLoading();
    var model = {
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

  approveOrDeclineAttendance(ReasonButton reasonButton) async {
    showLoading();
    final model = AttendanceAcceptDeclineRequestModel(
        employeeId: attendanceResponseModel
                .value.history?[selectedItemIndex].userId
                .toString() ??
            '',
        reason: 'ddd',
        approvalStatus:
            reasonButton == ReasonButton.attendanceApprove ? '0' : '1',
        startDate: DateFormat('yyyy-MM-dd').format(
            attendanceResponseModel.value.history?[selectedItemIndex].date ??
                DateTime(0, 0, 0)));
    var responseString = await Get.find<BaseClient>()
        .post(
            ApiEndPoints.attendanceAcceptReject,
            attendanceAcceptDeclineRequestModelToJson(model),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      DialogHelper.showToast(
          desc: messageOnlyResponseModelFromJson(responseString).message ?? '');
    }
  }

  getAttendance() async {
    showLoading();
    Get.find<BaseClient>().onError = getAttendance;
    final date = selectedDate.value;
    final rev = date.split('-');
    Map<String, dynamic> attendanceRequestModel = {
      'date': '${rev[2]}-${rev[1]}-${rev[0]}',
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
    };

    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.attendance, jsonEncode(attendanceRequestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    hideLoading();
    if (responseString == null) {
      return;
    } else {
      attendanceResponseModel.value =
          attendanceAdminModelFromJson(responseString);
      attendanceResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  updateAttendance() async {
    showLoading();
    AttendanceEditRequestModel attendanceEditRequestModel =
        AttendanceEditRequestModel(
            employeeId: "5",
            date: selectedDate.value,
            checkIn: editAttendanceCheckInTime.value,
            checkOut: editAttendanceCheckOutTime.value,
            reason: editAttendanceReason.value);

    var responseString = await Get.find<BaseClient>()
        .post(
          ApiEndPoints.attendanceEdit,
          attendanceEditRequestModelToJson(attendanceEditRequestModel),
          Get.find<LoginController>().getHeader(),
        )
        .catchError(handleError);
    hideLoading();
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

  String? amountValidator(String value) {
    if (value.isEmpty) {
      return 'Value cannot be empty';

      // } else if (int.parse(
      //         payslipResponseModel.value.payroll?.salary ?? '10000') <
      //     int.parse(value)) {
      //   return 'Request amount should be less than salary';
    } else if (int.parse(value) < 50) {
      return 'Request amount should be greater than 50';
    }
    return GetUtils.isLengthLessThan(value, 2) ? "Enter a valid number" : null;
  }

  String? notEmptyValidator(String value) {
    return (value.isEmpty) ? 'Value cannot be empty' : null;
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

  void processPayroll(payrollStatus) async {
    showLoading();
    var requestModel = {
      'payroll_status': payrollStatus.toString(),
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
    };
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.processPayroll, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      DialogHelper.showToast(
          desc: messageOnlyResponseModelFromJson(responseString).message ?? '');
      Get.back();
    }
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
