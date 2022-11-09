import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:paytym/screens/widgets/paytym_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/strings.dart';
import 'widgets/custom_text_form_field.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const PaytymLogo(),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      kForgotPasswordString,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: CustomColors.blueTextColor,
                      ),
                    ),
                    kSizedBoxH10,
                    const Text(
                      kDontWorryString,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 12.5,
                        color: CustomColors.darkGreyTextColor,
                      ),
                    ),
                    kSizedBoxH35,
                    Form(
                      key: Get.find<LoginController>().formKeyForgotPassword,
                      child: CustomTextFormField(
                        onSaved: (value) => Get.find<LoginController>()
                            .userModel
                            .email = value!,
                        hintText: kEmailString,
                        validator: (value) =>
                            Get.find<LoginController>().emailValidator(value!),
                      ),
                    ),
                    kSizedBoxH40,
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.find<LoginController>().goToOTPPage();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.blueTextColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          kSendString,
                          style: TextStyle(
                            color: CustomColors.whiteTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kSizedBoxH60,
            ],
          ),
        ),
      ),
    );
  }
}
