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
  Details? details;

  factory DeductionListAdminModel.fromJson(Map<String, dynamic> json) =>
      DeductionListAdminModel(
        message: json["message"],
        details: Details.fromJson(json["Details"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "Details": details!.toJson(),
      };
}

class Details {
  Details({
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
  String? createdAt;
  String? updatedAt;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        employerId: json["employer_id"],
        name: json["name"],
        amount: json["amount"],
        percentage: json["percentage"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "name": name,
        "amount": amount,
        "percentage": percentage,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
