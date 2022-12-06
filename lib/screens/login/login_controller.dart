import 'package:paytym/models/login/login_request_model.dart';
import 'package:paytym/models/login/login_response_model.dart';
import 'package:paytym/models/login/user_model.dart';
import 'package:paytym/models/message_only_response_model.dart';
import 'package:paytym/models/login/otp_request_model.dart';
import 'package:paytym/models/login/password_reset_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/network/shared_preference_helper.dart';

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
  RxList<String> otpList = ['', '', '', ''].obs;

  Map<String, String>? getHeader() {
    return {
      'content-type': 'application/json',
      'Authorization': 'Bearer ${userModel.token}'
    };
  }

  Future<bool> fetchLoginData(bool isloadingOn) async {
    if (isloadingOn) showLoading();

    if (!isloadingOn) Get.find<BaseClient>().onErrorBool = goToMainOrOtpPage;

    LoginRequestModel loginRequestModel =
        LoginRequestModel(email: userModel.email, password: userModel.password);

    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.login, loginRequestModelToJson(loginRequestModel))
        .catchError(handleError);

    if (responseString == null) {
      return false;
    } else {
      hideLoading();
      loginResponseModel = loginResponseModelFromJson(responseString);
      if (!isloadingOn) Get.find<BaseClient>().onErrorBool = null;
      return true;
    }
  }

  Future<MessageOnlyResponseModel?> sendOtp() async {
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.sendOtp, null, getHeader())
        .catchError(handleError);

    return responseString == null
        ? null
        : messageOnlyResponseModelFromJson(responseString);
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

  validateAndGoToMainOrOtpPage() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      goToMainOrOtpPage();
    }
  }

  goToMainOrOtpPage([bool showLoading = true]) async {
    bool isSuccess = await fetchLoginData(showLoading);
    if (isSuccess) {
      await Get.find<SharedPreferenceHelper>()
          .addUserLoginCredentials(userModel.email, userModel.password);
      userModel.token = loginResponseModel?.token;
      //isFirst = 1 => first time login
      if (loginResponseModel?.employee?.isFirst == '1') {
        Get.offAndToNamed(Routes.otp);
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
        //todo show toast if otp is not confirmed

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
          Get.toNamed(Routes.login);
        }
      } else {
        //todo toast password mismatch
      }
    }
  }

//todo need to complete once otp api without authorization is finished
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
