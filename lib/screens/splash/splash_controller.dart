import 'dart:async';

import 'package:get/get.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../models/login/user_model.dart';
import '../../network/shared_preference_helper.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Timer(const Duration(seconds: 4), () async {
      Map<String, String> storageMap =
          await Get.find<SharedPreferenceHelper>().getUserLoginCredentials();
      if (storageMap['email'] != null && storageMap['key'] != null) {
        Get.find<LoginController>().userModel = UserModel(
            email: storageMap['email']!, password: storageMap['key']!);
        Get.find<LoginController>().goToMainOrOtpPage(false);
      } else {
        Get.offAndToNamed(Routes.login);
      }
    });
  }
}
