// To parse this JSON data, do
//
//     final branchDeptListModel = branchDeptListModelFromJson(jsonString);

import 'dart:convert';

BranchDeptListModel branchDeptListModelFromJson(String str) =>
    BranchDeptListModel.fromJson(json.decode(str));

String branchDeptListModelToJson(BranchDeptListModel data) =>
    json.encode(data.toJson());

class BranchDeptListModel {
  BranchDeptListModel({
    required this.message,
    required this.branches,
    required this.departments,
  });

  String message;
  List<Branch> branches;
  List<Department> departments;

  factory BranchDeptListModel.fromJson(Map<String, dynamic> json) =>
      BranchDeptListModel(
        message: json["message"],
        branches:
            List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
        departments: List<Department>.from(
            json["departments"].map((x) => Department.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
        "departments": List<dynamic>.from(departments.map((x) => x.toJson())),
      };
}

class Branch {
  Branch({
    this.id,
    this.employerId,
    this.employerBusinessId,
    this.name,
    this.city,
    this.town,
    this.postcode,
    this.country,
    this.bank,
    this.accountNumber,
    this.qrCode,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? employerId;
  int? employerBusinessId;
  String? name;
  String? city;
  String? town;
  String? postcode;
  String? country;
  String? bank;
  String? accountNumber;
  String? qrCode;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Department {
  Department({
    this.id,
    this.employerId,
    this.branchId,
    this.depName,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? employerId;
  int? branchId;
  String? depName;
  int? status;
  String? createdAt;
  String? updatedAt;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        employerId: json["employer_id"],
        branchId: json["branch_id"],
        depName: json["dep_name"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "branch_id": branchId,
        "dep_name": depName,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
