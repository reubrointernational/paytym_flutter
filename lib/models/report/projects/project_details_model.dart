// To parse this JSON data, do
//
//     final projectDetailsModel = projectDetailsModelFromJson(jsonString);

import 'dart:convert';

ProjectDetailsModel projectDetailsModelFromJson(String str) =>
    ProjectDetailsModel.fromJson(json.decode(str));

String projectDetailsModelToJson(ProjectDetailsModel data) =>
    json.encode(data.toJson());

class ProjectDetailsModel {
  ProjectDetailsModel({
    required this.message,
    required this.projectsListe,
  });

  String message;
  ProjectsListe projectsListe;

  factory ProjectDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProjectDetailsModel(
        message: json["message"],
        projectsListe: ProjectsListe.fromJson(json["projects liste"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "projects liste": projectsListe.toJson(),
      };
}

class ProjectsListe {
  ProjectsListe({
    this.id,
    this.employerId,
    this.employeeId,
    this.projectId,
    this.user,
  });

  int? id;
  int? employerId;
  int? employeeId;
  int? projectId;
  dynamic user;

  factory ProjectsListe.fromJson(Map<String, dynamic> json) => ProjectsListe(
        id: json["id"],
        employerId: json["employer_id"],
        employeeId: json["employee_id"],
        projectId: json["project_id"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "employee_id": employeeId,
        "project_id": projectId,
        "user": user,
      };
}
