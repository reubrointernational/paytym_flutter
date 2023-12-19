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
        employerId: json['employer_id'],
        employeeId: json['employee_id'],
        checkInTime: json['check_in_time'],
        checkOutTime: json['check_out_time'],
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
