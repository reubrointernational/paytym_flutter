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
  List<FileType> fileTypes;

  factory FilesTypeListModel.fromJson(Map<String, dynamic> json) =>
      FilesTypeListModel(
        message: json["message"],
        fileTypes: List<FileType>.from(
            json["file_types"].map((x) => FileType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "file_types": List<dynamic>.from(fileTypes.map((x) => x.toJson())),
      };
}

class FileType {
  FileType({
    required this.id,
    required this.fileType,
  });

  int id;
  String fileType;

  factory FileType.fromJson(Map<String, dynamic> json) => FileType(
        id: json["id"],
        fileType: json["file_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_type": fileType,
      };
}
