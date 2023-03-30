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
    required this.message,
    required this.employerId,
    required this.groupChatId,
  });

  String message;
  String employerId;
  String groupChatId;

  factory ChatRequestModel.fromJson(Map<String, dynamic> json) =>
      ChatRequestModel(
        message: json["message"],
        employerId: json["employer_id"],
        groupChatId: json["group_chat_id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "employer_id": employerId,
        "group_chat_id": groupChatId,
      };
}
