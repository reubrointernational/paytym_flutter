// To parse this JSON data, do
//
//     final overtimeApproveEditRequestModel = overtimeApproveEditRequestModelFromJson(jsonString);

import 'dart:convert';

String advanceApproveEditRequestModelToJson(
        AdvanceApproveEditRequestModel data) =>
    json.encode(data.toJson());

class AdvanceApproveEditRequestModel {
  AdvanceApproveEditRequestModel({
    required this.status,
    required this.id,
    this.employerId,
    this.employeeId,
    this.date,
    this.totalHours,
    this.reason,
    this.amount,
    this.declineReason,
  });

  String status;
  String id;
  String? employerId;
  String? employeeId;
  String? date;
  String? amount;
  String? totalHours;
  String? reason;
  String? declineReason;

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "employer_id": employerId,
        "employee_id": employeeId,
        "date": date,
        "amount": amount,
        "total_hours": totalHours,
        "reason": reason,
        "decline_reason": declineReason,
      };
}

class DateofRequired {
  DateofRequired({
    required this.status,
    required this.id,
    this.employerId,
    this.employeeId,
    this.date,
    this.totalHours,
    this.reason,
    this.amount,
    this.declineReason,
  });

  String status;
  String id;
  String? employerId;
  String? employeeId;
  String? date;
  String? totalHours;
  String? reason;
  String? amount;
  String? declineReason;

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "employer_id": employerId,
        "employee_id": employeeId,
        "date": date,
        "amount": amount,
        "total_hours": totalHours,
        "reason": reason,
        "decline_reason": declineReason,
      };
}
