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
    this.activeEmployeesCount,
    this.pendingLeaves,
  });

  String? message;
  int? projectsCount;
  int? attendanceCount;
  int? absenteesCount;
  int? employeesCount;
  int? meetingsCount;
  int? pendingLeaves;
  int? activeEmployeesCount;

  factory DashboardAdminResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardAdminResponseModel(
        message: json["message"],
        projectsCount: json["projects_count"],
        attendanceCount: json["attendance_count"],
        absenteesCount: json["absentees_count"],
        employeesCount: json["employees_count"],
        meetingsCount: json["meetings_count"],
        pendingLeaves: json["pending_leaves"],
        activeEmployeesCount: json["active_employees_count"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "projects_count": projectsCount,
        "attendance_count": attendanceCount,
        "absentees_count": absenteesCount,
        "employees_count": employeesCount,
        "meetings_count": meetingsCount,
        "pending_leaves": pendingLeaves,
        "active_employees_count": activeEmployeesCount,
      };
}
