import 'package:paytym/models/login/login_request_model.dart';
import 'package:paytym/models/login/login_response_model.dart';
import 'package:paytym/models/login/user_model.dart';
import 'package:paytym/models/message_only_response_model.dart';
import 'package:paytym/models/login/otp_request_model.dart';
import 'package:paytym/models/login/password_reset_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../network/base_client.dart';
import '../../network/base_controller.dart';
import '../../network/end_points.dart';
import '../../routes/app_routes.dart';

class LoginController extends GetxController with BaseController {
  LoginResponseModel? loginResponseModel;
  UserModel userModel = UserModel();
  final formKey = GlobalKey<FormState>();
  final formKeyForgotPassword = GlobalKey<FormState>();
  final formKeyResetPassword = GlobalKey<FormState>();

  Map<String, String>? getHeader() {
    return {
      'content-type': 'application/json',
      'Authorization': 'Bearer ${userModel.token}'
    };
  }

  fetchLoginData() async {
    showLoading();

    LoginRequestModel loginRequestModel =
        LoginRequestModel(email: userModel.email, password: userModel.password);

    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.login, loginRequestModelToJson(loginRequestModel))
        .catchError(handleError);

    if (responseString == null) {
      return;
    } else {
      hideLoading();
      loginResponseModel = loginResponseModelFromJson(responseString);
    }
    // update();
  }

  Future<MessageOnlyResponseModel?> sendOtp() async {
    showLoading();

    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.sendOtp, null, getHeader())
        .catchError(handleError);

    if (responseString == null) {
      return null;
    } else {
      hideLoading();
      return messageOnlyResponseModelFromJson(responseString);
    }
  }

  Future<MessageOnlyResponseModel?> confirmOtp(String otp) async {
    showLoading();
    OtpRequestModel otpRequestModel = OtpRequestModel(otp: otp);

    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.confirmOtp, otpRequestModelToJson(otpRequestModel),
            getHeader())
        .catchError(handleError);

    if (responseString == null) {
      return null;
    } else {
      hideLoading();
      return messageOnlyResponseModelFromJson(responseString);
    }
  }

//endpoint: password-update
  Future<MessageOnlyResponseModel?> updatePassword() async {
    showLoading();
    PasswordResetRequestModel passwordResetRequestModel =
        PasswordResetRequestModel(
            password: userModel.password,
            passwordConfirmation: userModel.confirmPassword);

    var responseString = await Get.find<BaseClient>()
        .post(
            ApiEndPoints.updatePassword,
            passwordResetRequestModelToJson(passwordResetRequestModel),
            getHeader())
        .catchError(handleError);

    if (responseString == null) {
      return null;
    } else {
      hideLoading();
      return messageOnlyResponseModelFromJson(responseString);
    }
  }

//validators
  String? emailValidator(String value) {
    return !GetUtils.isEmail(value) ? "Enter a valid email" : null;
  }

  String? passwordValidator(String value) {
    return GetUtils.isLengthLessThan(value, 5)
        ? "Enter a valid password"
        : null;
  }

//goto
  goToLoginPage() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      await fetchLoginData();

      userModel.token = loginResponseModel?.token;
      //isFirst = 1 => first time login
      if (loginResponseModel?.employee?.isFirst == '1') {
        Get.offAndToNamed(Routes.resetPassword);
      } else if (loginResponseModel?.employee?.isFirst == '0') {
        Get.offAndToNamed(Routes.bottomNav);
      }
    }
  }

  goToMainPage(String otp) async {
    if (otp.isNotEmpty && otp != '0000') {
      MessageOnlyResponseModel? model = await confirmOtp(otp);
      if (model != null) {
        MessageOnlyResponseModel? confirmModel = await updatePassword();
        if (confirmModel != null) {
          Get.toNamed(Routes.bottomNav);
        }
      }
    }
  }

  goToOTPPageFromPasswordResetPage() async {
    if (formKeyResetPassword.currentState!.validate()) {
      formKeyResetPassword.currentState!.save();
      if (userModel.password.isNotEmpty &&
          userModel.password == userModel.confirmPassword) {
        final model = await sendOtp();
        if (model != null) {
          Get.toNamed(Routes.otp);
// check mail toast
        }
      } else {
        //todo toast password mismatch
      }
    }
  }

  goToOTPPage() async {
    if (formKeyForgotPassword.currentState!.validate()) {
      formKeyForgotPassword.currentState!.save();
      //todo send otp with email id
      final model = await sendOtp();
      if (model != null) {
        Get.toNamed(Routes.otp);
// check mail toast
      }
    }
  }
}
