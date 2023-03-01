import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/logout_controller.dart';
import 'package:paytym/models/message_only_response_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/employee/dashboard/widgets/request_advance_bottomsheet.dart';
import 'package:paytym/screens/employee/dashboard/widgets/request_overtime_bottomsheet.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../../core/constants/enums.dart';
import '../../../models/login/user_model.dart';
import '../../../models/dashboard/request_advance_model.dart';
import '../../../models/report/overtime_approve_edit_request_model.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../../../network/shared_preference_helper.dart';
import '../../../routes/app_routes.dart';

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
  TextEditingController? overtimeTextEditingController =
      TextEditingController();
  final employerIdModel = {
    'employer_id':
        '${Get.find<LoginController>().loginResponseModel?.employee?.employer_id}'
  };

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

   String? amountValidator(String value) {
    //todo uncomment
    // if (value.isEmpty) {
    //   return 'Value cannot be empty';
    // } else if (int.parse(
    //         payslipResponseModel.value.payroll?.salary ?? '10000') <
    //     int.parse(value)) {
    //   return 'Request amount should be less than salary';
    // } else if (int.parse(value) < 50) {
    //   return 'Request amount should be greater than 50';
    // }
    // return GetUtils.isLengthLessThan(value, 2) ? "Enter a valid number" : null;
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
    );
    try {
      overtimeApproveEditRequestModel.date =
          DateFormat('yyyy-MM-dd').format(dateTime!);
      overtimeTextEditingController?.text =
          DateFormat('dd-MM-yyyy').format(dateTime);
    } on Exception catch (e) {}
  }

  requestOvertime() async {
    if (requestAdvanceFormKey.currentState!.validate()) {
      requestAdvanceFormKey.currentState!.save();
      showLoading();
      //status 0 for creating overtime
      //status 1 for approving overtime
      //status 2 for declining overtime
      //status 3 for editing overtime
      overtimeApproveEditRequestModel.status = '0';
      overtimeApproveEditRequestModel.employerId =
          '${Get.find<LoginController>().loginResponseModel?.employee?.employer_id}';
      overtimeApproveEditRequestModel.employeeId =
          '${Get.find<LoginController>().loginResponseModel?.employee?.id}';

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
        Get.back();
        overtimeApproveEditRequestModel =
            OvertimeApproveEditRequestModel(status: '0', id: '0');
        overtimeTextEditingController = TextEditingController();
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

  sliderController(double value) {
    if (sliderValueChanged) {
      if (value > 95) {
        sliderValue.value = 100;
      } else if (value < 5) {
        sliderValue.value = 0;
      } else {
        sliderValue.value = checkInStatus ? 100 : 0;
      }
      sliderValue.value == 100
          ? updateCheckInOut(CheckInOutStatus.checkIn)
          : updateCheckInOut(CheckInOutStatus.checkOut);

      sliderValueChanged = false;
    }
  }

  onClickMenuItem(DashboardDropDown value) {
    if (value == DashboardDropDown.advance) {
      DialogHelper.showBottomSheet(const RequestAdvanceBottomsheet());
    } else if (value == DashboardDropDown.logout) {
      showLogoutDialog();
    } else if (value == DashboardDropDown.workProfile) {
      Get.toNamed(Routes.bottomNavAdmin);
    } else if (value == DashboardDropDown.overTime) {
      DialogHelper.showBottomSheet(const RequestOvertimeBottomsheet());
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
      //cancel inactive timer
      Get.find<LogoutController>().cancelTimer();
    }
  }

  resetControllerAndGoToLogin() {
    Get.find<LoginController>().loginResponseModel = null;
    Get.find<LoginController>().userModel = UserModel();
    Get.find<SharedPreferenceHelper>().deleteAll();
    Get.offAllNamed(Routes.login);
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
    nowIsTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      updateTime();
    });
    //update check-in data when app starts
    updateCheckInData();
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
        if (!checkInStatus) {
          bool status = await serverCheckInOutByScan(true);
          if (status) {
            Get.find<SharedPreferenceHelper>().addCheckInDetails(true);
            startCheckInTimer();
            checkInStatus = true;
          } else {
            Get.find<DashboardController>().sliderValue.value = 0;
            checkInStatus = false;
          }
        }
        break;
      case CheckInOutStatus.qrCheckOut:
        if (checkInStatus) {
          bool status = await serverCheckInOutByScan(false);
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

    var responseString = await Get.find<BaseClient>()
        .post(endPoint, jsonEncode(employerIdModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    return handleResponseForMessageOnlyResponse(responseString);
  }

  bool handleResponseForMessageOnlyResponse(String? responseString) {
    if (responseString == null) {
      return false;
    } else {
      DialogHelper.showToast(
          desc: messageOnlyResponseModelFromJson(responseString).message!);
      return true;
    }
  }
}
