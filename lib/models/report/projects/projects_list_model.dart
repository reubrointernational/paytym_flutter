// To parse this JSON data, do
//
//     final projectListModel = projectListModelFromJson(jsonString);

import 'dart:convert';

ProjectListModel projectListModelFromJson(String str) =>
    ProjectListModel.fromJson(json.decode(str));

String projectListModelToJson(ProjectListModel data) =>
    json.encode(data.toJson());

class ProjectListModel {
  ProjectListModel({
    this.message,
    this.projectsLists,
  });

  String? message;
  List<ProjectsList>? projectsLists;

  factory ProjectListModel.fromJson(Map<String, dynamic> json) =>
      ProjectListModel(
        message: json["message"],
        projectsLists: json["projects lists"] == null
            ? []
            : List<ProjectsList>.from(
                json["projects lists"]!.map((x) => ProjectsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "projects lists": projectsLists == null
            ? []
            : List<dynamic>.from(projectsLists!.map((x) => x.toJson())),
      };
}

class ProjectsList {
  ProjectsList({
    this.id,
    this.employerId,
    this.branchId,
    this.departmentId,
    this.startDate,
    this.endDate,
    this.name,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? employerId;
  int? branchId;
  int? departmentId;
  dynamic startDate;
  dynamic endDate;
  String? name;
  String? description;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ProjectsList.fromJson(Map<String, dynamic> json) => ProjectsList(
        id: json["id"],
        employerId: json["employer_id"],
        branchId: json["branch_id"],
        departmentId: json["department_id"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        name: json["name"],
        description: json["description"],
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
        "employer_id": employerId,
        "branch_id": branchId,
        "department_id": departmentId,
        "start_date": startDate,
        "end_date": endDate,
        "name": name,
        "description": description,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
