import 'dart:convert';

AttendanceEditRequestModel attendanceEditRequestModelFromJson(String str) => AttendanceEditRequestModel.fromJson(json.decode(str));

String attendanceEditRequestModelToJson(AttendanceEditRequestModel data) => json.encode(data.toJson());

class AttendanceEditRequestModel {
    AttendanceEditRequestModel({
        required this.employeeId,
        required this.date,
        required this.checkIn,
        required this.checkOut,
        required this.reason,
    });

    String employeeId;
    String date;
    String checkIn;
    String checkOut;
    String reason;

    factory AttendanceEditRequestModel.fromJson(Map<String, dynamic> json) => AttendanceEditRequestModel(
        employeeId: json["employee_id"],
        date: json["date"],
        checkIn: json["check_in"],
        checkOut: json["check_out"],
        reason: json["reason"],
    );

    Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "date": date,
        "check_out": checkOut,
        "check_in": checkIn,
        "reason": reason,
    };
}