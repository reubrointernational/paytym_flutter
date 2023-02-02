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
                  kForgotPasswordString,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(72, 13, 250, 1),
                  ),
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
                  onSaved: (value) =>
                      Get.find<LoginController>().userModel.email = value!,
                  hintText: kEmailString,
                  inputType: TextInputType.emailAddress,
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
                    backgroundColor: Color.fromRGBO(72, 13, 250, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
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
      ),
    );
  }
}
