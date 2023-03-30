import 'dart:convert';

AttendanceEditRequestModel attendanceEditRequestModelFromJson(String str) =>
    AttendanceEditRequestModel.fromJson(json.decode(str));

String attendanceEditRequestModelToJson(AttendanceEditRequestModel data) =>
    json.encode(data.toJson());

class AttendanceEditRequestModel {
  AttendanceEditRequestModel({
    required this.attendanceId,
    required this.checkIn,
    required this.checkOut,
    required this.reason,
  });

  String attendanceId;
  String checkIn;
  String checkOut;
  String reason;

  factory AttendanceEditRequestModel.fromJson(Map<String, dynamic> json) =>
      AttendanceEditRequestModel(
        attendanceId: json["attendance_id"],
        checkIn: json["check_in"],
        checkOut: json["check_out"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "attendance_id": attendanceId,
        "check_out": checkOut,
        "check_in": checkIn,
        "reason": reason,
      };
}
