// To parse this JSON data, do
//
//     final messageOnlyResponseModel = messageOnlyResponseModelFromJson(jsonString);

import 'dart:convert';

MessageOnlyResponseModel messageOnlyResponseModelFromJson(String str) =>
    MessageOnlyResponseModel.fromJson(json.decode(str));

String messageOnlyResponseModelToJson(MessageOnlyResponseModel data) =>
    json.encode(data.toJson());

class MessageOnlyResponseModel {
  MessageOnlyResponseModel({
    this.message,
  });

  String? message;

  factory MessageOnlyResponseModel.fromJson(Map<String, dynamic> json) =>
      MessageOnlyResponseModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
