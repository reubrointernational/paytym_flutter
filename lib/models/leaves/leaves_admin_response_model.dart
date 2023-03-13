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
    this.message,
    this.leaveRequest,
  });

  String? message;
  List<LeaveRequest>? leaveRequest;

  factory LeavesListAdminModel.fromJson(Map<String, dynamic> json) =>
      LeavesListAdminModel(
        message: json["message"],
        leaveRequest: List<LeaveRequest>.from(
            json["leaveRequest"].map((x) => LeaveRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "leaveRequest":
            List<dynamic>.from(leaveRequest!.map((x) => x.toJson())),
      };
}

class LeaveRequest {
  LeaveRequest({
    this.id,
    this.userId,
    this.employerId,
    this.title,
    this.startDate,
    this.endDate,
    this.reason,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? userId;
  int? employerId;
  String? title;
  String? startDate;
  String? endDate;
  dynamic reason;
  String? type;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
        id: json["id"],
        userId: json["user_id"],
        employerId: json["employer_id"],
        title: json["title"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        reason: json["reason"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employer_id": employerId,
        "title": title,
        "start_date": startDate,
        "end_date": endDate,
        "reason": reason,
        "type": type,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user?.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  int id;
  String firstName;
  String lastName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
      };
}
