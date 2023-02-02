// To parse this JSON data, do
//
//     final otpRequestModel = otpRequestModelFromJson(jsonString);

import 'dart:convert';

OtpRequestModel otpRequestModelFromJson(String str) =>
    OtpRequestModel.fromJson(json.decode(str));

String otpRequestModelToJson(OtpRequestModel data) =>
    json.encode(data.toJson());

class OtpRequestModel {
  OtpRequestModel({
    this.otp,
  });

  String? otp;

  factory OtpRequestModel.fromJson(Map<String, dynamic> json) =>
      OtpRequestModel(
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
      };
}
