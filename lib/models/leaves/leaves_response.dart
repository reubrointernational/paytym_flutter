// To parse this JSON data, do
//
//     final leaveResponseModel = leaveResponseModelFromJson(jsonString);

import 'dart:convert';

LeaveResponseModel leaveResponseModelFromJson(String str) =>
    LeaveResponseModel.fromJson(json.decode(str));

String leaveResponseModelToJson(LeaveResponseModel data) =>
    json.encode(data.toJson());

class LeaveResponseModel {
  LeaveResponseModel({
    this.message,
    this.leaveRequests,
  });

  String? message;
  List<LeaveRequest>? leaveRequests;

  factory LeaveResponseModel.fromJson(Map<String, dynamic> json) =>
      LeaveResponseModel(
        message: json["message"],
        leaveRequests: List<LeaveRequest>.from(
            json["leaveRequests"].map((x) => LeaveRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "leaveRequests":
            List<dynamic>.from(leaveRequests!.map((x) => x.toJson())),
      };
}

class LeaveRequest {
  LeaveRequest({
    this.id,
    this.userId,
    this.title,
    this.startDate,
    this.endDate,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? title;
  String? startDate;
  String? endDate;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "start_date": startDate,
        "end_date": endDate,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
