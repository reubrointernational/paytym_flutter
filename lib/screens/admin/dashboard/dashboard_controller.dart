import 'dart:convert';

import 'package:get/get.dart';
import 'package:paytym/network/base_controller.dart';

import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../../login/login_controller.dart';

class DashboardControllerAdmin extends GetxController with BaseController {
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

  @override
  void onReady() {
    super.onReady();
    // fetchDashboardData();
  }

  // fetchDashboardData() async {
  //   showLoading();
  //   Get.find<BaseClient>().onError = fetchDashboardData;
    
  //   var responseString = await Get.find<BaseClient>()
  //       .post(ApiEndPoints.leaveAdmin, null,
  //           Get.find<LoginController>().getHeader())
  //       .catchError(handleError);
  //   if (responseString == null) {
  //     return;
  //   } else {
  //     hideLoading();
  //     // leaveAdminResponseModel.value =
  //     //     leavesAdminResponseModelFromJson(responseString);
  //     Get.find<BaseClient>().onError = null;
  //   }
  // }
}
