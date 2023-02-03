// To parse this JSON data, do
//
//     final leaveRequestModel = leaveRequestModelFromJson(jsonString);

import 'dart:convert';

LeaveRequestModel leaveRequestModelFromJson(String str) =>
    LeaveRequestModel.fromJson(json.decode(str));

String leaveRequestModelToJson(LeaveRequestModel data) =>
    json.encode(data.toJson());

class LeaveRequestModel {
  LeaveRequestModel({
    this.startDate,
    this.endDate,
    this.type = 'annual',
    this.title,
  });

  String? startDate;
  String? endDate;
  String type;
  String? title;

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) =>
      LeaveRequestModel(
        startDate: json["start_date"],
        endDate: json["end_date"],
        type: json["type"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "start_date": startDate,
        "end_date": endDate,
        "type": type,
        "title": title,
      };
}
