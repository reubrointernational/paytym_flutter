import 'dart:convert';

DeductionDeleteRequestModel deductionDeleteRequestModelFromJson(String str) =>
    DeductionDeleteRequestModel.fromJson(json.decode(str));

String deductionDeleteRequestModelToJson(DeductionDeleteRequestModel data) =>
    json.encode(data.toJson());

class DeductionDeleteRequestModel {
  DeductionDeleteRequestModel({
    required this.id,
  });

  String id;

  factory DeductionDeleteRequestModel.fromJson(Map<String, dynamic> json) =>
      DeductionDeleteRequestModel(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
