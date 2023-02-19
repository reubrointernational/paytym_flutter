// To parse this JSON data, do
//
//     final meetingListAdminModel = meetingListAdminModelFromJson(jsonString);

import 'dart:convert';

MeetingListAdminModel meetingListAdminModelFromJson(String str) =>
    MeetingListAdminModel.fromJson(json.decode(str));

String meetingListAdminModelToJson(MeetingListAdminModel data) =>
    json.encode(data.toJson());

class MeetingListAdminModel {
  MeetingListAdminModel({
    required this.message,
    required this.meetingsListe,
  });

  String message;
  List<MeetingsListe> meetingsListe;

  factory MeetingListAdminModel.fromJson(Map<String, dynamic> json) =>
      MeetingListAdminModel(
        message: json["message"],
        meetingsListe: List<MeetingsListe>.from(
            json["meetings liste"].map((x) => MeetingsListe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "meetings liste":
            List<dynamic>.from(meetingsListe.map((x) => x.toJson())),
      };
}

class MeetingsListe {
  MeetingsListe({
    required this.id,
    required this.userId,
    required this.employerId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  int employerId;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  String location;
  DateTime createdAt;
  DateTime updatedAt;

  factory MeetingsListe.fromJson(Map<String, dynamic> json) => MeetingsListe(
        id: json["id"],
        userId: json["user_id"],
        employerId: json["employer_id"],
        date: DateTime.parse(json["date"]),
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        location: json["location"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employer_id": employerId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "location": location,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
