import 'dart:convert';

FileUploadRequestModel fileUploadRequestModelFromJson(String str) => FileUploadRequestModel.fromJson(json.decode(str));

String fileUploadRequestModelToJson(FileUploadRequestModel data) => json.encode(data.toJson());

class FileUploadRequestModel {
    FileUploadRequestModel({
        required this.employerId,
        required this.fileTypeId,
        required this.userId,
        required this.status,
        required this.id,
    });

    String employerId;
    String fileTypeId;
    String userId;
    String status;
    String id;

    factory FileUploadRequestModel.fromJson(Map<String, dynamic> json) => FileUploadRequestModel(
        employerId: json["employer_id"],
        fileTypeId: json["file_type_id"],
        userId: json["user_id"],
        status: json["status"],
        id: json["id"],
    );

    Map<String, String> toJson() => {
        "employer_id": employerId,
        "file_type_id": fileTypeId,
        "user_id": userId,
        "status": status,
        "id": id,
    };
}