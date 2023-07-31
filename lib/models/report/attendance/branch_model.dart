// To parse this JSON data, do
//
//     final branchesModel = branchesModelFromJson(jsonString);

import 'dart:convert';

BranchesModel branchesModelFromJson(String str) =>
    BranchesModel.fromJson(json.decode(str));

String branchesModelToJson(BranchesModel data) => json.encode(data.toJson());

class BranchesModel {
  String message;
  List<Branch> branches;

  BranchesModel({
    required this.message,
    required this.branches,
  });

  factory BranchesModel.fromJson(Map<String, dynamic> json) => BranchesModel(
        message: json["message"],
        branches:
            List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
      };
}

class Branch {
  int id;
  int employerId;
  int employerBusinessId;
  String name;
  dynamic city;
  String town;
  String postcode;
  String country;
  String bank;
  String accountNumber;
  dynamic qrCode;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  Branch({
    required this.id,
    required this.employerId,
    required this.employerBusinessId,
    required this.name,
    this.city,
    required this.town,
    required this.postcode,
    required this.country,
    required this.bank,
    required this.accountNumber,
    this.qrCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        employerId: json["employer_id"],
        employerBusinessId: json["employer_business_id"],
        name: json["name"],
        city: json["city"],
        town: json["town"],
        postcode: json["postcode"],
        country: json["country"],
        bank: json["bank"],
        accountNumber: json["account_number"],
        qrCode: json["qr_code"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "employer_business_id": employerBusinessId,
        "name": name,
        "city": city,
        "town": town,
        "postcode": postcode,
        "country": country,
        "bank": bank,
        "account_number": accountNumber,
        "qr_code": qrCode,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
