import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/models/message_only_response_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/employee/dashboard/widgets/dashboard_bottomsheet.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../../core/constants/enums.dart';
import '../../../models/login/user_model.dart';
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

  changeSliderPosition(double value) {
    if ((sliderValue.value - value).abs() < 20) {
      sliderValue.value = value;
      sliderValueChanged = true;
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
      DialogHelper.showBottomSheet(const DashboardBottomsheet());
    } else if (value == DashboardDropDown.logout) {
      showLogoutDialog();
    } else if (value == DashboardDropDown.workProfile) {
      Get.toNamed(Routes.bottomNavAdmin);
    } else {
      Get.back();
    }
  }

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

  startCheckInTimer(bool success) {
    if (success) {
      try {
        checkInOutTimer =
            Timer.periodic(const Duration(minutes: 1), (timer) async {
          seconds.value++;
        });
      } catch (e) {
        print(e.toString());
      }
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
          if (status) Get.find<SharedPreferenceHelper>().addCheckInDetails();
          startCheckInTimer(status);
          checkInStatus = true;
        }
        break;
      case CheckInOutStatus.checkOut:
        if (checkInStatus) {
          bool status = await serverCheckInOut(false);
          if (status) Get.find<SharedPreferenceHelper>().deleteAllCheckInData();
          cancelCheckInTimer(status);
          checkInStatus = false;
        }
        break;
      case CheckInOutStatus.qrCheckIn:
        if (!checkInStatus) {
          bool status = await serverCheckInOutByScan(true);
          if (status) {
            Get.find<SharedPreferenceHelper>().addCheckInDetails(true);
          }
          startCheckInTimer(status);
          checkInStatus = true;
        }
        break;
      case CheckInOutStatus.qrCheckOut:
        if (checkInStatus) {
          bool status = await serverCheckInOutByScan(false);
          if (status) Get.find<SharedPreferenceHelper>().deleteAllCheckInData();
          cancelCheckInTimer(status);
          checkInStatus = false;
        }
        break;
      default:
    }
  }

  //repositories

  Future<bool> serverCheckInOut(bool isCheckIn) async {
    String endPoint = isCheckIn ? ApiEndPoints.checkIn : ApiEndPoints.checkOut;
    var responseString = await Get.find<BaseClient>()
        .post(endPoint, null, Get.find<LoginController>().getHeader())
        .catchError(handleError);

    return handleResponseForMessageOnlyResponse(responseString);
  }

  Future<bool> serverCheckInOutByScan(bool isCheckIn) async {
    String endPoint =
        isCheckIn ? ApiEndPoints.checkInByScan : ApiEndPoints.checkOutByScan;
    var responseString = await Get.find<BaseClient>()
        .post(endPoint, null, Get.find<LoginController>().getHeader())
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
