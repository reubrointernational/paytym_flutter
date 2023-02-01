
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/network/shared_preference_helper.dart';

import '../../core/colors/colors.dart';
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
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: h * 0.9,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.25),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(h * 0.8),
                    bottomRight: Radius.circular(w * 0.8),
                  )),
            ),
          ),
          Container(
            height: h * 0.9,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.25),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(700),
                  bottomLeft: Radius.circular(700),
                )),
          ),
          Center(
            child: Image.asset(
              'assets/png/splash_title.png',
            ),
          )
        ],
      ),
    );
  }
}
