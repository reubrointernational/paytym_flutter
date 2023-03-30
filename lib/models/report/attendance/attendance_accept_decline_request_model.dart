// To parse this JSON data, do
//
//     final attendanceAcceptDeclineRequestModel = attendanceAcceptDeclineRequestModelFromJson(jsonString);

import 'dart:convert';

AttendanceAcceptDeclineRequestModel attendanceAcceptDeclineRequestModelFromJson(
        String str) =>
    AttendanceAcceptDeclineRequestModel.fromJson(json.decode(str));

String attendanceAcceptDeclineRequestModelToJson(
        AttendanceAcceptDeclineRequestModel data) =>
    json.encode(data.toJson());

class AttendanceAcceptDeclineRequestModel {
  AttendanceAcceptDeclineRequestModel({
    required this.employeeId,
    required this.approvalStatus,
    required this.attendanceId,
    this.reason = '',
  });

  String employeeId;
  String approvalStatus;
  String attendanceId;
  String reason;

  factory AttendanceAcceptDeclineRequestModel.fromJson(
          Map<String, dynamic> json) =>
      AttendanceAcceptDeclineRequestModel(
        employeeId: json["employee_id"],
        approvalStatus: json["status"],
        attendanceId: json["attendance_id"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "status": approvalStatus,
        "attendance_id": attendanceId,
        "reason": reason,
      };
}
