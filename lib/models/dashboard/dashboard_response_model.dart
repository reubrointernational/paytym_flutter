// To parse this JSON data, do
//
//     final dashboardResponseModel = dashboardResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardResponseModel dashboardResponseModelFromJson(String str) =>
    DashboardResponseModel.fromJson(json.decode(str));

String dashboardResponseModelToJson(DashboardResponseModel data) =>
    json.encode(data.toJson());

class DashboardResponseModel {
  DashboardResponseModel({
    this.message,
    this.casual,
    this.absence,
    this.annual,
    this.halfday,
    this.sick,
    this.lateArrival,
    this.totalWorkDays,
    this.hours,
  });

  String? message;
  int? casual;
  int? absence;
  int? annual;
  int? halfday;
  int? sick;
  int? lateArrival;
  int? totalWorkDays;
  int? hours;

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardResponseModel(
        message: json["message"],
        casual: json["casual"],
        absence: json["absence"],
        annual: json["annual"],
        halfday: json["halfday"],
        sick: json["sick"],
        lateArrival: json["late_arrival"],
        totalWorkDays: json["total_work_days"],
        hours: json["hours"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "casual": casual,
        "absence": absence,
        "annual": annual,
        "halfday": halfday,
        "sick": sick,
        "late_arrival": lateArrival,
        "total_work_days": totalWorkDays,
        "hours": hours,
      };
}
