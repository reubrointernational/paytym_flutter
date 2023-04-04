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
    this.message,
    this.chats,
  });

  String? message;
  List<ChatListGroupModelChat>? chats;

  factory ChatListGroupModel.fromJson(Map<String, dynamic> json) =>
      ChatListGroupModel(
        message: json["message"],
        chats: json["chats"] == null
            ? []
            : List<ChatListGroupModelChat>.from(
                json["chats"]!.map((x) => ChatListGroupModelChat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "chats": chats == null
            ? []
            : List<dynamic>.from(chats!.map((x) => x.toJson())),
      };
}

class ChatListGroupModelChat {
  ChatListGroupModelChat({
    this.id,
    this.groupChatId,
    this.memberId,
    this.createdAt,
    this.updatedAt,
    this.group,
  });

  int? id;
  int? groupChatId;
  int? memberId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Group? group;

  factory ChatListGroupModelChat.fromJson(Map<String, dynamic> json) =>
      ChatListGroupModelChat(
        id: json["id"],
        groupChatId: json["group_chat_id"],
        memberId: json["member_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        group: json["group"] == null ? null : Group.fromJson(json["group"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_chat_id": groupChatId,
        "member_id": memberId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "group": group?.toJson(),
      };
}

class Group {
  Group({
    this.id,
    this.employerId,
    this.adminId,
    this.profilePic,
    this.groupName,
    this.createdAt,
    this.updatedAt,
    this.chats,
  });

  int? id;
  int? employerId;
  int? adminId;
  String? profilePic;
  String? groupName;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<GroupChat>? chats;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        employerId: json["employer_id"],
        adminId: json["admin_id"],
        profilePic: json["profile_pic"],
        groupName: json["group_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        chats: json["chats"] == null
            ? []
            : List<GroupChat>.from(
                json["chats"]!.map((x) => GroupChat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "admin_id": adminId,
        "profile_pic": profilePic,
        "group_name": groupName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "chats": chats == null
            ? []
            : List<dynamic>.from(chats!.map((x) => x.toJson())),
      };
}

class GroupChat {
  GroupChat({
    this.id,
    this.userId,
    this.employerId,
    this.groupChatId,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? employerId;
  int? groupChatId;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GroupChat.fromJson(Map<String, dynamic> json) => GroupChat(
        id: json["id"],
        userId: json["user_id"],
        employerId: json["employer_id"],
        groupChatId: json["group_chat_id"],
        message: json["message"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employer_id": employerId,
        "group_chat_id": groupChatId,
        "message": message,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
