import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:paytym/screens/widgets/paytym_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/widgets.dart';
import 'widgets/custom_text_form_field.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const PaytymLogo(),
              SizedBox(
                height: h * 0.16,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  kResetPasswordString,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(72, 13, 250, 1),
                  ),
                ),
              ),
              kSizedBoxH40,
              Form(
                key: Get.find<LoginController>().formKeyResetPassword,
                child: Column(
                  children: [
                    CustomTextFormField(
                      inputAction: TextInputAction.next,
                      onSaved: (value) => Get.find<LoginController>()
                          .userModel
                          .password = value!,
                      obscureText: true,
                      hintText: kNewPasswordString,
                      validator: (value) =>
                          Get.find<LoginController>().passwordValidator(value!),
                    ),
                    kSizedBoxH10,
                    CustomTextFormField(
                      onSaved: (value) => Get.find<LoginController>()
                          .userModel
                          .confirmPassword = value!,
                      obscureText: true,
                      hintText: kConfirmPasswordString,
                      validator: (value) =>
                          Get.find<LoginController>().passwordValidator(value!),
                    ),
                  ],
                ),
              ),
              kSizedBoxH50,
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.find<LoginController>()
                        .goToMainPageFromPasswordResetPage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(72, 13, 250, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    kSubmitString,
                    style: TextStyle(
                      color: CustomColors.whiteTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
