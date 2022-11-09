import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/network/base_client.dart';
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
    Get.put(BaseClient());
    final loginController = Get.put(LoginController(), permanent: true);

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
                height: h * 0.2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    kLogInString,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: CustomColors.blueTextColor,
                    ),
                  ),
                  kSizedBoxH40,
                  Form(
                    key: loginController.formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          onSaved: (value) =>
                              loginController.userModel.email = value!,
                          hintText: kEmailString,
                          validator: (value) =>
                              loginController.emailValidator(value!),
                        ),
                        kSizedBoxH10,
                        CustomTextFormField(
                          onSaved: (value) =>
                              loginController.userModel.password = value!,
                          obscureText: true,
                          hintText: kPasswordString,
                          validator: (value) =>
                              loginController.passwordValidator(value!),
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
                          fontSize: 13,
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
                      onPressed: () => loginController.goToLoginPage(),
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
