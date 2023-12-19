import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/logout_controller.dart';
import 'package:paytym/models/message_only_response_model.dart';
import 'package:paytym/models/report/advance_approve_edit_request.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/employee/dashboard/widgets/request_advance_bottomsheet.dart';
import 'package:paytym/screens/employee/dashboard/widgets/request_overtime_bottomsheet.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../../core/constants/enums.dart';
import '../../../models/dashboard/dashboard_response_model.dart';
import '../../../models/employee_list_model.dart';
import '../../../models/login/user_model.dart';
import '../../../models/dashboard/request_advance_model.dart';
import '../../../models/report/advance_approve_edit_request.dart';
import '../../../models/report/overtime_approve_edit_request_model.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../../../network/shared_preference_helper.dart';
import '../../../routes/app_routes.dart';
import '../../admin/dashboard/dashboard_controller.dart';
import '../../admin/reports/reports_controller.dart';

class DashboardController extends GetxController with BaseController {
  final time = '00:00 AM'.obs;
  late Timer? nowIsTimer;
  late Timer? checkInOutTimer;
  final seconds = 0.obs;
  final sliderValue = 0.0.obs;
  bool checkInStatus = false;
  bool sliderValueChanged = false;
  final requestAdvanceFormKey = GlobalKey<FormState>();

  RequestAdvanceModel requestAdvanceModel = RequestAdvanceModel();
  OvertimeApproveEditRequestModel overtimeApproveEditRequestModel =
      OvertimeApproveEditRequestModel(status: '0', id: '0');
  AdvanceApproveEditRequestModel advanceApproveEditRequestModel =
      AdvanceApproveEditRequestModel(status: '0', id: '0');

  TextEditingController? advanceTextEditingcontroller = TextEditingController();
  TextEditingController? dateofrequiredTextEditingcontroller =
      TextEditingController();

  TextEditingController? overtimeTextEditingController =
      TextEditingController();
  final employerIdModel = {
    'employer_id':
        '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
  };

  String? qr;
  bool isCheckedInWithQR = false;
  final dashboardModel = DashboardResponseModel().obs;

  getWish() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (hour >= 1 && hour <= 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour <= 16) {
      return "Good Afternoon";
    } else if (hour >= 16 && hour <= 21) {
      return "Good Evening";
    } else if (hour >= 21 && hour <= 24) {
      return "Good Night";
    }
    return '';
  }

  convertDateFormat(String? inputDate) {
    List<String> dateParts = inputDate!.split('-');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    DateTime dateTime = DateTime(year, month, day);

    String formattedDate =
        '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

    return formattedDate;
  }

  getNextShift() {
    if (dashboardModel.value.nextShift?.startTime == null ||
        dashboardModel.value.nextShift?.endDate == null) {
      return '-';
    } else {
      DateTime dateTimeTomorrow = DateTime.now();
      dateTimeTomorrow.day + 1;

      if (dateTimeTomorrow.isBefore(dashboardModel.value.nextShift!.endDate!)) {
        DateTime startTime = DateFormat("hh:mm")
            .parse(dashboardModel.value.nextShift?.startTime ?? '00:00:00');
        if (startTime != DateTime(0)) {
          return DateFormat('hh:mm aa').format(startTime);
        }
      }
    }

    return '-';
  }

  getNextShiftDate() {
    if (dashboardModel.value.nextShift?.endDate == null) {
      return '-';
    } else {
      DateTime dateTimeTomorrow = DateTime.now();
      dateTimeTomorrow = DateTime(dateTimeTomorrow.year, dateTimeTomorrow.month,
          dateTimeTomorrow.day + 1);

      if (dateTimeTomorrow.isBefore(dashboardModel.value.nextShift!.endDate!)) {
        return DateFormat('MMM dd').format(dateTimeTomorrow);
      }
    }

    return '-';
  }

  updateFCMToken() async {
    Map<String, String> map = {
      'user_id': Get.find<LoginController>()
              .loginResponseModel
              ?.employee
              ?.id
              .toString() ??
          '',
      'device_id': LoginController.FCMToken
    };

    await Get.find<BaseClient>().post(ApiEndPoints.updateFCMToken,
        jsonEncode(map), Get.find<LoginController>().getHeader());
  }

  String? amountValidator(String value) {
    if (value.isEmpty) {
      return 'Value cannot be empty';
    } else if (double.parse(
            Get.find<LoginController>().loginResponseModel?.employee?.rate ??
                '0') <
        double.parse(value)) {
      return 'Request amount should be less than salary';
    } else if (double.parse(value) <= 0) {
      return 'Request amount should be greater than 0';
    }
    return GetUtils.isLengthLessThan(value, 1) ? "Enter a valid number" : null;
  }

  changeSliderPosition(double value) {
    if ((sliderValue.value - value).abs() < 20) {
      sliderValue.value = value;
      sliderValueChanged = true;
    }
  }

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
      selectableDayPredicate: (DateTime date) =>
          date.isAfter(DateTime.now().subtract(const Duration(days: 1))),
    );

    try {
      overtimeApproveEditRequestModel.date =
          DateFormat('yyyy-MM-dd').format(dateTime!);
      overtimeTextEditingController?.text =
          DateFormat('dd-MM-yyyy').format(dateTime);
    } on Exception {}
  }

  Future<void> dateofrequirement(BuildContext context) async {
    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      // firstDate: DateTime(1990),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    try {
      advanceApproveEditRequestModel.date =
          DateFormat('yyyy-MM-dd').format(dateTime!);
      dateofrequiredTextEditingcontroller?.text =
          DateFormat('dd-MM-yyyy').format(dateTime);
    } on Exception {}
  }

  requestOvertime(EmployeeList? employeeList) async {
    print("request Overtime called");
    if (requestAdvanceFormKey.currentState!.validate()) {
      requestAdvanceFormKey.currentState!.save();
      showLoading();
      //status 0 for creating overtime
      //status 1 for approving overtime
      //status 2 for declining overtime
      //status 3 for editing overtime
      overtimeApproveEditRequestModel.status = '0';
      overtimeApproveEditRequestModel.employerId =
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}';
      print(
          "overtimeApproveEditRequestModel.employerId:${overtimeApproveEditRequestModel.employerId.toString()}");
      print("employeeList?.id:${employeeList?.id.toString()}");
      overtimeApproveEditRequestModel.employeeId = employeeList?.id != null
          ? employeeList!.id.toString()
          : '${Get.find<LoginController>().loginResponseModel?.employee?.id}';
      print(
          'request Overtime ID:${Get.find<LoginController>().loginResponseModel?.employee?.id}');
      print(
          'request Overtime ID er:${overtimeApproveEditRequestModel?.employeeId}');

      print(
          'request Overtime  status:${overtimeApproveEditRequestModel?.status}');
      print('request Overtime  employeeList?.id:${employeeList?.id}');

      var responseString = await Get.find<BaseClient>()
          .post(
              employeeList?.id != null
                  ? ApiEndPoints.approveOvertimeHR
                  : ApiEndPoints.approveOvertime,
              overtimeApproveEditRequestModelToJson(
                  overtimeApproveEditRequestModel),
              Get.find<LoginController>().getHeader())
          .catchError(handleError);

      print('request Overtime Response:$responseString');
      if (responseString == null) {
        return;
      } else {
        print('request Overtime Response not null :$responseString');
        hideLoading();
        Get.back();
        overtimeApproveEditRequestModel =
            OvertimeApproveEditRequestModel(status: '0', id: '0');
        Get.find<ReportsControllerAdmin>().getOvertime();
        overtimeTextEditingController = TextEditingController();
        DialogHelper.showToast(
            desc:
                messageOnlyResponseModelFromJson(responseString).message ?? '');
      }
    }
  }

  requestAdvanceLoan(EmployeeList? employeeList) async {
    print("request Overtime called");
    if (requestAdvanceFormKey.currentState!.validate()) {
      requestAdvanceFormKey.currentState!.save();
      showLoading();
      //status 0 for creating overtime
      //status 1 for approving overtime
      //status 2 for declining overtime
      //status 3 for editing overtime
      advanceApproveEditRequestModel.status = '0';
      advanceApproveEditRequestModel.employerId =
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}';
      print(
          "AdvanceApproveEditRequestModel.employerId:${advanceApproveEditRequestModel.employerId.toString()}");
      print("employeeList?.id:${employeeList?.id.toString()}");
      advanceApproveEditRequestModel.employeeId = employeeList?.id != null
          ? employeeList!.id.toString()
          : '${Get.find<LoginController>().loginResponseModel?.employee?.id}';
      print(
          'request Advance ID:${Get.find<LoginController>().loginResponseModel?.employee?.id}');
      print(
          'request Advance ID er:${advanceApproveEditRequestModel?.employeeId}');

      print(
          'request Advance  status:${advanceApproveEditRequestModel?.status}');
      print('request Advance  employeeList?.id:${employeeList?.id}');

      var responseString = await Get.find<BaseClient>()
          .post(
              employeeList?.id != null
                  ? ApiEndPoints.approveOvertimeHR
                  : ApiEndPoints.approveAdvance,
              advanceApproveEditRequestModelToJson(
                  advanceApproveEditRequestModel),
              Get.find<LoginController>().getHeader())
          .catchError(handleError);

      print('request Advance Response:$responseString');
      if (responseString == null) {
        return;
      } else {
        print('request Advance Response not null :$responseString');
        hideLoading();
        Get.back();
        advanceApproveEditRequestModel =
            AdvanceApproveEditRequestModel(status: '0', id: '0');
        Get.find<ReportsControllerAdmin>().getAdvance();
        advanceTextEditingcontroller = TextEditingController();
        DialogHelper.showToast(
            desc:
                messageOnlyResponseModelFromJson(responseString).message ?? '');
      }
    }
  }

  void requestAdvance() {
    if (requestAdvanceFormKey.currentState!.validate()) {
      requestAdvanceFormKey.currentState!.save();
      requestAdvanceOrSalary();
    }
  }

  requestAdvanceOrSalary() async {
    showLoading();
    var responseString = await Get.find<BaseClient>()
        .post(
            ApiEndPoints.requestAdvance,
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

  sliderController(double value)
  {
    if (sliderValueChanged) {
      sliderValue.value = value;
      if (value > 95) {
        sliderValue.value = 100;
       // updateCheckInOut(CheckInOutStatus.checkIn);

      } else if (value < 5) {
        sliderValue.value = 0;
       // updateCheckInOut(CheckInOutStatus.checkOut);
      } else {
        sliderValue.value = checkInStatus ? 100 : 0;
      }
  // void sliderController(double value) {
  //   if (sliderValueChanged) {
  //     sliderValue.value = value;
  //     if (value == 100) {
  //       updateCheckInOut(CheckInOutStatus.checkIn);
  //     } else if (value == 0) {
  //       updateCheckInOut(CheckInOutStatus.checkOut);
  //     }
  //     sliderValueChanged = false;
  //   }
  // }


  if (qr != null) {
        if (sliderValue.value == 100) {
          //checkin
          updateCheckInOut(CheckInOutStatus.checkIn);
        } else if (isCheckedInWithQR && sliderValue.value == 0) {
          //checkout not possible if checkedin with qrcode
          sliderValue.value = 100;
          checkInStatus = true;
          DialogHelper.showToast(desc: 'Use QR scanner to checkout');
        } else {
          updateCheckInOut(CheckInOutStatus.checkOut);
        }
      } else {
        if (sliderValue.value == 100) {
          //checkin
          updateCheckInOut(CheckInOutStatus.qrCheckIn);
        } else if (!isCheckedInWithQR && sliderValue.value == 0) {
          sliderValue.value = 100;
          checkInStatus = false;
          DialogHelper.showToast(desc: 'Use Slider to checkout');
          Get.back();
        } else {
          updateCheckInOut(CheckInOutStatus.qrCheckOut);
        }
        qr = null;
      }
      sliderValueChanged = false;
    }
  }

  onClickMenuItem(DashboardDropDown value, [isFromAdmin = true]) {
    if (value == DashboardDropDown.advance) {
      DialogHelper.showBottomSheet(const RequestAdvanceBottomsheet());
    } else if (value == DashboardDropDown.logout) {
      showLogoutDialog();
    } else if (value == DashboardDropDown.workProfile) {
      Get.toNamed(Routes.bottomNavAdmin);
    } else if (value == DashboardDropDown.overTime) {
      print('DashboardDropDown.overTime');
      DialogHelper.showBottomSheet(const RequestOvertimeBottomsheet());
    } else if (value == DashboardDropDown.payroll) {
      if (!isFromAdmin) {
        print('open admin bottom nav panel');
        Get.toNamed(Routes.bottomNavAdmin);
      }
      Get.find<DashboardControllerAdmin>().seeDetailsPage(5);
    } else {
      Get.back();
    }
  }

  String? reasonValidator(String value) {
    return GetUtils.isLengthLessThan(value, 5) ? "Enter a valid reason" : null;
  }

  showLogoutDialog() {
    DialogHelper.showConfirmDialog(
      onConfirm: logout,
    );
  }

  String? dateValidator(String value) {
    final regExp =
        RegExp(r'^(0[1-9]|[12][0-9]|3[01])\-(0[1-9]|1[012])\-\d{4}$');
    return regExp.hasMatch(value) && GetUtils.isLengthEqualTo(value, 10)
        ? null
        : "Enter a valid date";
  }

  String? dateValidatorloan(String value) {
    print("Loan selected date ${value}");
    final regExp =
        RegExp(r'^(0[1-9]|[12][0-9]|3[01])\-(0[1-9]|1[012])\-\d{4}$');
    return regExp.hasMatch(value) && GetUtils.isLengthEqualTo(value, 10)
        ? null
        : "Enter a valid date in DD-MM-YYYY format";
  }

  logout() async {
    resetControllerAndGoToLogin();
    //cancel inactive timer
    Get.find<LogoutController>().cancelTimer();
    Get.offAllNamed(Routes.login);
    print("Testing URL:${Routes.login}");
    await Get.find<BaseClient>().post(
        ApiEndPoints.logout, null, Get.find<LoginController>().getHeader());
  }

  resetControllerAndGoToLogin() {
    Get.find<LoginController>().loginResponseModel = null;
    Get.find<LoginController>().userModel = UserModel();
    Get.find<SharedPreferenceHelper>().deleteAll();
  }

  @override
  void onClose() {
    nowIsTimer?.cancel;
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    updateTime();
    nowIsTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateTime();
    });
    //update check-in data when app starts
    //updateCheckInData();
    updateFCMToken();
  }

  List<String> getTotal(int index) {
    switch (index) {
      case 0:
        return [
          "${Get.find<DashboardController>().dashboardModel.value.absence ?? '0'}",
          "${Get.find<DashboardController>().dashboardModel.value.allowedAbsent ?? 0} allowed"
        ];
      case 1:
        return [
          "${Get.find<DashboardController>().dashboardModel.value.sick ?? '0'}",
          "${Get.find<DashboardController>().dashboardModel.value.allowedSickLeave ?? 0} allowed"
        ];
      case 2:
        return [
          "${Get.find<DashboardController>().dashboardModel.value.annual ?? '0'}",
          "${Get.find<DashboardController>().dashboardModel.value.allowedAnnualLeave ?? 0} allowed"
        ];
      default:
        return [
          "${Get.find<DashboardController>().dashboardModel.value.lateArrival ?? '0'}",
          "${Get.find<DashboardController>().dashboardModel.value.allowedLateArrival ?? 0} allowed"
        ];
    }
  }

  Future<DashboardResponseModel?> fetchDashboardDetails() async {
    Get.find<BaseClient>().onError = fetchDashboardDetails;
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.dashboard, null,
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return null;
    } else {
      dashboardModel.value = dashboardResponseModelFromJson(responseString);
      Get.find<BaseClient>().onError = null;
      if (dashboardModel.value.lastCheckedIn != null) {
        seconds.value = DateTime.now()
            .difference(dashboardModel.value.lastCheckedIn ?? DateTime.now())
            .inMinutes;
        startCheckInTimer();
        checkInStatus = true;
        sliderValueChanged = true;
        sliderController(100);
      }
      return dashboardModel.value;
    }
  }

  updateCheckInData() async {
    Map<String, String> storageMap =
        await Get.find<SharedPreferenceHelper>().getStorageData();

    DateTime now = DateTime.now();

    if (storageMap['checkIn'] != null) {
      //already checked-in

      sliderValue.value = 100;
      DateTime startTime = DateTime.parse(storageMap['checkIn']!);
      seconds.value = now.difference(startTime).inMinutes;
    } else if (storageMap['checkInQr'] != null) {
      //if the checkin is using qr code we need to checkout using qr code.
      isCheckedInWithQR = true;
      sliderValue.value = 100;
      DateTime startTime = DateTime.parse(storageMap['checkInQr']!);
      seconds.value = now.difference(startTime).inMinutes;
    }
  }

  updateTime() {
    final DateTime now = DateTime.now();
    time.value = DateFormat.jm().format(now);
  }

  String getDate() {
    final DateTime now = DateTime.now();
    return DateFormat('EEEE, dd MMM yyyy').format(now);
  }

  startCheckInTimer() {
    try {
      checkInOutTimer =
          Timer.periodic(const Duration(minutes: 1), (timer) async {
        seconds.value++;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  cancelCheckInTimer(bool success) {
    if (success) {
      checkInOutTimer?.cancel();
      seconds.value = 0;
    }
  }

  updateCheckInOut(checkInOutStatus) async {
    switch (checkInOutStatus) {
      case CheckInOutStatus.checkIn:
        if (!checkInStatus) {
          bool status = await serverCheckInOut(true);
          if (status) {
            Get.find<SharedPreferenceHelper>().addCheckInDetails();
            startCheckInTimer();
            checkInStatus = true;
          } else {
            Get.find<DashboardController>().sliderValue.value = 0;
            checkInStatus = false;
          }
        }
        break;
      case CheckInOutStatus.checkOut:
        print('checkout');
        if (checkInStatus) {
          bool status = await serverCheckInOut(false);
          if (status) {
            Get.find<SharedPreferenceHelper>().deleteAllCheckInData();
            cancelCheckInTimer(status);
            checkInStatus = false;
          } else {
            Get.find<DashboardController>().sliderValue.value = 100;
            checkInStatus = true;
          }
        }
        break;
      case CheckInOutStatus.qrCheckIn:
        print('qrcheckin');
        if (!checkInStatus) {
          bool status = await serverCheckInOutByScan(true);
          if (status) {
            Get.find<SharedPreferenceHelper>().addCheckInDetails(true);
            startCheckInTimer();
            checkInStatus = true;
            isCheckedInWithQR = true;
          } else {
            Get.find<DashboardController>().sliderValue.value = 0;
            checkInStatus = false;
          }
        }
        break;
      case CheckInOutStatus.qrCheckOut:
        print('qrcheckout');
        if (checkInStatus) {
          bool status = await serverCheckInOutByScan(false);
          if (status) {
            Get.find<SharedPreferenceHelper>().deleteAllCheckInData();
            cancelCheckInTimer(status);
            checkInStatus = false;
            isCheckedInWithQR = false;
          } else {
            Get.find<DashboardController>().sliderValue.value = 100;
            checkInStatus = true;
          }
        }

        break;
      default:
    }
  }

  //repositories

  Future<bool> serverCheckInOut(bool isCheckIn) async {
    String endPoint = isCheckIn ? ApiEndPoints.checkIn : ApiEndPoints.checkOut;

    var responseString = await Get.find<BaseClient>()
        .post(endPoint, jsonEncode(employerIdModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);

    return handleResponseForMessageOnlyResponse(responseString);
  }

  Future<bool> serverCheckInOutByScan(bool isCheckIn) async {
    String endPoint =
        isCheckIn ? ApiEndPoints.checkInByScan : ApiEndPoints.checkOutByScan;
    showLoading();
    employerIdModel['qr_code'] = qr!;
    // employerIdModel['qr_code'] = 'ss123';
    var responseString = await Get.find<BaseClient>()
        .post(endPoint, jsonEncode(employerIdModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);

    print('qr = null');
    employerIdModel.remove('qr_code');
    hideLoading();
    return handleResponseForMessageOnlyResponse(responseString, true);
  }

  bool handleResponseForMessageOnlyResponse(String? responseString,
      [bool isFromQr = false]) {
    if (responseString == null) {
      return false;
    } else {
      final message = messageOnlyResponseModelFromJson(responseString).message!;
      DialogHelper.showToast(desc: message);
      if (isFromQr) {
        if (message.toLowerCase().contains('success')) {
          Get.back();
          return true;
        } else if (message.toLowerCase().contains('manually')) {
          Get.back();
          return false;
        } else if (!message.toLowerCase().contains('success')) {
          Get.back();
          return false;
        }
      }
      return true;
    }
  }
}
