import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/routes/app_routes.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () => Get.offAndToNamed(Routes.login));
  }

  @override
  Widget build(BuildContext context) {
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
