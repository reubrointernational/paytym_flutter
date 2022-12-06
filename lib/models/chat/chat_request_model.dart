// To parse this JSON data, do
//
//     final chatRequestModel = chatRequestModelFromJson(jsonString);

import 'dart:convert';

ChatRequestModel chatRequestModelFromJson(String str) =>
    ChatRequestModel.fromJson(json.decode(str));

String chatRequestModelToJson(ChatRequestModel data) =>
    json.encode(data.toJson());

class ChatRequestModel {
  ChatRequestModel({
    this.message,
    this.employerId,
  });

  String? message;
  int? employerId;

  factory ChatRequestModel.fromJson(Map<String, dynamic> json) =>
      ChatRequestModel(
        message: json["message"],
        employerId: json["employer_id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "employer_id": employerId,
      };
}
