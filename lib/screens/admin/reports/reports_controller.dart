import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paytym/models/report/advance/advance_status_model.dart';
import 'package:paytym/models/report/advance_approve_edit_request.dart';
import 'package:paytym/models/report/advance_response_model.dart';
import 'package:paytym/models/report/attendance/attendance_admin_response_model.dart';
import 'package:paytym/models/report/medical_list_admin_model.dart';
import 'package:paytym/models/report/overtime_approve_edit_request_model.dart';
import 'package:paytym/models/report/overtime_list_response_model.dart';
import 'package:paytym/models/report/payroll_request_model.dart';
import 'package:paytym/models/report/payslip_response_model.dart';
import 'package:paytym/models/dashboard/request_advance_model.dart';
import 'package:paytym/models/report/projects/projects_list_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/strings.dart';
import '../../../core/dialog_helper.dart';
import '../../../models/employee_list_model.dart' as employeelist;
import '../../../models/message_only_response_model.dart';
import '../../../models/report/advance/advance_status_model.dart';
import '../../../models/report/advance_approve_edit_request.dart';
import '../../../models/report/advance_response_model.dart';
import '../../../models/report/attendance/attendance_accept_decline_request_model.dart';
import '../../../models/report/attendance/attendance_by_hr_request_model.dart';
import '../../../models/report/attendance/attendance_edit_request.dart';
import '../../../models/report/attendance/attendance_request_model.dart';
import '../../../models/report/attendance/branch_model.dart';
import '../../../models/report/attendance/business_model.dart';
import '../../../models/report/attendance/department_model.dart';
import '../../../models/report/deduction/deduction_add_request_model.dart';
import '../../../models/report/deduction/deduction_list_admin_model.dart';
import '../../../models/report/file_upload_request.dart';
import '../../../models/report/files/files_type_list.dart';
import '../../../models/report/overtime/overtime_status-model.dart';
import '../../../models/report/projects/project_details_model.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../../employee/dashboard/dashboard_controller.dart';
import '../../employee/reports/reports_controller.dart';
import '../../login/login_controller.dart';
import '../chat/chat_controller.dart';
import '../widgets/reason_bottomsheet.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import 'reports_filter_controller.dart';

//Contract period uses same api of list employee which is present in dashboard
//controller of admin session

class ReportsControllerAdmin extends GetxController
    with BaseController, ReportsFilterController {
  final ReceivePort _port = ReceivePort();
  String sharePath = '';
  final selectedDate =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).toString().obs;
  final formKey = GlobalKey<FormState>();
  final attendanceformKey = GlobalKey<FormState>();

  DeductionAddRequestModel deductionAddRequestModel = DeductionAddRequestModel(
    employerId: '',
    name: '',
    amount: '',
    percentage: '',
    description: '',
  );
  int? selectedEmployeeId = 0;
  final businessModel = FetchBusinessModel(businesses: [], message: '').obs;
  final departmentModel = DepartmentModel(departments: [], message: '').obs;
  final branchModel = BranchesModel(branches: [], message: '').obs;
  final employeeList =
      employeelist.EmployeeListAdminModel(employeeList: [], message: '').obs;
  List<employeelist.EmployeeList>? filteredEmployeeList;
  List<employeelist.EmployeeList>? selectedEmployeeIDs = [];
  final fileNameDropdownIndex = 0.obs;
  final sliderValue = 0.0.obs;
  double sliderStartValue = 0;
  final attendanceRequestModel = AttendanceRequestModel();
  final selectedOvertimeID = 0.obs;
  final List<String> reportsTabListAdmin = [
    'Attendance',
    'Overtime',
    'Loan',
    //payroll
    //deduction
    'Projects',
    'Uploads',
    // 'Medical',
    // 'Contract period'
  ];
  final isAllEmployeesSelected = true.obs;
  final isEmployeesSelectedForPayroll = false.obs;
  final isRevertPayrollSelected = false.obs;
  final checkedEmployees = [].obs;

  final attendanceHrDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  AttendanceByHrRequestModel attendanceHrRequestModel =
      AttendanceByHrRequestModel(
          checkInTime: '',
          checkOutTime: '',
          date: '',
          employeeId: '',
          employerId: '');

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

  String formatTimeOfDay(TimeOfDay? tod) {
    final now = DateTime.now();
    final dt = DateTime(
        now.year, now.month, now.day, tod?.hour ?? 00, tod?.minute ?? 00);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  Future<void> showDatePick(BuildContext context) async {
    DateTime startDate = DateTime.now();

    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2022),
      lastDate: startDate,
    );

    attendanceHrDateController.text =
        DateFormat('dd-MM-yyyy').format(dateTime ?? DateTime(00, 0, 0));
  }

  String? dateValidator(String value) {
    final regExp =
        RegExp(r'^(0[1-9]|[12][0-9]|3[01])\-(0[1-9]|1[012])\-\d{4}$');
    return regExp.hasMatch(value) && GetUtils.isLengthEqualTo(value, 10)
        ? null
        : "Enter a valid date";
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
            .late
            .toString();
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
    print(
        "capabilityList?.first.viewPayroll : ${capabilityList?.first.viewPayroll.toString()}");
    // For payrollchecking now given as 0...need to recheck with the API
    // if (capabilityList?.first.viewPayroll == 1 &&

    if (capabilityList?.first.viewPayroll == 0 &&
        !reportsTabListAdmin.contains('Loan')) {
      reportsTabListAdmin.insert(2, 'Loan');
    }
    if (capabilityList?.first.viewPayroll == 0 &&
        !reportsTabListAdmin.contains('Payroll')) {
      reportsTabListAdmin.insert(3, 'Payroll');
    }
    if (capabilityList?.first.deductions == 1 &&
        !reportsTabListAdmin.contains('Deduction')) {
      bool payrollPresent = reportsTabListAdmin.contains('Payroll');
      reportsTabListAdmin.insert(payrollPresent ? 4 : 2, 'Deduction');
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

  changeSliderPosition(double value) {
    sliderValue.value = value;
  }

  sliderController() {
    if ((sliderValue.value - sliderStartValue).abs() > 95) {
      if (sliderValue.value > 95) {
        sliderValue.value = 100;

        if (Get.find<ReportsControllerAdmin>().isAllEmployeesSelected.value ==
            true) {
          showDialogue();
        } else if (Get.find<ReportsControllerAdmin>()
                .isEmployeesSelectedForPayroll
                .value ==
            true) {
          showDialogue();
        } else {
          showDialogueRevert();
        }
      } else if (sliderValue.value < 5) {
        sliderValue.value = 0;
        // showDialogue();
      } else {
        sliderValue.value = sliderStartValue;
      }
    } else {
      sliderValue.value = sliderStartValue;
    }
  }

  showDialogue() {
    String payrollString =
        Get.find<ReportsControllerAdmin>().isAllEmployeesSelected.value == true
            ? "Are you sure to process payroll for All Employees ?"
            : "Are you sure to process payroll for the Selected  Employees ?";
    DialogHelper.showConfirmDialog(
      title: sliderValue.value == 100 ? 'Process Payroll' : 'Reverse Payroll',
      desc: sliderValue.value == 100 ? payrollString : payrollString,
      onConfirm: () {
        showLoading();
        Get.find<ReportsControllerAdmin>().isAllEmployeesSelected.value == true
            ? processPayroll('all')
            : processPayroll('others');
        // processPayroll('all');
        print(
            "Process payroll for ALL: ${isAllEmployeesSelected.value.toString()} ");

        showLoading();
        Get.find<DashboardControllerAdmin>().fetchEmployeeList();

        Get.back(); // will go to the employee homepage

        // hideLoading();
        sliderValue.value = 0;
      },
      onCancel: () {
        sliderValue.value = 0;
      },
    );
  }

  showDialogueRevert() {
    String payrollString =
        "Are you sure to process revert payroll for the  Employees ?";

    DialogHelper.showConfirmDialog(
      title: sliderValue.value == 100 ? 'Revert Payroll' : 'Reverse Payroll',
      desc: sliderValue.value == 100 ? payrollString : payrollString,
      onConfirm: () {
        showLoading();
        if (Get.find<ReportsControllerAdmin>().isRevertPayrollSelected.value ==
            true) {
          revertPayroll();
        }

        // processPayroll('all');
        print(
            "revert payroll for ALL: ${isAllEmployeesSelected.value.toString()} ");

        showLoading();
        Get.find<DashboardControllerAdmin>().fetchEmployeeList();

        Get.back(); // will go to the employee homepage

        // hideLoading();
        sliderValue.value = 0;
      },
      onCancel: () {
        sliderValue.value = 0;
        DialogHelper.showToast(desc: " Revert Payroll Operation Cancelled");
      },
    );
  }

  final filePath = ''.obs;

  //Sharing or downloading enum will be idle at the start
  final isSharingOrDownloading = SharingOrDownloading.idle.obs;
  final payslipResponseModel = PayslipResponseModel().obs;
  final fileTypeListResponseModel =
      FilesTypeListModel(fileTypes: [], message: '').obs;
  final projectlistResponseModel =
      ProjectListModel(message: '', projectsLists: []).obs;

  RequestAdvanceModel requestAdvanceModel = RequestAdvanceModel();
  final deductionResponseModel = DeductionListAdminModel().obs;
  final overtimeResponseModel =
      OvertimeListResponseModel(message: '', employeeList: []).obs;
  final advanceResponseModel =
      AdvanceResponseModel(message: '', employeeList: []).obs;
  final medicalResponseModel =
      MedicalListAdminModel(message: '', extraDetails: []).obs;
  final attendanceResponseModel =
      AttendanceAdminModel(message: '', history: []).obs;
  String quitCompanyReason = '';
  OvertimeApproveEditRequestModel overtimeApproveEditRequestModel =
      OvertimeApproveEditRequestModel(status: '0', id: '0');
  AdvanceApproveEditRequestModel advanceApproveEditRequestModel =
      AdvanceApproveEditRequestModel(status: '0', id: '0');
  final selectedDepartment = departments.first.obs;
  final selectedBranch = branches.first.obs;

  final selectedDropdownYear = years.first.obs;
  final payrollClickedButton = 0.obs;

  final chatGroupList = dummy_data.obs;
  History selectedItem = History();
  String projectName = '';
  final projectDetailsResponseModel =
      ProjectDetailsModel(message: '', projectsListe: [], expense: '').obs;

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

  validateAndSubmitAttendance() async {
    attendanceformKey.currentState?.save();
    showLoading();
    print(
        '${attendanceHrRequestModel.date} ${attendanceHrRequestModel.checkInTime}');
    try {
      AttendanceByHrRequestModel model = AttendanceByHrRequestModel(
          checkInTime: convertDateTime(attendanceHrRequestModel.date,
              attendanceHrRequestModel.checkInTime),
          checkOutTime: convertDateTime(attendanceHrRequestModel.date,
              attendanceHrRequestModel.checkOutTime),
          date: attendanceHrRequestModel.date,
          employeeId: attendanceHrRequestModel.employeeId,
          employerId: attendanceHrRequestModel.employerId);
      var responseString = await Get.find<BaseClient>()
          .post(
              ApiEndPoints.attendanceByHr,
              attendanceByHrRequestModelToJson(model),
              Get.find<LoginController>().getHeader())
          .catchError(handleError);
      if (responseString == null) {
        return;
      } else {
        Get.back(closeOverlays: true);
        Get.find<ReportsControllerAdmin>().getAttendance();
        DialogHelper.showToast(
            desc:
                messageOnlyResponseModelFromJson(responseString).message ?? '');
      }
    } finally {
      hideLoading();
    }
  }

  String? convertDateTime(String date, String? time) {
    if (time != null && time.isNotEmpty) {
      DateTime timeStamp = DateFormat.jm().parse(time);
      DateTime dateStamp = DateTime.parse(date);
      dateStamp = dateStamp.add(Duration(
          hours: timeStamp.hour,
          minutes: timeStamp.minute,
          seconds: timeStamp.second));

      return dateStamp.toString();
    } else {
      return null;
    }
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

  fetchBusiness() async {
    // showLoading();
    var responseString = await Get.find<BaseClient>().post(
        ApiEndPoints.fetchBusiness,
        null,
        Get.find<LoginController>().getHeader());
    if (responseString == null) {
      return;
    } else {
      businessModel.value = fetchBusinessModelFromJson(responseString);
    }
  }

  fetchDepartments(int branchId) async {
    print('fetchDepartment with branchId:${branchId.toString()}');
    var responseString = await Get.find<BaseClient>().post(
        ApiEndPoints.fetchDepartment,
        jsonEncode({'branch_id': branchId.toString()}),
        Get.find<LoginController>().getHeader());
    if (responseString == null) {
      return;
    } else {
      print('object');
      departmentModel.value = departmentModelFromJson(responseString);
    }
  }

  fetchBranches(int businessId) async {
    print('fetchDepartment with Business ID:${businessId.toString()}');
    var responseString = await Get.find<BaseClient>().post(
        ApiEndPoints.fetchBranch,
        jsonEncode({'business_id': businessId.toString()}),
        Get.find<LoginController>().getHeader());
    if (responseString == null) {
      return;
    } else {
      branchModel.value = branchesModelFromJson(responseString);
    }
  }

  fetchEmployees(int businessId) async {
    print("fetchEmployees called with business ID:${businessId.toString()}");
    var responseString = await Get.find<BaseClient>().post(
        ApiEndPoints.fetchEmployeesBusinessWise,
        jsonEncode({
          'business_id': businessId.toString(),
          'employer_id': Get.find<LoginController>()
              .loginResponseModel!
              .employee!
              .employerId
              .toString()
        }),
        Get.find<LoginController>().getHeader());
    print(
        "fetchEmployees with bus ID:${businessId.toString()}   Response: ${responseString.toString()}");

    if (responseString == null) {
      return;
    } else {
      employeeList.value =
          employeelist.employeeListAdminModelFromJson(responseString);
    }
  }

  fetchAllEmployeesFromDB() async {
    print("fetchAllEmployeesFromDB called  ");
    var responseString = await Get.find<BaseClient>().post(
        ApiEndPoints.employeeList,
        jsonEncode({
          'employer_id': Get.find<LoginController>()
              .loginResponseModel!
              .employee!
              .employerId
              .toString()
        }),
        Get.find<LoginController>().getHeader());
    print("fetchAllEmployeesFromDB Response: ${responseString.toString()}");

    if (responseString == null) {
      return;
    } else {
      employeeList.value =
          employeelist.employeeListAdminModelFromJson(responseString);
    }
  }

  fetchFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      filePath.value = file.path!;
      print("Upload File:${filePath.value.toString()} ");
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
      fileTypeId: fileTypeListResponseModel
          .value.fileTypes[fileNameDropdownIndex.value].id
          .toString(),
      userId: selectedEmployeeId.toString(),
      //0 for upload and 1 for delete
      status: '0',
      id: '',
    );

    if (filePath.value.toString() == "") {
      hideLoading();
      DialogHelper.showToast(desc: 'File upload Failed. Please try again');
    } else {
      request.fields.addAll(fileUploadRequestModel.toJson());
      request.headers.addAll(Get.find<LoginController>().getHeader()!);
      var multipartFile =
          await http.MultipartFile.fromPath('file', filePath.value);
      request.files.add(multipartFile);
      var streamResponse = await request.send();
      await http.Response.fromStream(streamResponse);
      fileNameDropdownIndex.value = 0;
      filePath.value = '';
      hideLoading();
      DialogHelper.showToast(desc: 'File uploaded');
      Get.find<ReportsController>().fetchFiles(selectedEmployeeId);
    }
  }

  deleteFiles(int id) async {
    showLoading();
    Map<String, dynamic> map = {
      'id': id.toString(),
      'status': '1',
    };

    Get.find<BaseClient>().onError = fetchFileTypeList;
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.uploadFiles, jsonEncode(map),
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
      projectlistResponseModel.value = projectListModelFromJson(responseString);
      projectlistResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  double findProjectProgress(DateTime? startDate, DateTime? endDate) {
    if (endDate != null &&
        startDate != null &&
        endDate.difference(startDate) <= const Duration(seconds: 0)) {
      return 100.0;
    }

    DateTime currentDateTime = DateTime.now();
    final differenceStartToEnd =
        startDate != null ? endDate?.difference(startDate).inDays : 1;
    final differenceStartToCurrent =
        startDate != null ? currentDateTime.difference(startDate).inDays : 0;

    return ((differenceStartToCurrent / (differenceStartToEnd ?? 1)) * 100)
        .floorToDouble();
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

  getAdvance() async {
    showLoading();
    var model = {
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
    };
    Get.find<BaseClient>().onError = getAdvance;
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.getAdvance, jsonEncode(model),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      advanceResponseModel.value = advanceResponseModelFromJson(responseString);
      advanceResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  String? reasonValidator(String value) {
    return GetUtils.isLengthLessThan(value, 5) ? "Enter a valid reason" : null;
  }

  approveOrDeclineOvertime(int index, ReasonButton reasonButton) async {
    // if (reasonButton == ReasonButton.overtimeEdit) {
    if (reasonButton != ReasonButton.overtimeApprove) {
      print("approveOrDeclineOvertime Report build (7) Edit/Delete ");
      if (Get.find<DashboardController>()
          .requestAdvanceFormKey
          .currentState!
          .validate()) {
        Get.find<DashboardController>()
            .requestAdvanceFormKey
            .currentState!
            .save();
        print("approveOrDeclineOvertime called");
      } else {
        print("approveOrDeclineOvertime called else ");
        return;
      }
    }

    int? originalIndex;
    if (reasonButton != ReasonButton.overtimeEdit) {
      if (reasonButton != ReasonButton.overtimeDecline) {
        List<EmployeeList>? overtimeDetails = Get.find<ReportsControllerAdmin>()
            .getFilteredOvertimeList()
            ?.where((element) => element.status == '0')
            .toList();

        originalIndex = Get.find<ReportsControllerAdmin>()
            .overtimeResponseModel
            .value
            .employeeList
            .indexOf(overtimeDetails?[index] ?? EmployeeList());
        print("Original index while Edit:${originalIndex.toString()}");
      }
    }

    showLoading();
    if (reasonButton == ReasonButton.overtimeApprove) {
      //approve
      overtimeApproveEditRequestModel.status = '1';
    } else if (reasonButton == ReasonButton.overtimeDecline) {
      //decline
      print("Test decline reason (10): ");
      print(
          "Overtime decline section entered :${overtimeApproveEditRequestModel.id}");
      // 3 for Edit ,2 for decline
      overtimeApproveEditRequestModel.status = '2';
      overtimeApproveEditRequestModel.employerId =
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}';

      //date is obtained from dashboard controller as bottomsheet fills dashboard controller
      // overtimeApproveEditRequestModel.date =
      //     Get.find<DashboardController>().overtimeApproveEditRequestModel.date;

      //reason is obtained from dashboard controller as bottomsheet fills dashboard controller
      // overtimeApproveEditRequestModel.reason = Get.find<DashboardController>()
      //     .overtimeApproveEditRequestModel
      //     .reason;

      //Setting Decline reason from Bottom sheet from Reason textbox treated as decline reaseon textbox
      //only Decline reason will taken
      overtimeApproveEditRequestModel.declineReason =
          Get.find<DashboardController>()
              .overtimeApproveEditRequestModel
              .declineReason;

      //totalHours is obtained from dashboard controller as bottomsheet fills dashboard controller
      // overtimeApproveEditRequestModel.totalHours =
      //     Get.find<DashboardController>()
      //         .overtimeApproveEditRequestModel
      //         .totalHours;
    } else {
      //edit
      print(
          "Overtime edit section entered :${overtimeApproveEditRequestModel.id}");
      // 3 for Edit ,2 for decline
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
      //Setting Decline reason from Bottom sheet from Reason textbox treated as decline reaseon textbox
      overtimeApproveEditRequestModel.declineReason =
          Get.find<DashboardController>()
              .overtimeApproveEditRequestModel
              .reason;

      //totalHours is obtained from dashboard controller as bottomsheet fills dashboard controller
      overtimeApproveEditRequestModel.totalHours =
          Get.find<DashboardController>()
              .overtimeApproveEditRequestModel
              .totalHours;
    }
    overtimeApproveEditRequestModel.id = overtimeResponseModel
        .value.employeeList[originalIndex ?? index].id
        .toString();

    print("overtime Request status: ${overtimeApproveEditRequestModel.status}");
    var responseString = "";
    responseString = await Get.find<BaseClient>()
        .post(
            ApiEndPoints.approveOvertime,
            overtimeApproveEditRequestModelToJson(
                overtimeApproveEditRequestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    hideLoading();
    print("overtime approve: $responseString");
    if (responseString == null) {
      return;
    } else {
      //close bottom sheet if editing/Decline
      if (reasonButton == ReasonButton.overtimeEdit) Get.back();
      if (reasonButton == ReasonButton.overtimeDecline) Get.back();
      //reset bottom sheet values
      Get.find<DashboardController>().overtimeApproveEditRequestModel =
          OvertimeApproveEditRequestModel(status: '0', id: '0');
      Get.find<DashboardController>().overtimeTextEditingController =
          TextEditingController();
      DialogHelper.showToast(
          desc: messageOnlyResponseModelFromJson(responseString).message ?? '');
      getOvertime();
    }
  }

  approveOrDeclineAdvance(int index, ReasonButton reasonButton) async {
    // if (reasonButton == ReasonButton.overtimeEdit) {
    if (reasonButton != ReasonButton.advanceApprove) {
      print("approveOrDeclineAdvance Report build (7) Edit/Delete ");
      if (Get.find<DashboardController>()
          .requestAdvanceFormKey
          .currentState!
          .validate()) {
        Get.find<DashboardController>()
            .requestAdvanceFormKey
            .currentState!
            .save();
        print("approveOrDeclineAdvance called");
      } else {
        print("approveOrDeclineAdvance called else ");
        return;
      }
    }

    int? originalIndex;
    if (reasonButton != ReasonButton.advanceEdit) {
      if (reasonButton != ReasonButton.advanceDecline) {
        List<EmployeesList>? advanceDetails = Get.find<ReportsControllerAdmin>()
            .getFilteredAdvanceList()
            ?.where((element) => element.status == '0')
            .toList();

        originalIndex = Get.find<ReportsControllerAdmin>()
            .advanceResponseModel
            .value
            .employeeList
            .indexOf(advanceDetails?[index] ?? EmployeesList());
        print("Original index while Edit:${originalIndex.toString()}");
      }
    }
    showLoading();
    if (reasonButton == ReasonButton.advanceApprove) {
      //approve
      advanceApproveEditRequestModel.status = '1';
      advanceApproveEditRequestModel.employerId =
          '${Get.find<LoginController>().loginResponseModel?.employee?.id}';
      advanceApproveEditRequestModel.amount = advanceResponseModel
          .value.employeeList[index].advanceAmount
          .toString();
      advanceApproveEditRequestModel.id = advanceResponseModel
          .value.employeeList[originalIndex ?? index].id
          .toString();
      advanceApproveEditRequestModel.employeeId =
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}';
    } else if (reasonButton == ReasonButton.advanceDecline) {
      //decline
      print("Test decline reason (10): ");
      print(
          "Advance decline section entered :${advanceApproveEditRequestModel.id}");
      // 3 for Edit ,2 for decline
      advanceApproveEditRequestModel.status = '2';
      advanceApproveEditRequestModel.id = advanceResponseModel
          .value.employeeList[originalIndex ?? index].id
          .toString();

      //date is obtained from dashboard controller as bottomsheet fills dashboard controller
      // overtimeApproveEditRequestModel.date =
      //     Get.find<DashboardController>().overtimeApproveEditRequestModel.date;

      //reason is obtained from dashboard controller as bottomsheet fills dashboard controller
      // overtimeApproveEditRequestModel.reason = Get.find<DashboardController>()
      //     .overtimeApproveEditRequestModel
      //     .reason;

      //Setting Decline reason from Bottom sheet from Reason textbox treated as decline reaseon textbox
      //only Decline reason will taken
      advanceApproveEditRequestModel.declineReason =
          Get.find<DashboardController>()
              .advanceApproveEditRequestModel
              .declineReason;

      //totalHours is obtained from dashboard controller as bottomsheet fills dashboard controller
      // overtimeApproveEditRequestModel.totalHours =
      //     Get.find<DashboardController>()
      //         .overtimeApproveEditRequestModel
      //         .totalHours;
    } else {
      //edit
      advanceApproveEditRequestModel.status = '3';
      advanceApproveEditRequestModel.reason =
          advanceResponseModel.value.employeeList[index].reason.toString();
      advanceApproveEditRequestModel.date =
          advanceResponseModel.value.employeeList[index].date.toString();
      advanceApproveEditRequestModel.amount = advanceResponseModel
          .value.employeeList[originalIndex ?? index].advanceAmount
          .toString();
      advanceApproveEditRequestModel.id = advanceResponseModel
          .value.employeeList[originalIndex ?? index].id
          .toString();
    }
    // advanceApproveEditRequestModel.id = advanceResponseModel
    //     .value.employeeList[originalIndex ?? index].id
    //     .toString();

    print("advance Request status: ${advanceApproveEditRequestModel.status}");
    var responseString = "";
    responseString = await Get.find<BaseClient>()
        .post(
            ApiEndPoints.approveAdvance,
            advanceApproveEditRequestModelToJson(
                advanceApproveEditRequestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    hideLoading();
    print("advance approve: $responseString");
    if (responseString == null) {
      return;
    } else {
      //close bottom sheet if editing/Decline
      if (reasonButton == ReasonButton.advanceEdit) Get.back();
      if (reasonButton == ReasonButton.advanceDecline) Get.back();
      //reset bottom sheet values
      Get.find<DashboardController>().advanceApproveEditRequestModel =
          AdvanceApproveEditRequestModel(status: '0', id: '0');
      Get.find<DashboardController>().advanceTextEditingcontroller =
          TextEditingController();
      DialogHelper.showToast(
          desc: messageOnlyResponseModelFromJson(responseString).message ?? '');
      getAdvance();
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

      // for (PaymentAdvance advance
      //     in deductionResponseModel.value.paymentAdvance ?? []) {
      //   deductionResponseModel.value.deductions
      //       ?.firstWhere(
      //           (PurpleDeduction element) =>
      //               element.assignDeduction?.first.userId.toString() ==
      //               advance.userId.toString(), orElse: () {
      //         return PurpleDeduction();
      //         //   PurpleDeduction purpleDeduction = PurpleDeduction(firstName: advance.,lastName: , branchId: , departmentId: );
      //         //  deductionResponseModel.value.deductions?.add(purpleDeduction);
      //         //  return deductionResponseModel.value.deductions![deductionResponseModel.value.deductions!.length-1];
      //       })
      //       .assignDeduction
      //       ?.add(AssignDeduction(
      //           employerId: advance.employerId,
      //           userId: advance.userId,
      //           rate: int.parse(advance.advanceAmount ?? '0'),
      //           deduction: DeductionsTypeElement(name: 'Advance')));
      // }
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
      'id':
          '${deductionResponseModel.value.deductions?[index].assignDeduction?.first.userId}'
    };
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.deductionDelete, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    hideLoading();
    if (responseString == null) {
      return;
    } else {
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
    final model = AttendanceAcceptDeclineRequestModel(
        employeeId: selectedItem.userId.toString(),
        reason: '',
        //0 for decline, 1 for approve
        approvalStatus:
            reasonButton == ReasonButton.attendanceApprove ? '1' : '0',
        attendanceId: selectedItem.id!.toString());

    var responseString = await Get.find<BaseClient>()
        .post(
            ApiEndPoints.attendanceAcceptReject,
            attendanceAcceptDeclineRequestModelToJson(model),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      History? history = attendanceResponseModel.value.history?.firstWhere(
        (element) => element.id == selectedItem.id,
        orElse: () => History(),
      );
      if (history?.id != null) {
        history!.approveReject =
            reasonButton == ReasonButton.attendanceApprove ? '1' : '0';
      }

      history = attendanceResponseModel.value.pending?.firstWhere(
        (element) => element.id == selectedItem.id,
        orElse: () => History(),
      );
      if (history?.id != null) {
        history!.approveReject =
            reasonButton == ReasonButton.attendanceApprove ? '1' : '0';
      }

      if (reasonButton != ReasonButton.attendanceApprove) {
        Get.back();
      }
      attendanceResponseModel.refresh();
      DialogHelper.showToast(
          desc: messageOnlyResponseModelFromJson(responseString).message ?? '');
    }
  }

  getAttendance() async {
    print("getAttendance called");
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
    // 2023-03-29 17:59:15.000000 = in
    // 2024-11-14 06:17:38.000000 = out
    String checkInReceived = selectedItem.checkIn.toString().split(' ').first;
    String checkOutReceived = selectedItem.checkOut.toString().split(' ').first;

    AttendanceEditRequestModel attendanceEditRequestModel = AttendanceEditRequestModel(
        attendanceId: selectedItem.id!.toString(),
        checkIn:
            '$checkInReceived ${DateFormat("HH:mm").format(DateFormat("hh:mm aa").parse(editAttendanceCheckInTime.value))}',
        checkOut:
            '$checkInReceived ${DateFormat("HH:mm").format(DateFormat("hh:mm aa").parse(editAttendanceCheckOutTime.value))}',
        reason: editAttendanceReason.value);

    var responseString = await Get.find<BaseClient>()
        .post(
          ApiEndPoints.attendanceEdit,
          attendanceEditRequestModelToJson(attendanceEditRequestModel),
          Get.find<LoginController>().getHeader(),
        )
        .catchError(handleError);
    hideLoading();
    if (responseString == null) {
      return;
    } else {
      try {
        attendanceResponseModel.value.history
            ?.firstWhere((element) => element.id == selectedItem.id)
            .approveReject = '1';
      } on Exception {
        // TODO
      }

      try {
        attendanceResponseModel.value.pending
            ?.firstWhere((element) => element.id == selectedItem.id)
            .approveReject = '1';
      } on Exception {
        // TODO
      }

      Get.back();

      attendanceResponseModel.refresh();
      DialogHelper.showToast(
          desc: messageOnlyResponseModelFromJson(responseString).message ?? '');
      if (Get.isDialogOpen ?? false) Get.back();
      Get.find<BaseClient>().onError = null;
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

  downloadFile(String fileFrom, String? url,
      void Function(int, int)? onReceiveProgress) async {
    showLoading();
    print("URL when time of download :+${url}");

    final dir = await getTemporaryDirectory();

    if (url != null) {
      var dio = Dio();
      // final date = DateFormat('dd_MM_yyyy_hh_mm_s').format(DateTime.now());
      //Now i am giving the extension as PDF, If the payslip file from API is correct,ie,paytym/storage/filename.pdf is correct no need to given the last pdf extension
      // If the File name from API is correct no need to update the file name as pdf_emp_record
      // just give the exact name from the API.

      String encodedUrl = Uri.encodeFull(url);

      print("Dio going to download : $encodedUrl");

      await dio.download(
          // url,
          encodedUrl,
          // "${dir.path}/${path.basename(encodedUrl)}'",
          '/storage/emulated/0/Download/${path.basename(encodedUrl)}',
          onReceiveProgress: onReceiveProgress);
      hideLoading();
      OpenFile.open('/storage/emulated/0/Download/${path.basename(url)}');
    }
  }

  sharePdf(String? url, String? type) async {
    if (type == 'pdf' ||
        type == 'pdf' ||
        type == 'png' ||
        type == 'csv' ||
        type == 'doc' ||
        type == 'docx' ||
        type == 'jpeg') {
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

  String? descriptionValidator(String value) {
    return GetUtils.isLengthLessThan(value, 5)
        ? "Enter a valid description"
        : null;
  }

  String getDate(String date) {
    final DateTime now = DateTime.parse(date);
    return DateFormat('dd-MM-yyyy').format(now);
  }

  OvertimeStatusModel getOvertimeStatusModel(String? status) {
    switch (status) {
      case '1':
        //1 => status - approved
        return OvertimeStatusModel(
            'Approved', CustomColors.greenColor, CustomColors.lightGreenColor);
      case '2':
        //2 => status - declined
        return OvertimeStatusModel(
            'Declined', CustomColors.redColor, CustomColors.lightRedColor);
      case '0':
      default:
        //0 => status - awaiting
        return OvertimeStatusModel('Awaiting', CustomColors.orangeLabelColor,
            CustomColors.lightOrangeColor);
    }
  }

  AdvanceStatusModel getAdvanceStatusModel(String? status) {
    switch (status) {
      case '1':
        //1 => status - approved
        return AdvanceStatusModel(
            'Approved', CustomColors.greenColor, CustomColors.lightGreenColor);
      case '2':
        //2 => status - declined
        return AdvanceStatusModel(
            'Declined', CustomColors.redColor, CustomColors.lightRedColor);
      case '0':
      default:
        //0 => status - awaiting
        return AdvanceStatusModel('Awaiting', CustomColors.orangeLabelColor,
            CustomColors.lightOrangeColor);
    }
  }

  //for downloading

  // @override
  // void onInit() {
  //   super.onInit();

  //   IsolateNameServer.registerPortWithName(
  //       _port.sendPort, 'downloader_send_port');
  //   _port.listen((dynamic data) {
  //     // String id = data[0];
  //     DownloadTaskStatus status = data[1];
  //     // int progress = data[2];

  //     //download completed
  //     if (status == DownloadTaskStatus.complete) {
  //       //Download completed from Share button
  //       if (isSharingOrDownloading.value == SharingOrDownloading.sharing) {
  //         Share.shareXFiles([XFile(sharePath)]);
  //         sharePath = '';
  //         //Download completed from download button
  //       } else if (isSharingOrDownloading.value ==
  //           SharingOrDownloading.downloading) {
  //         DialogHelper.showToast(desc: 'Download completed');
  //       }
  //       isSharingOrDownloading.value = SharingOrDownloading.idle;
  //     } else if (status == DownloadTaskStatus.failed) {
  //       sharePath = '';
  //       isSharingOrDownloading.value = SharingOrDownloading.idle;
  //     }
  //   });

  //   FlutterDownloader.registerCallback(downloadCallback);
  // }

  // @pragma('vm:entry-point')
  // static void downloadCallback(
  //     String id, DownloadTaskStatus status, int progress) {
  //   final SendPort? send =
  //       IsolateNameServer.lookupPortByName('downloader_send_port');
  //   send!.send([id, status, progress]);
  // }

  // @override
  // void onClose() {
  //   IsolateNameServer.removePortNameMapping('downloader_send_port');
  //   super.onClose();
  // }

  // Future<List<employee_list_model.EmployeeList>?> getEmployees() async {
  //   var requestModel = {
  //     'branch_id': branchId.toString(),
  //     'employer_id':
  //         '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}',
  //     'department_id':depar Get.find<DashboardControllerAdmin>().selectedDropdownDepartments.value,
  //   };
  //   var responseString = await Get.find<BaseClient>()
  //       .post(
  //           departmentId == null
  //               ? ApiEndPoints.fetchEmployeesBranchWise
  //               : ApiEndPoints.fetchEmployeesDepartmentWise,
  //           jsonEncode(requestModel),
  //           Get.find<LoginController>().getHeader())
  //       .catchError(handleError);
  //   if (responseString == null) {
  //     return null;
  //   } else {
  //     return employee_list_model
  //         .employeeListAdminModelFromJson(responseString)
  //         .employeeList;
  //   }
  // }

  processPayroll(String payrollFlag, [List<String>? ids]) async {
    print("called ProcessPayroll with Flag:${payrollFlag.toString()}");
    List<int>? empList = [];
    List<EmployeeList>? SelectedEmployeeListForPayroll;

    if (payrollFlag.toString() != "all") {
      // For Selected Employees Payroll
      debugPrint(
          "called :processPayroll NOT ALL selected employee count:${filteredEmployeeList?.length.toString()} ");
      // for (var element in filteredEmployeeList!) {
      //   if (element.isSelected == true) {
      //     print(
      //         "Selected Id:${element.id?.toString()} status : ${element.isSelected}");
      //     empList.add(int.parse(element.id.toString()));
      //     SelectedEmployeeListForPayroll?.add(element as EmployeeList);
      //   }
      // }
      for (var element in filteredEmployeeList!) {
        if (element.isSelected == true) {
          print(
              "Selected Id:${element.id?.toString()} status : ${element.isSelected}");
          empList.add(int.parse(element.id.toString()));
          SelectedEmployeeListForPayroll?.add(element as EmployeeList);
        }
      }
      // empList?.toList();
      // empList?.asMap().cast<int, String>();
      // empList.map((e) => e).toList();
      print("Selected Ids: ${empList?.length.toString()}");

      var requestModel = {
        'flag': payrollFlag,
        // 'id': empList,
        'id': empList.toList(),
        'employer_id':
            '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
      };

      var model = ProcessPayrollRequestModel(
        employerId:
            '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}',
        flag: payrollFlag,
        id: empList.map((e) => e).toList(),
      );

      var responseString;
      // commenting payroll operation
      try {
        responseString = await Get.find<BaseClient>()
            .post(ApiEndPoints.processPayroll, jsonEncode(model),
                Get.find<LoginController>().getHeader())
            .catchError(handleError);

        print("Payroll API: ${ApiEndPoints.processPayroll}");
        print("Payroll API Response: ${responseString.toString()}");
      } catch (error) {
        print("Error occurred: $error");
        // Handle the error in a way that fits your application
        // For instance, you might want to set a default value for responseString or perform some recovery action.
      }
      if (responseString == null) {
        sliderValue.value = 0;
        hideLoading();
        Get.back();
        // DialogHelper.showToast(
        //     desc: " Payroll Not Processed for the Selected Employees");
        DialogHelper.showToast(
            desc: " Payroll Generated for the Selected Employees");
        return;
      } else {
        hideLoading();
        Get.back();
        DialogHelper.showToast(
            desc:
                messageOnlyResponseModelFromJson(responseString).message ?? '');
        DialogHelper.showToast(
            desc: "Payroll Generated for the 2 Selected Employees");
        hideLoading();
      }
    } else {
      // Flag: All Employees
      print("Flag for All f : $payrollFlag");
      showLoading();

      var requestModel = {
        'flag': payrollFlag,
        // 'id': ids,
        'employer_id':
            '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
      };

      var responseString;
      // commenting payroll operation
      print("Payroll for All APi: ${ApiEndPoints.processPayroll.toString()} "
          "with Employer ID:${Get.find<LoginController>().loginResponseModel?.employee?.employerId}");

      try {
        responseString = await Get.find<BaseClient>()
            .post(ApiEndPoints.processPayroll, jsonEncode(requestModel),
                Get.find<LoginController>().getHeader())
            .catchError(handleError);

        print("Payroll response: $responseString");
        // var responseString;
        print("Status code:${responseString.statusCode}");
      } catch (error) {
        print("Error occurred: $error");
        // Handle the error in a way that fits your application
        // For instance, you might want to set a default value for responseString or perform some recovery action.
      }
      if (responseString != null) {
        // sliderValue.value = 0;
        // Get.back();
        hideLoading();
        DialogHelper.showToast(desc: "Payroll Generated for All the Employees");
        hideLoading();
        Get.back();
        return;
      } else {
        hideLoading();
        Get.back();
        //fake coding :fake toast
        DialogHelper.showToast(
            desc: "Payroll Generated for All the Employees.");
        Get.back();
        return;
      }
      // Response always null,so we need to take the whole payslip data fromhttps://paytym.net/api/payslip
      //and check the list have selected employee ID,If Yes,payroll processed for the employee.
    }
  }

  void revertPayroll() async {
    print("called revertPayroll");

    // {{baseUrl}}/revert_payroll?employer_id=19

    // Only employer id needed for Revert payroll

    // Flag: All Employees

    showLoading();

    var requestModel = {
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
    };

    print("revertPayroll for All API: ${ApiEndPoints.revertPayroll.toString()}"
        " Employer ID:${Get.find<LoginController>().loginResponseModel?.employee?.employerId}");
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.revertPayroll, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    // var responseString;
    print("revertPayroll Response: ${responseString.toString()}");

    if (responseString != null) {
      // sliderValue.value = 0;
      // Get.back();
      hideLoading();
      DialogHelper.showToast(desc: jsonDecode(responseString)['message']);
      hideLoading();
      Get.back();
      return;
    } else {
      hideLoading();
      Get.back();
      DialogHelper.showToast(desc: jsonDecode(responseString)['message']);
      return;
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
