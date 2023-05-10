// To parse this JSON data, do
//
//     final employeeFilesListModel = employeeFilesListModelFromJson(jsonString);

import 'dart:convert';

EmployeeFilesListModel employeeFilesListModelFromJson(String str) =>
    EmployeeFilesListModel.fromJson(json.decode(str));

String employeeFilesListModelToJson(EmployeeFilesListModel data) =>
    json.encode(data.toJson());

class EmployeeFilesListModel {
  String? message;
  List<FileElement>? files;

  EmployeeFilesListModel({
    this.message,
    this.files,
  });

  factory EmployeeFilesListModel.fromJson(Map<String, dynamic> json) =>
      EmployeeFilesListModel(
        message: json["message"],
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson())),
      };
}

class FileElement {
  int? id;
  int? userId;
  int? fileTypeId;
  int? employerId;
  String? file;
  DateTime? createdAt;
  DateTime? updatedAt;
  Filetype? filetype;

  FileElement({
    this.id,
    this.userId,
    this.fileTypeId,
    this.employerId,
    this.file,
    this.createdAt,
    this.updatedAt,
    this.filetype,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        userId: json["user_id"],
        fileTypeId: json["file_type_id"],
        employerId: json["employer_id"],
        file: json["file"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        filetype: json["filetype"] == null
            ? null
            : Filetype.fromJson(json["filetype"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "file_type_id": fileTypeId,
        "employer_id": employerId,
        "file": file,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "filetype": filetype?.toJson(),
      };
}

class Filetype {
  int? id;
  String? fileType;
  int? visibleStatus;

  Filetype({
    this.id,
    this.fileType,
    this.visibleStatus,
  });

  factory Filetype.fromJson(Map<String, dynamic> json) => Filetype(
        id: json["id"],
        fileType: json["file_type"],
        visibleStatus: json["visible_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_type": fileType,
        "visible_status": visibleStatus,
      };
}
