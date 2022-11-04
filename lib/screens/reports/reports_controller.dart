import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paytym/models/login/user_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../models/login/login_request_model.dart';
import '../../network/base_client.dart';
import '../../network/end_points.dart';
import '../../routes/app_routes.dart';

class ReportsController extends GetxController with BaseController {
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
      print(responseString);
      resetControllerAndGoToLogin();
    }
    // update();
  }

  resetControllerAndGoToLogin() {
    Get.find<LoginController>().loginResponseModel = null;
    Get.find<LoginController>().userModel = UserModel();

    Get.offAllNamed(Routes.login);
  }
}
