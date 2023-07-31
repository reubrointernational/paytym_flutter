// To parse this JSON data, do
//
//     final departmentModel = departmentModelFromJson(jsonString);

import 'dart:convert';

DepartmentModel departmentModelFromJson(String str) =>
    DepartmentModel.fromJson(json.decode(str));

String departmentModelToJson(DepartmentModel data) =>
    json.encode(data.toJson());

class DepartmentModel {
  String message;
  List<Department> departments;

  DepartmentModel({
    required this.message,
    required this.departments,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      DepartmentModel(
        message: json["message"],
        departments: List<Department>.from(
            json["departments"].map((x) => Department.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "departments": List<dynamic>.from(departments.map((x) => x.toJson())),
      };
}

class Department {
  int id;
  int employerId;
  int branchId;
  String depName;
  int status;
  dynamic createdAt;
  dynamic updatedAt;

  Department({
    required this.id,
    required this.employerId,
    required this.branchId,
    required this.depName,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        employerId: json["employer_id"],
        branchId: json["branch_id"],
        depName: json["dep_name"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "branch_id": branchId,
        "dep_name": depName,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
