import 'dart:async';

import 'package:get/get.dart';
import 'package:paytym/models/login/login_response_model.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../logout_controller.dart';
import '../../network/shared_preference_helper.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    
    Timer(const Duration(seconds: 4), () async {
      await Get.find<SharedPreferenceHelper>().deleteSharedPrefOnStart();
      Map<String, String> storageMap =
          await Get.find<SharedPreferenceHelper>().getStorageData();
      if (storageMap['loginDetails'] != null) {
        Get.find<LoginController>().loginResponseModel =
            loginResponseModelFromJson(storageMap['loginDetails']!);
        Get.find<LoginController>().goToMainOrOtpPage();
        
      } else {
        Get.offAndToNamed(Routes.login);
      }
    });
  }
}
