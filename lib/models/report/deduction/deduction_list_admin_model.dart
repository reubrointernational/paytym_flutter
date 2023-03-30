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
    this.deductions,
    this.deductionsTypes,
    this.paymentAdvance,
  });

  String? message;
  List<PurpleDeduction>? deductions;
  List<DeductionsTypeElement>? deductionsTypes;
  List<PaymentAdvance>? paymentAdvance;

  factory DeductionListAdminModel.fromJson(Map<String, dynamic> json) =>
      DeductionListAdminModel(
        message: json["message"],
        deductions: json["deductions"] == null
            ? []
            : List<PurpleDeduction>.from(
                json["deductions"]!.map((x) => PurpleDeduction.fromJson(x))),
        deductionsTypes: json["deductions types"] == null
            ? []
            : List<DeductionsTypeElement>.from(json["deductions types"]!
                .map((x) => DeductionsTypeElement.fromJson(x))),
        paymentAdvance: json["payment advance"] == null
            ? []
            : List<PaymentAdvance>.from(json["payment advance"]!
                .map((x) => PaymentAdvance.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "deductions": deductions == null
            ? []
            : List<dynamic>.from(deductions!.map((x) => x.toJson())),
        "deductions types": deductionsTypes == null
            ? []
            : List<dynamic>.from(deductionsTypes!.map((x) => x.toJson())),
        "payment advance": paymentAdvance == null
            ? []
            : List<dynamic>.from(paymentAdvance!.map((x) => x.toJson())),
      };
}

class PurpleDeduction {
  PurpleDeduction({
    this.id,
    this.firstName,
    this.lastName,
    this.branchId,
    this.departmentId,
    this.assignDeduction,
  });

  int? id;
  String? firstName;
  String? lastName;
  int? branchId;
  int? departmentId;
  List<AssignDeduction>? assignDeduction;

  factory PurpleDeduction.fromJson(Map<String, dynamic> json) =>
      PurpleDeduction(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        branchId: json["branch_id"],
        departmentId: json["department_id"],
        assignDeduction: json["assign_deduction"] == null
            ? []
            : List<AssignDeduction>.from(json["assign_deduction"]!
                .map((x) => AssignDeduction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "branch_id": branchId,
        "department_id": departmentId,
        "assign_deduction": assignDeduction == null
            ? []
            : List<dynamic>.from(assignDeduction!.map((x) => x.toJson())),
      };
}

class AssignDeduction {
  AssignDeduction({
    this.id,
    this.employerId,
    this.userId,
    this.deductionId,
    this.rate,
    this.createdAt,
    this.updatedAt,
    this.deduction,
  });

  int? id;
  int? employerId;
  int? userId;
  int? deductionId;
  int? rate;
  DateTime? createdAt;
  DateTime? updatedAt;
  DeductionsTypeElement? deduction;

  factory AssignDeduction.fromJson(Map<String, dynamic> json) =>
      AssignDeduction(
        id: json["id"],
        employerId: json["employer_id"],
        userId: json["user_id"],
        deductionId: json["deduction_id"],
        rate: json["rate"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deduction: json["deduction"] == null
            ? null
            : DeductionsTypeElement.fromJson(json["deduction"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "user_id": userId,
        "deduction_id": deductionId,
        "rate": rate,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deduction": deduction?.toJson(),
      };
}

class DeductionsTypeElement {
  DeductionsTypeElement({
    this.id,
    this.name,
    this.description,
    this.employerId,
  });

  int? id;
  String? name;
  String? description;
  int? employerId;

  factory DeductionsTypeElement.fromJson(Map<String, dynamic> json) =>
      DeductionsTypeElement(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        employerId: json["employer_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "employer_id": employerId,
      };
}

class PaymentAdvance {
  PaymentAdvance({
    this.id,
    this.userId,
    this.employerId,
    this.advanceAmount,
    this.paidAmount,
    this.remainingAmount,
    this.requestedDate,
    this.dateApproved,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? employerId;
  String? advanceAmount;
  dynamic paidAmount;
  dynamic remainingAmount;
  DateTime? requestedDate;
  dynamic dateApproved;
  String? status;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PaymentAdvance.fromJson(Map<String, dynamic> json) => PaymentAdvance(
        id: json["id"],
        userId: json["user_id"],
        employerId: json["employer_id"],
        advanceAmount: json["advance_amount"],
        paidAmount: json["paid_amount"],
        remainingAmount: json["remaining_amount"],
        requestedDate: json["requested_date"] == null
            ? null
            : DateTime.parse(json["requested_date"]),
        dateApproved: json["date_approved"],
        status: json["status"],
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
        "user_id": userId,
        "employer_id": employerId,
        "advance_amount": advanceAmount,
        "paid_amount": paidAmount,
        "remaining_amount": remainingAmount,
        "requested_date":
            "${requestedDate!.year.toString().padLeft(4, '0')}-${requestedDate!.month.toString().padLeft(2, '0')}-${requestedDate!.day.toString().padLeft(2, '0')}",
        "date_approved": dateApproved,
        "status": status,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
