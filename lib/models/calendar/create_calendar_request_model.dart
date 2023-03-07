// To parse this JSON data, do
//
//     final createEventRequestModel = createEventRequestModelFromJson(jsonString);

import 'dart:convert';

CreateCalendarRequestModel createEventRequestModelFromJson(String str) =>
    CreateCalendarRequestModel.fromJson(json.decode(str));

String createEventRequestModelToJson(CreateCalendarRequestModel data) =>
    json.encode(data.toJson());

class CreateCalendarRequestModel {
  CreateCalendarRequestModel(
      {required this.employerId,
      required this.name,
      required this.description,
      required this.place,
      required this.startDate,
      required this.startTime,
      required this.endDate,
      required this.endTime,
      this.type = '1',
      this.countryId = '1',
      this.location,
      this.attendees});

  String employerId;
  String name;
  String description;
  String place;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  String type;
  String countryId;
  String? location;
  List<int>? attendees;

  factory CreateCalendarRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateCalendarRequestModel(
        employerId: json["employer_id"],
        name: json["name"],
        description: json["description"],
        place: json["place"],
        startDate: json["start_date"],
        startTime: json["start_time"],
        endDate: json["end_date"],
        endTime: json["end_time"],
        location: json["location"],
        attendees: json["attendees"],
      );

  Map<String, dynamic> toJson() => {
        "employer_id": employerId,
        "name": name,
        "description": description,
        "place": place,
        "start_date": startDate,
        "date": startDate,
        "start_time": startTime,
        "end_date": endDate,
        "end_time": endTime,
        "type": type,
        "country_id": countryId,
        "location": place,
        "attendees": attendees,
      };
}
