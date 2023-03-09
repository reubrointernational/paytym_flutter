import 'dart:convert';

AttendanceEditResponseModel attendanceEditResponseModelFromJson(String str) => AttendanceEditResponseModel.fromJson(json.decode(str));

String attendanceEditResponseModelToJson(AttendanceEditResponseModel data) => json.encode(data.toJson());

class AttendanceEditResponseModel {
    AttendanceEditResponseModel({
        required this.message,
    });

    String message;

    factory AttendanceEditResponseModel.fromJson(Map<String, dynamic> json) => AttendanceEditResponseModel(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}