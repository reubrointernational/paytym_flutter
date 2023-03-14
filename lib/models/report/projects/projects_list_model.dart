// To parse this JSON data, do
//
//     final projectListModel = projectListModelFromJson(jsonString);

/*import 'dart:convert';

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
}*/

import 'dart:convert';

ProjectListModel projectListModelFromJson(String str) => ProjectListModel.fromJson(json.decode(str));

String projectListModelToJson(ProjectListModel data) => json.encode(data.toJson());

class ProjectListModel {
    ProjectListModel({
         this.message,
        this.projectsLists,
    });

    String? message;
    List<ProjectsList>? projectsLists;

    factory ProjectListModel.fromJson(Map<String, dynamic> json) => ProjectListModel(
        message: json["message"],
        projectsLists: List<ProjectsList>.from(json["projects lists"].map((x) => ProjectsList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "projects lists": List<dynamic>.from(projectsLists!.map((x) => x.toJson())),
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
         this.budget,
         this.status,
         this.createdAt,
         this.updatedAt,
        this.branch,
        this.employeeproject,
    });

    int? id;
    int? employerId;
    int? branchId;
    int? departmentId;
    dynamic startDate;
    dynamic endDate;
    String? name;
    String? description;
    int? budget;
    int? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    Branch? branch;
    List<Employeeproject>? employeeproject;

    factory ProjectsList.fromJson(Map<String, dynamic> json) => ProjectsList(
        id: json["id"],
        employerId: json["employer_id"],
        branchId: json["branch_id"],
        departmentId: json["department_id"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        name: json["name"],
        description: json["description"],
        budget: json["budget"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        employeeproject: List<Employeeproject>.from(json["employeeproject"].map((x) => Employeeproject.fromJson(x))),
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
        "budget": budget,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "branch": branch?.toJson(),
        "employeeproject": List<dynamic>.from(employeeproject!.map((x) => x.toJson())),
    };
}

class Branch {
    Branch({
        required this.id,
        required this.name,
    });

    int id;
    String name;

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Employeeproject {
    Employeeproject({
        required this.id,
        required this.employerId,
        required this.employeeId,
        required this.projectId,
        required this.user,
    });

    int id;
    int employerId;
    int employeeId;
    int projectId;
    User user;

    factory Employeeproject.fromJson(Map<String, dynamic> json) => Employeeproject(
        id: json["id"],
        employerId: json["employer_id"],
        employeeId: json["employee_id"],
        projectId: json["project_id"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "employee_id": employeeId,
        "project_id": projectId,
        "user": user.toJson(),
    };
}

class User {
    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        this.image,
        required this.branchId,
        this.branch,
    });

    int id;
    String firstName;
    String lastName;
    dynamic image;
    int branchId;
    dynamic branch;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        branchId: json["branch_id"],
        branch: json["branch"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "branch_id": branchId,
        "branch": branch,
    };
}