// To parse this JSON data, do
//
//     final otpRequestWithEmailModel = otpRequestWithEmailModelFromJson(jsonString);

import 'dart:convert';

OtpRequestWithEmailModel? otpRequestWithEmailModelFromJson(String str) =>
    OtpRequestWithEmailModel.fromJson(json.decode(str));

String otpRequestWithEmailModelToJson(OtpRequestWithEmailModel? data) =>
    json.encode(data!.toJson());

class OtpRequestWithEmailModel {
  OtpRequestWithEmailModel({
    this.otp,
    this.email,
  });

  String? otp;
  String? email;

  factory OtpRequestWithEmailModel.fromJson(Map<String, dynamic> json) =>
      OtpRequestWithEmailModel(
        otp: json["otp"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "email": email,
      };
}
