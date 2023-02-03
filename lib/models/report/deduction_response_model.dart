// To parse this JSON data, do
//
//     final deductionResponseModel = deductionResponseModelFromJson(jsonString);

import 'dart:convert';

DeductionResponseModel deductionResponseModelFromJson(String str) =>
    DeductionResponseModel.fromJson(json.decode(str));

String deductionResponseModelToJson(DeductionResponseModel data) =>
    json.encode(data.toJson());

class DeductionResponseModel {
  DeductionResponseModel({
    this.message,
    this.deductions,
  });

  String? message;
  List<Deduction>? deductions;

  factory DeductionResponseModel.fromJson(Map<String, dynamic> json) =>
      DeductionResponseModel(
        message: json["message"],
        deductions: List<Deduction>.from(
            json["deductions"].map((x) => Deduction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "deductions": List<dynamic>.from(deductions!.map((x) => x.toJson())),
      };
}

class Deduction {
  Deduction({
    this.id,
    this.userId,
    this.salary,
    this.paidSalary,
    this.paySlip,
    this.fundDeduction,
    this.pTax,
    this.totalDeduction,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? salary;
  String? paidSalary;
  String? paySlip;
  String? fundDeduction;
  String? pTax;
  String? totalDeduction;
  int? status;
  String? createdAt;
  String? updatedAt;

  factory Deduction.fromJson(Map<String, dynamic> json) => Deduction(
        id: json["id"],
        userId: json["user_id"],
        salary: json["salary"],
        paidSalary: json["paid_salary"],
        paySlip: json["pay_slip"],
        fundDeduction: json["fund_deduction"],
        pTax: json["p_tax"],
        totalDeduction: json["total_deduction"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "salary": salary,
        "paid_salary": paidSalary,
        "pay_slip": paySlip,
        "fund_deduction": fundDeduction,
        "p_tax": pTax,
        "total_deduction": totalDeduction,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
