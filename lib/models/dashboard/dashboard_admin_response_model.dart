// To parse this JSON data, do
//
//     final dashboardAdminResponseModel = dashboardAdminResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardAdminResponseModel dashboardAdminResponseModelFromJson(String str) =>
    DashboardAdminResponseModel.fromJson(json.decode(str));

String dashboardAdminResponseModelToJson(DashboardAdminResponseModel data) =>
    json.encode(data.toJson());

class DashboardAdminResponseModel {
  DashboardAdminResponseModel({
    required this.message,
    required this.casual,
    required this.absence,
    required this.annual,
    required this.halfday,
  });

  String message;
  int casual;
  int absence;
  int annual;
  int halfday;

  factory DashboardAdminResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardAdminResponseModel(
        message: json["message"],
        casual: json["casual"],
        absence: json["absence"],
        annual: json["annual"],
        halfday: json["halfday"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "casual": casual,
        "absence": absence,
        "annual": annual,
        "halfday": halfday,
      };
}
