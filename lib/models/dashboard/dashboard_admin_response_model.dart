// To parse this JSON data, do
//
//     final dashboardAdminResponseModel = dashboardAdminResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardAdminResponseModel dashboardAdminResponseModelFromJson(String str) =>
    DashboardAdminResponseModel.fromJson(json.decode(str));

String dashboardAdminResponseModelToJson(DashboardAdminResponseModel data) =>
    json.encode(data.toJson());

class DashboardAdminResponseModel {
  DashboardAdminResponseModel({
    this.message,
    this.projectsCount,
    this.attendanceCount,
    this.absenteesCount,
    this.employeesCount,
    this.meetingsCount,
  });

  String? message;
  int? projectsCount;
  int? attendanceCount;
  int? absenteesCount;
  int? employeesCount;
  int? meetingsCount;

  factory DashboardAdminResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardAdminResponseModel(
        message: json["message"],
        projectsCount: json["projects_count"],
        attendanceCount: json["attendance_count"],
        absenteesCount: json["absentees_count"],
        employeesCount: json["employees_count"],
        meetingsCount: json["meetings_count"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "projects_count": projectsCount,
        "attendance_count": attendanceCount,
        "absentees_count": absenteesCount,
        "employees_count": employeesCount,
        "meetings_count": meetingsCount,
      };
}
