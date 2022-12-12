import 'dart:async';

import 'package:get/get.dart';
import 'package:paytym/models/login/login_request_model.dart';
import 'package:paytym/models/login/login_response_model.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../network/shared_preference_helper.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Timer(const Duration(seconds: 4), () async {
      Map<String, String> storageMap =
          await Get.find<SharedPreferenceHelper>().getUserDetails();
      if (storageMap['loginDetails'] != null) {
        Get.find<LoginController>().loginResponseModel =
            loginRequestModelFromJson(storageMap['loginDetails']!)
                as LoginResponseModel?;
        Get.find<LoginController>().goToMainOrOtpPage();
      } else {
        Get.offAndToNamed(Routes.login);
      }
    });
  }
}
