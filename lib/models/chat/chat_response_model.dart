// To parse this JSON data, do
//
//     final chatResponseModel = chatResponseModelFromJson(jsonString);

import 'dart:convert';

ChatResponseModel chatResponseModelFromJson(String str) =>
    ChatResponseModel.fromJson(json.decode(str));

String chatResponseModelToJson(ChatResponseModel data) =>
    json.encode(data.toJson());

class ChatResponseModel {
  ChatResponseModel({
    this.message,
    this.chats,
  });

  String? message;
  List<Chat>? chats;

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) =>
      ChatResponseModel(
        message: json["message"],
        chats: json["chats"] == null
            ? []
            : List<Chat>.from(json["chats"]!.map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "chats": chats == null
            ? []
            : List<dynamic>.from(chats!.map((x) => x.toJson())),
      };
}

class Chat {
  Chat({
    this.id,
    this.userId,
    this.employerId,
    this.groupChatId,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.employee,
  });

  int? id;
  int? userId;
  int? employerId;
  int? groupChatId;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;
  Employee? employee;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
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
        employee: json["employee"] == null
            ? null
            : Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employer_id": employerId,
        "group_chat_id": groupChatId,
        "message": message,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "employee": employee?.toJson(),
      };
}

class Employee {
  Employee({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? image;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
      };
}
