// To parse this JSON data, do
//
//     final passwordResetRequestModel = passwordResetRequestModelFromJson(jsonString);

import 'dart:convert';

PasswordResetRequestModel passwordResetRequestModelFromJson(String str) =>
    PasswordResetRequestModel.fromJson(json.decode(str));

String passwordResetRequestModelToJson(PasswordResetRequestModel data) =>
    json.encode(data.toJson());

class PasswordResetRequestModel {
  PasswordResetRequestModel({
    this.password,
    this.passwordConfirmation,
  });

  String? password;
  String? passwordConfirmation;

  factory PasswordResetRequestModel.fromJson(Map<String, dynamic> json) =>
      PasswordResetRequestModel(
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "password_confirmation": passwordConfirmation,
      };
}
