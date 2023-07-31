// To parse this JSON data, do
//
//     final leaveResponseModel = leaveResponseModelFromJson(jsonString);

/*import 'dart:convert';

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
    this.status = 'Awaiting',
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? title;
  String? startDate;
  String? endDate;
  int? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  String status;

  factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
        id: json["id"],
        userId: json["user_id"],
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
        "title": title,
        "start_date": startDate,
        "end_date": endDate,
        "type": type,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}*/

import 'dart:convert';

LeaveResponseModel leaveResponseModelFromJson(String str) =>
    LeaveResponseModel.fromJson(json.decode(str));

String leaveResponseModelToJson(LeaveResponseModel data) =>
    json.encode(data.toJson());

class LeaveResponseModel {
  LeaveResponseModel({
    this.message,
    this.leaveRequests,
    this.leaveTypes,
  });

  String? message;
  List<LeaveRequest>? leaveRequests;
  List<dynamic>? leaveTypes;

  factory LeaveResponseModel.fromJson(Map<String, dynamic> json) =>
      LeaveResponseModel(
        message: json["message"],
        leaveRequests: List<LeaveRequest>.from(
            json["leaveRequests"].map((x) => LeaveRequest.fromJson(x))),
        leaveTypes: List<dynamic>.from(json["leave_types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "leaveRequests":
            List<dynamic>.from(leaveRequests!.map((x) => x.toJson())),
        "leave_types": List<dynamic>.from(leaveTypes!.map((x) => x)),
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
    this.leaveType,
  });

  int? id;
  int? userId;
  int? employerId;
  String? title;
  String? startDate;
  String? endDate;
  dynamic reason;
  int? type;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  LeaveType? leaveType;

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
        leaveType: json["leave_type"] != null
            ? LeaveType.fromJson(json["leave_type"])
            : LeaveType(
                id: -1, leaveType: '', noOfDaysAllowed: 0, employerId: -1),
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "leave_type": leaveType!.toJson(),
      };
}

class LeaveType {
  LeaveType({
    required this.id,
    required this.leaveType,
    required this.noOfDaysAllowed,
    required this.employerId,
  });

  int id;
  String leaveType;
  int noOfDaysAllowed;
  int employerId;

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
        id: json["id"],
        leaveType: json["leave_type"],
        noOfDaysAllowed: json["no_of_days_allowed"],
        employerId: json["employer_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "leave_type": leaveType,
        "no_of_days_allowed": noOfDaysAllowed,
        "employer_id": employerId,
      };
}
