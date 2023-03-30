// To parse this JSON data, do
//
//     final leaveAcceptDeclineRequestModel = leaveAcceptDeclineRequestModelFromJson(jsonString);

import 'dart:convert';

LeaveAcceptDeclineRequestModel leaveAcceptDeclineRequestModelFromJson(
        String str) =>
    LeaveAcceptDeclineRequestModel.fromJson(json.decode(str));

String leaveAcceptDeclineRequestModelToJson(
        LeaveAcceptDeclineRequestModel data) =>
    json.encode(data.toJson());

class LeaveAcceptDeclineRequestModel {
  LeaveAcceptDeclineRequestModel({
    this.employeeId,
    this.approvalStatus,
    this.leaveRequestId,
    this.reason,
  });

  String? employeeId;
  String? approvalStatus;
  String? leaveRequestId;
  String? reason;

  factory LeaveAcceptDeclineRequestModel.fromJson(Map<String, dynamic> json) =>
      LeaveAcceptDeclineRequestModel(
        employeeId: json["employee_id"],
        approvalStatus: json["approval_status"],
        leaveRequestId: json["leave_request_id"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "approval_status": approvalStatus,
        "leave_request_id": leaveRequestId,
        "reason": reason,
      };
}
