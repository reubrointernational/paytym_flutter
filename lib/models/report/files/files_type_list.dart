// To parse this JSON data, do
//
//     final filesTypeListModel = filesTypeListModelFromJson(jsonString);

import 'dart:convert';

FilesTypeListModel filesTypeListModelFromJson(String str) =>
    FilesTypeListModel.fromJson(json.decode(str));

String filesTypeListModelToJson(FilesTypeListModel data) =>
    json.encode(data.toJson());

class FilesTypeListModel {
  String message;
  List<FileType> fileTypes;

  FilesTypeListModel({
    required this.message,
    required this.fileTypes,
  });

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
  int id;
  String fileType;
  int visibleStatus;

  FileType({
    required this.id,
    required this.fileType,
    required this.visibleStatus,
  });

  factory FileType.fromJson(Map<String, dynamic> json) => FileType(
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
