// To parse this JSON data, do
//
//     final eventsResponseModel = eventsResponseModelFromJson(jsonString);

import 'dart:convert';

EventsResponseModel eventsResponseModelFromJson(String str) =>
    EventsResponseModel.fromJson(json.decode(str));

String eventsResponseModelToJson(EventsResponseModel data) =>
    json.encode(data.toJson());

class EventsResponseModel {
  EventsResponseModel({
    this.message,
    this.events,
  });

  String? message;
  List<Event>? events;

  factory EventsResponseModel.fromJson(Map<String, dynamic> json) =>
      EventsResponseModel(
        message: json["message"],
        events: json["events"] == null
            ? []
            : List<Event>.from(json["events"]!.map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "events": events == null
            ? []
            : List<dynamic>.from(events!.map((x) => x.toJson())),
      };
}

class Event {
  Event({
    this.id,
    this.employerId,
    this.name,
    this.description,
    this.place,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? employerId;
  String? name;
  String? description;
  String? place;
  DateTime? startDate;
  String? startTime;
  DateTime? endDate;
  String? endTime;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        employerId: json["employer_id"],
        name: json["name"],
        description: json["description"],
        place: json["place"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        startTime: json["start_time"],
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        endTime: json["end_time"],
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
        "name": name,
        "description": description,
        "place": place,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "end_time": endTime,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
