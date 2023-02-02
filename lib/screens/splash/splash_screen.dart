import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.blueCardColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: size.height * 0.9,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.25),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(size.height * 0.8),
                    bottomRight: Radius.circular(size.height * 0.8),
                  )),
            ),
          ),
          Container(
            height: size.height * 0.9,
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
