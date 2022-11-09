import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
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

  updateTimer() {
    if (!isTimerOn.value) {
      try {
        checkInOutTimer =
            Timer.periodic(const Duration(minutes: 1), (timer) async {
          seconds.value++;
        });
      } finally {
        isTimerOn.value = true;
      }
    } else {
      checkInOutTimer?.cancel();
      seconds.value = 0;
      isTimerOn.value = false;
    }
  }
}
