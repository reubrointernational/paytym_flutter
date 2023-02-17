// To parse this JSON data, do
//
//     final createEventRequestModel = createEventRequestModelFromJson(jsonString);

import 'dart:convert';

CreateEventRequestModel createEventRequestModelFromJson(String str) =>
    CreateEventRequestModel.fromJson(json.decode(str));

String createEventRequestModelToJson(CreateEventRequestModel data) =>
    json.encode(data.toJson());

class CreateEventRequestModel {
  CreateEventRequestModel({
    required this.employerId,
    required this.name,
    required this.description,
    required this.place,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
  });

  String employerId;
  String name;
  String description;
  String place;
  String startDate;
  String startTime;
  String endDate;
  String endTime;

  factory CreateEventRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateEventRequestModel(
        employerId: json["employer_id"],
        name: json["name"],
        description: json["description"],
        place: json["place"],
        startDate: json["start_date"],
        startTime: json["start_time"],
        endDate: json["end_date"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "employer_id": employerId,
        "name": name,
        "description": description,
        "place": place,
        "start_date": startDate,
        "start_time": startTime,
        "end_date": endDate,
        "end_time": endTime,
      };
}
