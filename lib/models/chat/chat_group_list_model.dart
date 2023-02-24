// To parse this JSON data, do
//
//     final chatListGroupModel = chatListGroupModelFromJson(jsonString);

import 'dart:convert';

ChatListGroupModel chatListGroupModelFromJson(String str) =>
    ChatListGroupModel.fromJson(json.decode(str));

String chatListGroupModelToJson(ChatListGroupModel data) =>
    json.encode(data.toJson());

class ChatListGroupModel {
  ChatListGroupModel({
    required this.message,
    required this.chats,
  });

  String message;
  List<Chat> chats;

  factory ChatListGroupModel.fromJson(Map<String, dynamic> json) =>
      ChatListGroupModel(
        message: json["message"],
        chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
      };
}

class Chat {
  Chat({
    required this.id,
    required this.employerId,
    required this.adminId,
    required this.profilePic,
    required this.groupName,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int employerId;
  int adminId;
  String profilePic;
  String groupName;
  DateTime createdAt;
  DateTime updatedAt;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        employerId: json["employer_id"],
        adminId: json["admin_id"],
        profilePic: json["profile_pic"],
        groupName: json["group_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "admin_id": adminId,
        "profile_pic": profilePic,
        "group_name": groupName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
