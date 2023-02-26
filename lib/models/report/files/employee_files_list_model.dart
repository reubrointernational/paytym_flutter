// To parse this JSON data, do
//
//     final employeeFilesListModel = employeeFilesListModelFromJson(jsonString);

import 'dart:convert';

EmployeeFilesListModel employeeFilesListModelFromJson(String str) =>
    EmployeeFilesListModel.fromJson(json.decode(str));

String employeeFilesListModelToJson(EmployeeFilesListModel data) =>
    json.encode(data.toJson());

class EmployeeFilesListModel {
  EmployeeFilesListModel({
    required this.message,
    required this.files,
  });

  String message;
  List<FileElement> files;

  factory EmployeeFilesListModel.fromJson(Map<String, dynamic> json) =>
      EmployeeFilesListModel(
        message: json["message"],
        files: List<FileElement>.from(
            json["files"].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
      };
}

class FileElement {
  FileElement({
    required this.id,
    required this.userId,
    required this.fileTypeId,
    required this.employerId,
    required this.file,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  int fileTypeId;
  int employerId;
  String file;
  DateTime createdAt;
  DateTime updatedAt;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        userId: json["user_id"],
        fileTypeId: json["file_type_id"],
        employerId: json["employer_id"],
        file: json["file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "file_type_id": fileTypeId,
        "employer_id": employerId,
        "file": file,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
