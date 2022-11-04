import 'package:paytym/screens/login/login_controller.dart';
import 'package:paytym/screens/widgets/paytym_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/widgets.dart';
import 'login_page.dart';
import 'widgets/custom_text_form_field.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(75, 103, 176, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: Get.find<LoginController>().formKeyResetPassword,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            onSaved: (value) => Get.find<LoginController>()
                                .userModel
                                .password = value!,
                            obscureText: true,
                            hintText: 'New Password',
                            validator: (value) => Get.find<LoginController>()
                                .passwordValidator(value!),
                          ),
                          kSizedBoxH10,
                          CustomTextFormField(
                            onSaved: (value) => Get.find<LoginController>()
                                .userModel
                                .confirmPassword = value!,
                            obscureText: true,
                            hintText: 'Confirm Password',
                            validator: (value) => Get.find<LoginController>()
                                .passwordValidator(value!),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.find<LoginController>()
                              .goToOTPPageFromPasswordResetPage();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(75, 103, 176, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
