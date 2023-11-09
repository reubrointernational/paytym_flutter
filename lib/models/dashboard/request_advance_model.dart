// To parse this JSON data, do
//
//     final requestAdvanceModel = requestAdvanceModelFromJson(jsonString);

import 'dart:convert';

RequestAdvanceModel requestAdvanceModelFromJson(String str) =>
    RequestAdvanceModel.fromJson(json.decode(str));

String requestAdvanceModelToJson(RequestAdvanceModel data) =>
    json.encode(data.toJson());

class RequestAdvanceModel {
  RequestAdvanceModel(
      {this.amount, this.description, this.dateofrequirement, this.status});

  String? amount;
  String? description;
  String? status;
  String? dateofrequirement;

  factory RequestAdvanceModel.fromJson(Map<String, dynamic> json) =>
      RequestAdvanceModel(
        amount: json["amount"],
        status: json["status"],
        description: json["description"],
        dateofrequirement: json["date_of_requirement"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "amount": amount,
        "description": description,
        "date_of_requirement": dateofrequirement,
      };
}
