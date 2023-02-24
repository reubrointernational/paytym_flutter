import 'dart:convert';

DeductionAddRequestModel deductionAddRequestModelFromJson(String str) =>
    DeductionAddRequestModel.fromJson(json.decode(str));

String deductionAddRequestModelToJson(DeductionAddRequestModel data) =>
    json.encode(data.toJson());

class DeductionAddRequestModel {
  DeductionAddRequestModel({
    required this.employerId,
    required this.name,
    required this.amount,
    required this.percentage,
    required this.description,
    
  });

  String employerId;
  String name;
  String amount;
  String percentage;
  String description;

  factory DeductionAddRequestModel.fromJson(Map<String, dynamic> json) =>
      DeductionAddRequestModel(
        employerId: json["employer_id"],
        name: json["name"],
        amount: json["amount"],
        percentage: json["percentage"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "employer_id": employerId,
        "name": name,
        "amount": amount,
        "percentage": percentage,
        "description": description,
      };
}
