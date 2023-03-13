// To parse this JSON data, do
//
//     final deductionListAdminModel = deductionListAdminModelFromJson(jsonString);

import 'dart:convert';

DeductionListAdminModel deductionListAdminModelFromJson(String str) =>
    DeductionListAdminModel.fromJson(json.decode(str));

String deductionListAdminModelToJson(DeductionListAdminModel data) =>
    json.encode(data.toJson());

class DeductionListAdminModel {
  DeductionListAdminModel({
    this.message,
    this.details,
  });

  String? message;
  List<Detail>? details;

  factory DeductionListAdminModel.fromJson(Map<String, dynamic> json) =>
      DeductionListAdminModel(
        message: json["message"],
        details: json["Details"] == null
            ? []
            : List<Detail>.from(
                json["Details"]!.map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "Details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.id,
    this.employerId,
    this.name,
    this.amount,
    this.percentage,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? employerId;
  String? name;
  String? amount;
  String? percentage;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        employerId: json["employer_id"],
        name: json["name"],
        amount: json["amount"],
        percentage: json["percentage"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "name": name,
        "amount": amount,
        "percentage": percentage,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
