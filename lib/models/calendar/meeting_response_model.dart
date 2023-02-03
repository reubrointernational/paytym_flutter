// To parse this JSON data, do
//
//     final meetingResponseModel = meetingResponseModelFromJson(jsonString);

import 'dart:convert';

MeetingResponseModel meetingResponseModelFromJson(String str) =>
    MeetingResponseModel.fromJson(json.decode(str));

String meetingResponseModelToJson(MeetingResponseModel data) =>
    json.encode(data.toJson());

class MeetingResponseModel {
  MeetingResponseModel({
    this.message,
    this.payroll,
  });

  String? message;
  List<Payroll>? payroll;

  factory MeetingResponseModel.fromJson(Map<String, dynamic> json) =>
      MeetingResponseModel(
        message: json["message"],
        payroll: json["payroll"] != null
            ? List<Payroll>.from(
                json["payroll"].map((x) => Payroll.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "payroll": List<dynamic>.from(payroll!.map((x) => x.toJson())),
      };
}

class Payroll {
  Payroll({
    this.id,
    this.userId,
    this.attendeeId,
    this.date,
    this.startTime,
    this.endTime,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? userId;
  int? attendeeId;
  String? date;
  String? startTime;
  String? endTime;
  String? location;
  String? createdAt;
  String? updatedAt;
  User? user;

  factory Payroll.fromJson(Map<String, dynamic> json) => Payroll(
        id: json["id"],
        userId: json["user_id"],
        attendeeId: json["attendee_id"],
        date: json["date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        location: json["location"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "attendee_id": attendeeId,
        "date": date,
        "start_time": startTime,
        "end_time": endTime,
        "location": location,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user?.toJson(),
      };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.company,
    this.branch,
    this.position,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.street,
    this.city,
    this.town,
    this.postcode,
    this.country,
    this.tin,
    this.fnpf,
    this.bank,
    this.accountNumber,
    this.image,
    this.isFirst,
    this.otp,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? company;
  String? branch;
  String? position;
  String? email;
  String? phone;
  String? dateOfBirth;
  String? street;
  String? city;
  String? town;
  String? postcode;
  String? country;
  String? tin;
  String? fnpf;
  String? bank;
  String? accountNumber;
  String? image;
  String? isFirst;
  String? otp;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        branch: json["branch"],
        position: json["position"],
        email: json["email"],
        phone: json["phone"],
        dateOfBirth: json["date_of_birth"],
        street: json["street"],
        city: json["city"],
        town: json["town"],
        postcode: json["postcode"],
        country: json["country"],
        tin: json["tin"],
        fnpf: json["fnpf"],
        bank: json["bank"],
        accountNumber: json["account_number"],
        image: json["image"],
        isFirst: json["isFirst"],
        otp: json["otp"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "branch": branch,
        "position": position,
        "email": email,
        "phone": phone,
        "date_of_birth": dateOfBirth,
        "street": street,
        "city": city,
        "town": town,
        "postcode": postcode,
        "country": country,
        "tin": tin,
        "fnpf": fnpf,
        "bank": bank,
        "account_number": accountNumber,
        "image": image,
        "isFirst": isFirst,
        "otp": otp,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
