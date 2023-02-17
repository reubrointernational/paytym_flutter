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
    required this.employeeId,
    required this.approvalStatus,
    required this.startDate,
  });

  String employeeId;
  String approvalStatus;
  String startDate;

  factory LeaveAcceptDeclineRequestModel.fromJson(Map<String, dynamic> json) =>
      LeaveAcceptDeclineRequestModel(
        employeeId: json["employee_id"],
        approvalStatus: json["approval_status"],
        startDate: json["start_date"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "approval_status": approvalStatus,
        "start_date":
            startDate,
      };
}
