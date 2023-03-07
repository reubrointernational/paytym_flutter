import 'dart:convert';

ChatCreateRequestModel chatCreateRequestModelFromJson(String str) => ChatCreateRequestModel.fromJson(json.decode(str));

String chatCreateRequestModelToJson(ChatCreateRequestModel data) => json.encode(data.toJson());

class ChatCreateRequestModel {
    ChatCreateRequestModel({
        required this.employerId,
        required this.groupName,
        required this.members,
    });

    String employerId;
    String groupName;
    String members;

    factory ChatCreateRequestModel.fromJson(Map<String, dynamic> json) => ChatCreateRequestModel(
        employerId: json["employer_id"],
        groupName: json["group_name"],
        members: json["members"],
    );

    Map<String, String> toJson() => {
        "employer_id": employerId,
        "group_name": groupName,
        "members": members,
    };
}