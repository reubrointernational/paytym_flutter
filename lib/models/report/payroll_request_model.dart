import 'dart:convert';

class ProcessPayrollRequestModel {
  String? employerId;
  String? flag;
  List<int>? id;

  ProcessPayrollRequestModel(
      {required this.employerId, required this.flag, this.id});

  factory ProcessPayrollRequestModel.fromJson(Map<String, dynamic> json) =>
      ProcessPayrollRequestModel(
        employerId: json["employer_id"],
        flag: json["flag"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "employer_id": employerId,
        "flag": flag,
        "id": id,
      };
}
