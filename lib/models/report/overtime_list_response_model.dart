// To parse this JSON data, do
//
//     final overtimeListResponseModel = overtimeListResponseModelFromJson(jsonString);

import 'dart:convert';

OvertimeListResponseModel overtimeListResponseModelFromJson(String str) =>
    OvertimeListResponseModel.fromJson(json.decode(str));

String overtimeListResponseModelToJson(OvertimeListResponseModel data) =>
    json.encode(data.toJson());

class OvertimeListResponseModel {
  OvertimeListResponseModel({
    required this.message,
    required this.employeeList,
  });

  String message;
  List<EmployeeList> employeeList;

  factory OvertimeListResponseModel.fromJson(Map<String, dynamic> json) =>
      OvertimeListResponseModel(
        message: json["message"],
        employeeList: List<EmployeeList>.from(
            json["employee_list"].map((x) => EmployeeList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "employee_list":
            List<dynamic>.from(employeeList.map((x) => x.toJson())),
      };
}

class EmployeeList {
  EmployeeList({
    required this.id,
    required this.employerId,
    required this.employeeId,
    required this.date,
    required this.totalHours,
    required this.status,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int employerId;
  int employeeId;
  DateTime date;
  String totalHours;
  String status;
  String reason;
  DateTime createdAt;
  DateTime updatedAt;

  factory EmployeeList.fromJson(Map<String, dynamic> json) => EmployeeList(
        id: json["id"],
        employerId: json["employer_id"],
        employeeId: json["employee_id"],
        date: DateTime.parse(json["date"]),
        totalHours: json["total_hours"],
        status: json["status"],
        reason: json["reason"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "employee_id": employeeId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "total_hours": totalHours,
        "status": status,
        "reason": reason,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
