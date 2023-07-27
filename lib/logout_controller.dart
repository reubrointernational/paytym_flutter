import 'package:get/get.dart';
import 'package:async/async.dart';
import 'package:paytym/screens/employee/dashboard/dashboard_controller.dart';

class LogoutController extends GetxService {
  RestartableTimer? _timer;
  //todo uncomment all data in this file

  initTimer() {
    print('init timer');
    _timer?.cancel();
    // _timer = RestartableTimer(const Duration(minutes: 1),
    //     () => Get.find<DashboardController>().logout());
  }

  cancelTimer() {
    _timer?.cancel();
  }

  restartTimer() {
    // _timer?.reset();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
