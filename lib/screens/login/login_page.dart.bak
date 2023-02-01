import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/routes/app_routes.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/paytym_logo.dart';
import 'widgets/custom_text_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const PaytymLogo(),
              SizedBox(
                height: h * 0.16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    kLogInString,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: CustomColors.blueTextColor,
                    ),
                  ),
                  kSizedBoxH40,
                  Form(
                    key: Get.find<LoginController>().formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          onSaved: (value) => Get.find<LoginController>()
                              .userModel
                              .email = value!,
                          hintText: kEmailString,
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.emailAddress,
                          validator: (value) => Get.find<LoginController>()
                              .emailValidator(value!),
                        ),
                        kSizedBoxH10,
                        CustomTextFormField(
                          onSaved: (value) => Get.find<LoginController>()
                              .userModel
                              .password = value!,
                          obscureText: true,
                          hintText: kPasswordString,
                          validator: (value) => Get.find<LoginController>()
                              .passwordValidator(value!),
                        ),
                      ],
                    ),
                  ),
                  kSizedBoxH6,
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.forgotPassword),
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        kForgotPasswordString,
                        style: TextStyle(
                          fontSize: 13.5,
                          color: CustomColors.blueTextColor,
                        ),
                      ),
                    ),
                  ),
                  kSizedBoxH40,
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.find<LoginController>()
                          .validateAndGoToMainOrOtpPage(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.blueTextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        kLogInString,
                        style: TextStyle(
                          color: CustomColors.whiteTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
