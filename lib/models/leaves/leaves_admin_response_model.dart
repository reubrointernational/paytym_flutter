// To parse this JSON data, do
//
//     final leavesListAdminModel = leavesListAdminModelFromJson(jsonString);

import 'dart:convert';

LeavesListAdminModel leavesListAdminModelFromJson(String str) =>
    LeavesListAdminModel.fromJson(json.decode(str));

String leavesListAdminModelToJson(LeavesListAdminModel data) =>
    json.encode(data.toJson());

class LeavesListAdminModel {
  LeavesListAdminModel({
    required this.message,
    required this.leaveRequest,
  });

  String message;
  List<LeaveRequest> leaveRequest;

  factory LeavesListAdminModel.fromJson(Map<String, dynamic> json) =>
      LeavesListAdminModel(
        message: json["message"],
        leaveRequest: List<LeaveRequest>.from(
            json["leaveRequest"].map((x) => LeaveRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "leaveRequest": List<dynamic>.from(leaveRequest.map((x) => x.toJson())),
      };
}

class LeaveRequest {
  LeaveRequest({
    required this.id,
    required this.userId,
    required this.employerId,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  int employerId;
  String title;
  String? startDate;
  String? endDate;
  String type;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
        id: json["id"],
        userId: json["user_id"],
        employerId: json["employer_id"],
        title: json["title"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employer_id": employerId,
        "title": title,
        "start_date": startDate,
        "end_date": endDate,
        "type": type,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
