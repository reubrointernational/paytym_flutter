import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/models/message_only_response_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../network/base_client.dart';
import '../../network/end_points.dart';

class DashboardController extends GetxController with BaseController {
  final time = '00:00 AM'.obs;
  late Timer? timer;
  late Timer? checkInOutTimer;
  final seconds = 0.obs;
  final isTimerOn = false.obs;

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

  @override
  void onClose() {
    timer?.cancel;
    super.onClose();
  }

  @override
  void onReady() {
    updateTime();
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      updateTime();
    });
    super.onReady();
  }

  updateTime() {
    final DateTime now = DateTime.now();
    time.value = DateFormat.jm().format(now);
  }

  String getDate() {
    final DateTime now = DateTime.now();
    return DateFormat('EEEE, dd MMM yyyy').format(now);
  }

  updateTimer([String? qrCode]) async {
    if (isTimerOn.isFalse) {
      bool isSuccess = qrCode == null
          ? await serverCheckInOut(true)
          : await serverCheckInOutByScan(true);
      if (isSuccess) {
        try {
          checkInOutTimer =
              Timer.periodic(const Duration(minutes: 1), (timer) async {
            seconds.value++;
          });
        } finally {
          isTimerOn.value = true;
        }
      }
    } else {
      bool isSuccess = qrCode == null
          ? await serverCheckInOut(false)
          : await serverCheckInOutByScan(false);
      if (isSuccess) {
        checkInOutTimer?.cancel();
        seconds.value = 0;
        isTimerOn.value = false;
      }
    }
  }

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
