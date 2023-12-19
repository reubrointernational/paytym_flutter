// To parse this JSON data, do
//
//     final attendanceByHrRequestModel = attendanceByHrRequestModelFromJson(jsonString);

import 'dart:convert';

AttendanceByHrRequestModel attendanceByHrRequestModelFromJson(String str) =>
    AttendanceByHrRequestModel.fromJson(json.decode(str));

String attendanceByHrRequestModelToJson(AttendanceByHrRequestModel data) =>
    json.encode(data.toJson());

class AttendanceByHrRequestModel {
  String employerId;
  String employeeId;
  String? checkInTime;
  String? checkOutTime;
  String date;

  AttendanceByHrRequestModel({
    required this.employerId,
    required this.employeeId,
    this.checkInTime,
    this.checkOutTime,
    required this.date,
  });


  factory AttendanceByHrRequestModel.fromJson(Map<String, dynamic> json) =>
      AttendanceByHrRequestModel(
        employerId: json['employee']['employer_id'],
        employeeId: json['employee']['employer_id'],
        checkInTime: json['employee']['last_checked_in'],
        checkOutTime: json['employee']['check_out_default'],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "employer_id": employerId,
        "employee_id": employeeId,
        "check_in_time": checkInTime,
        "check_out_time": checkOutTime,
        "date": date,
      };
}
