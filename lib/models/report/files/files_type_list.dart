// To parse this JSON data, do
//
//     final filesTypeListModel = filesTypeListModelFromJson(jsonString);

import 'dart:convert';

FilesTypeListModel filesTypeListModelFromJson(String str) =>
    FilesTypeListModel.fromJson(json.decode(str));

String filesTypeListModelToJson(FilesTypeListModel data) =>
    json.encode(data.toJson());

class FilesTypeListModel {
  FilesTypeListModel({
    required this.message,
    required this.fileTypes,
  });

  String message;
  List<FileTypes> fileTypes;

  factory FilesTypeListModel.fromJson(Map<String, dynamic> json) =>
      FilesTypeListModel(
        message: json["message"],
        fileTypes: List<FileTypes>.from(
            json["file_types"].map((x) => FileTypes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "file_types": List<dynamic>.from(fileTypes.map((x) => x.toJson())),
      };
}

class FileTypes {
  FileTypes({
    required this.id,
    required this.fileType,
  });

  int id;
  String fileType;

  factory FileTypes.fromJson(Map<String, dynamic> json) => FileTypes(
        id: json["id"],
        fileType: json["file_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_type": fileType,
      };
}
