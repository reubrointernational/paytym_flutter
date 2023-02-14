// To parse this JSON data, do
//
//     final requestOvertimeModel = requestOvertimeModelFromJson(jsonString);

import 'dart:convert';

RequestOvertimeModel requestOvertimeModelFromJson(String str) =>
    RequestOvertimeModel.fromJson(json.decode(str));

String requestOvertimeModelToJson(RequestOvertimeModel data) =>
    json.encode(data.toJson());

class RequestOvertimeModel {
  RequestOvertimeModel({
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.reason,
  });

  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? reason;
  factory RequestOvertimeModel.fromJson(Map<String, dynamic> json) =>
      RequestOvertimeModel(
        startDate: json["startDate"],
        endDate: json["endDate"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "startTime": startTime,
        "endTime": endTime,
        "reason": reason,
      };
}
