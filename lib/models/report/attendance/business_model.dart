// To parse this JSON data, do
//
//     final fetchBusinessModel = fetchBusinessModelFromJson(jsonString);

import 'dart:convert';

FetchBusinessModel fetchBusinessModelFromJson(String str) => FetchBusinessModel.fromJson(json.decode(str));

String fetchBusinessModelToJson(FetchBusinessModel data) => json.encode(data.toJson());

class FetchBusinessModel {
    String message;
    List<Business> businesses;

    FetchBusinessModel({
        required this.message,
        required this.businesses,
    });

    factory FetchBusinessModel.fromJson(Map<String, dynamic> json) => FetchBusinessModel(
        message: json["message"],
        businesses: List<Business>.from(json["businesses"].map((x) => Business.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "businesses": List<dynamic>.from(businesses.map((x) => x.toJson())),
    };
}

class Business {
    int id;
    int employerId;
    String name;
    String description;
    int status;
    DateTime createdAt;
    DateTime updatedAt;

    Business({
        required this.id,
        required this.employerId,
        required this.name,
        required this.description,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Business.fromJson(Map<String, dynamic> json) => Business(
        id: json["id"],
        employerId: json["employer_id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "name": name,
        "description": description,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
