// To parse this JSON data, do
//
//     final passwordResetWithEmailModel = passwordResetWithEmailModelFromJson(jsonString);

import 'dart:convert';

PasswordResetWithEmailModel? passwordResetWithEmailModelFromJson(String str) =>
    PasswordResetWithEmailModel.fromJson(json.decode(str));

String passwordResetWithEmailModelToJson(PasswordResetWithEmailModel? data) =>
    json.encode(data!.toJson());

class PasswordResetWithEmailModel {
  PasswordResetWithEmailModel({
    this.password,
    this.cPassword,
    this.email,
  });

  String? password;
  String? cPassword;
  String? email;

  factory PasswordResetWithEmailModel.fromJson(Map<String, dynamic> json) =>
      PasswordResetWithEmailModel(
        password: json["password"],
        cPassword: json["c_password"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "c_password": cPassword,
        "email": email,
      };
}
