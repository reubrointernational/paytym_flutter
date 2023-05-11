// To parse this JSON data, do
//
//     final splitPaymentResponseModel = splitPaymentResponseModelFromJson(jsonString);

import 'dart:convert';

SplitPaymentResponseModel splitPaymentResponseModelFromJson(String str) =>
    SplitPaymentResponseModel.fromJson(json.decode(str));

String splitPaymentResponseModelToJson(SplitPaymentResponseModel data) =>
    json.encode(data.toJson());

class SplitPaymentResponseModel {
  String? message;
  List<SplitPaymentList>? splitPaymentList;

  SplitPaymentResponseModel({
    this.message,
    this.splitPaymentList,
  });

  factory SplitPaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      SplitPaymentResponseModel(
        message: json["message"],
        splitPaymentList: json["split_payment_list"] == null
            ? []
            : List<SplitPaymentList>.from(json["split_payment_list"]!
                .map((x) => SplitPaymentList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "split_payment_list": splitPaymentList == null
            ? []
            : List<dynamic>.from(splitPaymentList!.map((x) => x.toJson())),
      };
}

class SplitPaymentList {
  int? id;
  int? employeeId;
  int? employerId;
  int? bank;
  int? mycash;
  int? mpaisa;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;

  SplitPaymentList({
    this.id,
    this.employeeId,
    this.employerId,
    this.bank,
    this.mycash,
    this.mpaisa,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory SplitPaymentList.fromJson(Map<String, dynamic> json) =>
      SplitPaymentList(
        id: json["id"],
        employeeId: json["employee_id"],
        employerId: json["employer_id"],
        bank: json["bank"],
        mycash: json["mycash"],
        mpaisa: json["mpaisa"],
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
        "bank": bank,
        "mycash": mycash,
        "mpaisa": mpaisa,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
