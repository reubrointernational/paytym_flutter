// To parse this JSON data, do
//
//     final payslipResponseModel = payslipResponseModelFromJson(jsonString);

import 'dart:convert';

PayslipResponseModel payslipResponseModelFromJson(String str) =>
    PayslipResponseModel.fromJson(json.decode(str));

String payslipResponseModelToJson(PayslipResponseModel data) =>
    json.encode(data.toJson());

class PayslipResponseModel {
  PayslipResponseModel({
    this.message,
    this.payroll,
  });

  String? message;
  Payroll? payroll;

  factory PayslipResponseModel.fromJson(Map<String, dynamic> json) =>
      PayslipResponseModel(
        message: json["message"],
        payroll: Payroll.fromJson(json["payroll"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "payroll": payroll?.toJson(),
      };
}

class Payroll {
  Payroll({
    this.id,
    this.userId,
    this.salary,
    this.paidSalary,
    this.paySlip,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? salary;
  String? paidSalary;
  String? paySlip;
  int? status;
  String? createdAt;
  String? updatedAt;

  factory Payroll.fromJson(Map<String, dynamic> json) => Payroll(
        id: json["id"],
        userId: json["user_id"],
        salary: json["salary"],
        paidSalary: json["paid_salary"],
        paySlip: json["pay_slip"],
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
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
