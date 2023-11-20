// To parse this JSON data, do
//
//     final payslipResponseModel = payslipResponseModelFromJson(jsonString);

import 'dart:convert';

PayslipResponseAllModel payslipResponseAllModelFromJson(String str) =>
    PayslipResponseAllModel.fromJson(json.decode(str));

String payslipResponseAllModelToJson(PayslipResponseAllModel data) =>
    json.encode(data.toJson());

class PayslipResponseAllModel {
  PayslipResponseAllModel({
    this.message,
    this.payroll,
  });

  String? message;
  List<PayrollAll>? payroll;

  factory PayslipResponseAllModel.fromJson(Map<String, dynamic> json) =>
      PayslipResponseAllModel(
        message: json["message"],
        payroll: json["payroll"] == null
            ? []
            : List<PayrollAll>.from(
                json["payroll"]!.map((x) => PayrollAll.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "payroll": payroll == null
            ? []
            : List<dynamic>.from(payroll!.map((x) => x.toJson())),
      };
}

class PayrollAll {
  PayrollAll({
    this.id,
    this.userId,
    this.employerId,
    this.startDate,
    this.endDate,
    this.baseSalary,
    this.netSalary,
    this.grossSalary,
    this.paidSalary,
    this.paySlip,
    this.totalTax,
    this.totalDeduction,
    this.totalAllowance,
    this.totalBonus,
    this.totalCommission,
    this.totalFnpf,
    this.status,
    this.payrollStatus,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? employerId;
  DateTime? startDate;
  DateTime? endDate;
  String? baseSalary;
  String? netSalary;
  String? grossSalary;
  String? paidSalary;
  String? paySlip;
  String? totalTax;
  String? totalDeduction;
  String? totalAllowance;
  String? totalBonus;
  String? totalCommission;
  String? totalFnpf;
  int? status;
  String? payrollStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PayrollAll.fromJson(Map<String, dynamic> json) => PayrollAll(
        id: json["id"],
        userId: json["user_id"],
        employerId: json["employer_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        baseSalary: json["base_salary"],
        netSalary: json["net_salary"],
        grossSalary: json["gross_salary"],
        paidSalary: json["paid_salary"],
        paySlip: json["pay_slip"],
        totalTax: json["total_tax"],
        totalDeduction: json["total_deduction"],
        totalAllowance: json["total_allowance"],
        totalBonus: json["total_bonus"],
        totalCommission: json["total_commission"],
        totalFnpf: json["total_fnpf"],
        status: json["status"],
        payrollStatus: json["payroll_status"],
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
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "base_salary": baseSalary,
        "net_salary": netSalary,
        "gross_salary": grossSalary,
        "paid_salary": paidSalary,
        "pay_slip": paySlip,
        "total_tax": totalTax,
        "total_deduction": totalDeduction,
        "total_allowance": totalAllowance,
        "total_bonus": totalBonus,
        "total_commission": totalCommission,
        "total_fnpf": totalFnpf,
        "status": status,
        "payroll_status": payrollStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
