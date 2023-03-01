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
    required this.message,
    required this.projectsListe,
  });

  String message;
  List<ProjectsListe> projectsListe;

  factory ProjectListModel.fromJson(Map<String, dynamic> json) =>
      ProjectListModel(
        message: json["message"],
        projectsListe: List<ProjectsListe>.from(
            json["projects liste"].map((x) => ProjectsListe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "projects liste":
            List<dynamic>.from(projectsListe.map((x) => x.toJson())),
      };
}

class ProjectsListe {
  ProjectsListe({
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
  String? startDate;
  String? endDate;
  String? name;
  String? description;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ProjectsListe.fromJson(Map<String, dynamic> json) => ProjectsListe(
        id: json["id"],
        employerId: json["employer_id"],
        branchId: json["branch_id"],
        departmentId: json["department_id"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
