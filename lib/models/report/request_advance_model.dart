// To parse this JSON data, do
//
//     final requestAdvanceModel = requestAdvanceModelFromJson(jsonString);

import 'dart:convert';

RequestAdvanceModel requestAdvanceModelFromJson(String str) =>
    RequestAdvanceModel.fromJson(json.decode(str));

String requestAdvanceModelToJson(RequestAdvanceModel data) =>
    json.encode(data.toJson());

class RequestAdvanceModel {
  RequestAdvanceModel({
    this.amount,
    this.description,
  });

  String? amount;
  String? description;

  factory RequestAdvanceModel.fromJson(Map<String, dynamic> json) =>
      RequestAdvanceModel(
        amount: json["amount"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "description": description,
      };
}
