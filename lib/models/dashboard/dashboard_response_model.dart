// To parse this JSON data, do
//
//     final dashboardResponseModel = dashboardResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardResponseModel dashboardResponseModelFromJson(String str) =>
    DashboardResponseModel.fromJson(json.decode(str));

String dashboardResponseModelToJson(DashboardResponseModel data) =>
    json.encode(data.toJson());

class DashboardResponseModel {
  DashboardResponseModel(
      {this.message,
      this.casual,
      this.absence,
      this.annual,
      this.halfday,
      this.sick,
      this.lateArrival,
      this.totalWorkDays,
      this.hours,
      this.rosterCheckInTime,
      this.nextShift,
      this.lastCheckedIn,
      this.allowedAbsent,
      this.allowedAnnualLeave,
      this.allowedLateArrival,
      this.allowedSickLeave});

  String? message;
  int? casual;
  int? absence;
  int? annual;
  int? halfday;
  int? sick;
  int? lateArrival;
  int? totalWorkDays;
  int? hours;
  String? rosterCheckInTime;
  NextShift? nextShift;
  DateTime? lastCheckedIn;
  int? allowedAbsent;
  int? allowedSickLeave;
  int? allowedAnnualLeave;
  int? allowedLateArrival;

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardResponseModel(
        message: json["message"],
        casual: json["casual"],
        absence: json["absence"],
        annual: json["annual"],
        halfday: json["halfday"],
        sick: json["sick"],
        lateArrival: json["late_arrival"],
        totalWorkDays: json["total_work_days"],
        hours: json["hours"],
        rosterCheckInTime: json["roster_check_in_time"],
        nextShift: json["next shift"] == null
            ? null
            : NextShift.fromJson(json["next shift"]),
        lastCheckedIn: json["last_checked_in"] == null
            ? null
            : DateTime.parse(json["last_checked_in"]),
        allowedAbsent: json["allowed_absent"],
        allowedSickLeave: json["allowed_sick_leave"],
        allowedAnnualLeave: json["allowed_annual_leave"],
        allowedLateArrival: json["allowed_late_arrival"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "casual": casual,
        "absence": absence,
        "annual": annual,
        "halfday": halfday,
        "sick": sick,
        "late_arrival": lateArrival,
        "total_work_days": totalWorkDays,
        "hours": hours,
        "roster_check_in_time": rosterCheckInTime,
        "next shift": nextShift?.toJson(),
        "last_checked_in": lastCheckedIn?.toIso8601String(),
        "allowed_absent": allowedAbsent,
        "allowed_sick_leave": allowedSickLeave,
        "allowed_annual_leave": allowedAnnualLeave,
        "allowed_late_arrival": allowedLateArrival,
      };
}

class NextShift {
  NextShift({
    this.id,
    this.employerId,
    this.userId,
    this.projectId,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.jobId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? employerId;
  int? userId;
  int? projectId;
  DateTime? startDate;
  String? startTime;
  DateTime? endDate;
  String? endTime;
  dynamic jobId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NextShift.fromJson(Map<String, dynamic> json) => NextShift(
        id: json["id"],
        employerId: json["employer_id"],
        userId: json["user_id"],
        projectId: json["project_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        startTime: json["start_time"],
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        endTime: json["end_time"],
        jobId: json["job_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "user_id": userId,
        "project_id": projectId,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "end_time": endTime,
        "job_id": jobId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
