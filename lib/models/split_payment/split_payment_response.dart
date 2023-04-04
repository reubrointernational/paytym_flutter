// To parse this JSON data, do
//
//     final splitPaymentResponseModel = splitPaymentResponseModelFromJson(jsonString);

import 'dart:convert';

SplitPaymentResponseModel splitPaymentResponseModelFromJson(String str) =>
    SplitPaymentResponseModel.fromJson(json.decode(str));

String splitPaymentResponseModelToJson(SplitPaymentResponseModel data) =>
    json.encode(data.toJson());

class SplitPaymentResponseModel {
  SplitPaymentResponseModel({
    this.message,
    this.mycash,
    this.mpaisa,
    this.bank,
  });

  String? message;
  Bank? mycash;
  Bank? mpaisa;
  Bank? bank;

  factory SplitPaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      SplitPaymentResponseModel(
        message: json["message"],
        mycash: json["mycash"] == null ? null : Bank.fromJson(json["mycash"]),
        mpaisa: json["mpaisa"] == null ? null : Bank.fromJson(json["mpaisa"]),
        bank: json["bank"] == null ? null : Bank.fromJson(json["bank"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "mycash": mycash?.toJson(),
        "mpaisa": mpaisa?.toJson(),
        "bank": bank?.toJson(),
      };
}

class Bank {
  Bank({
    this.id,
    this.employeeId,
    this.employerId,
    this.paymentWallet,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? employeeId;
  int? employerId;
  String? paymentWallet;
  String? amount;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        employeeId: json["employee_id"],
        employerId: json["employer_id"],
        paymentWallet: json["payment_wallet"],
        amount: json["amount"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "employer_id": employerId,
        "payment_wallet": paymentWallet,
        "amount": amount,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
