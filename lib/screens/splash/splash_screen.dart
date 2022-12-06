import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/models/login/user_model.dart';
import 'package:paytym/network/shared_preference_helper.dart';
import 'package:paytym/routes/app_routes.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/strings.dart';
import '../../network/base_client.dart';
import '../login/login_controller.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BaseClient());
    Get.put(LoginController(), permanent: true);
    Get.put(SplashController());
    Get.lazyPut(() => SharedPreferenceHelper(), fenix: true);
    return Scaffold(
      backgroundColor: CustomColors.blueCardColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              IconPath.splashImage,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            kSizedBoxH20,
            const Text(
              kAppNameString,
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w600,
                color: CustomColors.whiteTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
