// To parse this JSON data, do
//
//     final leaveTypesModel = leaveTypesModelFromJson(jsonString);

import 'dart:convert';

LeaveTypesModel leaveTypesModelFromJson(String str) =>
    LeaveTypesModel.fromJson(json.decode(str));

String leaveTypesModelToJson(LeaveTypesModel data) =>
    json.encode(data.toJson());

class LeaveTypesModel {
  LeaveTypesModel({
    this.leaveTypes,
  });

  List<LeaveType>? leaveTypes;
  String? message;

  factory LeaveTypesModel.fromJson(Map<String, dynamic> json) =>
      LeaveTypesModel(
        leaveTypes: json["leave-types"] == null
            ? []
            : List<LeaveType>.from(
                json["leave-types"]!.map((x) => LeaveType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "leave-types": leaveTypes == null
            ? []
            : List<dynamic>.from(leaveTypes!.map((x) => x.toJson())),
      };
}

class LeaveType {
  LeaveType({
    this.id,
    this.leaveType,
    this.noOfDaysAllowed,
    this.employerId,
  });

  int? id;
  String? leaveType;
  int? noOfDaysAllowed;
  int? employerId;

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
        id: json["id"],
        leaveType: json["leave_type"],
        noOfDaysAllowed: json["no_of_days_allowed"],
        employerId: json["employer_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "leave_type": leaveType,
        "no_of_days_allowed": noOfDaysAllowed,
        "employer_id": employerId,
      };
}
