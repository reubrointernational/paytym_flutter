import 'package:get/get.dart';

import '../../login/login_controller.dart';

class DashboardControllerAdmin extends GetxController {
  seeDetailsPage(index) {
    switch (index) {
      case 0:
        Get.find<LoginController>().initialIndex = 2;
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 4;
        break;
      case 1:
        Get.find<LoginController>().initialIndex = 3;
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 4;
        break;
      case 2:
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 1;
        break;
      case 3:
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 2;
        break;
    }
  }
}
