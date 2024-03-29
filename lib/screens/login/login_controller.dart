import 'dart:convert';

import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/models/login/login_request_model.dart';
import 'package:paytym/models/login/login_response_model.dart';
import 'package:paytym/models/login/otp_request_with_email_model.dart';
import 'package:paytym/models/login/password_reset_request_with_email_model.dart';
import 'package:paytym/models/login/user_model.dart';
import 'package:paytym/models/message_only_response_model.dart';
import 'package:paytym/models/login/otp_request_model.dart';
import 'package:paytym/models/login/password_reset_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../network/base_client.dart';
import '../../network/base_controller.dart';
import '../../network/end_points.dart';
import '../../network/shared_preference_helper.dart';
import '../../routes/app_routes.dart';

class LoginController extends GetxController with BaseController {
  LoginResponseModel? loginResponseModel;
  UserModel userModel = UserModel();
  final formKey = GlobalKey<FormState>();
  final formKeyForgotPassword = GlobalKey<FormState>();
  final formKeyResetPassword = GlobalKey<FormState>();
  RxList<String> otpList = ['', '', '', ''].obs;

  Map<String, String>? getHeader() {
    return {
      'content-type': 'application/json',
      'Authorization': 'Bearer ${loginResponseModel?.token}'
    };
  }

  Future<bool> fetchLoginData() async {
    /// if login data is already present in storage it will not connect to server.
    /// login data is stored in after password reset is complete for the first time
    /// loginResponseModel is filled in splash screen from sharedPreferences if available
    if (loginResponseModel == null) {
      showLoading();

      LoginRequestModel loginRequestModel = LoginRequestModel(
          email: userModel.email, password: userModel.password);

      var responseString = await Get.find<BaseClient>()
          .post(ApiEndPoints.login, loginRequestModelToJson(loginRequestModel))
          .catchError(handleError);

      if (responseString == null) {
        return false;
      } else {
        hideLoading();
        loginResponseModel = loginResponseModelFromJson(responseString);
        return true;
      }
    }

    return true;
  }

  //if otp is send from forgot password page token is not needed, instead email is provided to identify the user
  Future<MessageOnlyResponseModel?> sendOtp() async {
    showLoading();
    String json = jsonEncode({"email": userModel.email});
    var responseString = loginResponseModel?.token != null
        ? await Get.find<BaseClient>()
            .post(ApiEndPoints.sendOtp, null, getHeader())
            .catchError(handleError)
        : await Get.find<BaseClient>()
            .post(ApiEndPoints.sendOtpToEmail, json, null)
            .catchError(handleError);
    hideLoading();
    return responseString == null
        ? null
        : messageOnlyResponseModelFromJson(responseString);
  }

  //if otp is send from forgot password page token is not needed, instead email is provided to identify the user
  Future<MessageOnlyResponseModel?> confirmOtp(String otp) async {
    showLoading();
    OtpRequestModel otpRequestModel = OtpRequestModel(otp: otp);

    OtpRequestWithEmailModel otpRequestWithEmailModel =
        OtpRequestWithEmailModel(otp: otp, email: userModel.email);

    var responseString = loginResponseModel?.token != null
        ? await Get.find<BaseClient>()
            .post(ApiEndPoints.confirmOtp,
                otpRequestModelToJson(otpRequestModel), getHeader())
            .catchError(handleError)
        : await Get.find<BaseClient>()
            .post(ApiEndPoints.confirmOtpWithEmail,
                otpRequestWithEmailModelToJson(otpRequestWithEmailModel), null)
            .catchError(handleError);

    if (responseString == null) {
      return null;
    } else {
      hideLoading();
      return messageOnlyResponseModelFromJson(responseString);
    }
  }

//endpoint: password-update
//if otp is send from forgot password page token is not needed, instead email is provided to identify the user
  Future<MessageOnlyResponseModel?> updatePassword() async {
    showLoading();
    PasswordResetRequestModel passwordResetRequestModel =
        PasswordResetRequestModel(
            password: userModel.password,
            passwordConfirmation: userModel.confirmPassword);

    PasswordResetWithEmailModel passwordResetWithEmailModel =
        PasswordResetWithEmailModel(
            password: userModel.password,
            cPassword: userModel.confirmPassword,
            email: userModel.email);

    var responseString = loginResponseModel?.token != null
        ? await Get.find<BaseClient>()
            .post(
                ApiEndPoints.updatePassword,
                passwordResetRequestModelToJson(passwordResetRequestModel),
                getHeader())
            .catchError(handleError)
        : await Get.find<BaseClient>()
            .post(
                ApiEndPoints.resetPasswordWithEmail,
                passwordResetWithEmailModelToJson(passwordResetWithEmailModel),
                null)
            .catchError(handleError);

    if (responseString == null) {
      return null;
    } else {
      hideLoading();

      /// store loginResponseModel to sharedPreferences
      //isFirst = 1 => first time login
      loginResponseModel?.employee?.isFirst = '0';
      await Get.find<SharedPreferenceHelper>()
          .addUserDetails(loginResponseModel);
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

  validateAndGoToMainOrOtpPage() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      goToMainOrOtpPage();
    }
  }

  goToMainOrOtpPage() async {
    bool isSuccess = await fetchLoginData();
    if (isSuccess) {
      //isFirst = 1 => first time login
      if (loginResponseModel?.employee?.isFirst == '1') {
        await Get.find<LoginController>().sendOtp();
        Get.toNamed(Routes.otp);
      } else if (loginResponseModel?.employee?.isFirst == '0') {
        Get.offAndToNamed(Routes.bottomNav);
      }
    }
  }

  goToPasswordResetPage(String otp) async {
    if (otp.isNotEmpty) {
      MessageOnlyResponseModel? model = await confirmOtp(otp);
      if (model != null) {
        Get.toNamed(Routes.resetPassword);
      }
    }
  }

  goToMainPageFromPasswordResetPage() async {
    if (formKeyResetPassword.currentState!.validate()) {
      formKeyResetPassword.currentState!.save();
      if (userModel.password.isNotEmpty &&
          userModel.password == userModel.confirmPassword) {
        MessageOnlyResponseModel? confirmModel = await updatePassword();
        if (confirmModel != null) {
          Get.offAllNamed(Routes.bottomNav);
        }
      }
    }
  }

  goToOTPPage() async {
    if (formKeyForgotPassword.currentState!.validate()) {
      formKeyForgotPassword.currentState!.save();
      loginResponseModel?.token = null;
      await Get.find<LoginController>().sendOtp();
      Get.toNamed(Routes.otp);
    }
  }
}
