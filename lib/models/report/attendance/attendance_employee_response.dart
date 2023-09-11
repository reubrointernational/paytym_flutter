import 'dart:convert';

AttendanceEmployeeResponseModel attendanceEmployeeResponseModelFromJson(
        String str) =>
    AttendanceEmployeeResponseModel.fromJson(json.decode(str));

String attendanceEmployeeResponseModelToJson(
        AttendanceEmployeeResponseModel data) =>
    json.encode(data.toJson());

class AttendanceEmployeeResponseModel {
  AttendanceEmployeeResponseModel({
    this.message,
    this.history,
    this.ontime,
    this.late,
    this.earlyout,
    this.leaves,
  });

  String? message;
  List<History>? history;
  int? ontime;
  int? late;
  int? earlyout;
  int? leaves;

  factory AttendanceEmployeeResponseModel.fromJson(Map<String, dynamic> json) =>
      AttendanceEmployeeResponseModel(
        message: json["message"],
        history:
            List<History>.from(json["history"].map((x) => History.fromJson(x))),
        ontime: json["ontime"] ?? 0,
        late: json["late"] ?? 0,
        earlyout: json["earlyout"] ?? 0,
        leaves: json["leaves"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "history": List<dynamic>.from(history!.map((x) => x.toJson())),
        "ontime": ontime,
        "late": late,
        "earlyout": earlyout,
        "leaves": leaves,
      };
}

class History {
  History({
    required this.id,
    required this.userId,
    required this.employerId,
    required this.checkIn,
    this.checkOut,
    required this.status,
    this.approveReject,
    this.reason,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  int employerId;
  DateTime checkIn;
  DateTime? checkOut;
  String status;
  String? approveReject;
  dynamic reason;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        userId: json["user_id"],
        employerId: json["employer_id"],
        checkIn: DateTime.parse(json["check_in"]),
        checkOut: json["check_out"] == null
            ? null
            : DateTime.parse(json["check_out"]),
        status: json["status"],
        approveReject: json["approve_reject"],
        reason: json["reason"],
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employer_id": employerId,
        "check_in": checkIn.toIso8601String(),
        "check_out": checkOut?.toIso8601String(),
        "status": status,
        "approve_reject": approveReject,
        "reason": reason,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
