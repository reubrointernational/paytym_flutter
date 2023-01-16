// To parse this JSON data, do
//
//     final eventsResponseModel = eventsResponseModelFromJson(jsonString);

import 'dart:convert';

EventsResponseModel? eventsResponseModelFromJson(String str) =>
    EventsResponseModel.fromJson(json.decode(str));

String eventsResponseModelToJson(EventsResponseModel? data) =>
    json.encode(data!.toJson());

class EventsResponseModel {
  EventsResponseModel({
    this.message,
    this.events,
  });

  String? message;
  List<Event?>? events;

  factory EventsResponseModel.fromJson(Map<String, dynamic> json) =>
      EventsResponseModel(
        message: json["message"],
        events: json["events"] == null
            ? []
            : List<Event?>.from(json["events"]!.map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "events": events == null
            ? []
            : List<dynamic>.from(events!.map((x) => x!.toJson())),
      };
}

class Event {
  Event({
    this.id,
    this.name,
    this.description,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? description;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  int? status;
  dynamic createdAt;
  dynamic updatedAt;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        startDate: json["start_date"],
        startTime: json["start_time"],
        endDate: json["end_date"],
        endTime: json["end_time"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "start_date":
            startDate,
        "start_time": startTime,
        "end_date":
            endDate,
        "end_time": endTime,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
