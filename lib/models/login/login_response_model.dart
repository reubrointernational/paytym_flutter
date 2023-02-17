// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.message,
    this.employee,
    this.token,
    this.casual,
    this.absence,
    this.annual,
    this.halfday,
  });

  String? message;
  Employee? employee;
  String? token;
  int? casual;
  int? absence;
  int? annual;
  int? halfday;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        employee: Employee.fromJson(json["employee"]),
        token: json["token"],
        casual: json["casual"],
        absence: json["absence"],
        annual: json["annual"],
        halfday: json["halfday"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "employee": employee?.toJson(),
        "token": token,
        "casual": casual,
        "absence": absence,
        "annual": annual,
        "halfday": halfday,
      };
}

class Employee {
  Employee({
    this.id,
    this.employer_id,
    this.firstName,
    this.lastName,
    this.company,
    this.branch,
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
  int?  employer_id;
  String? firstName;
  String? lastName;
  String? company;
  String? branch;
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

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        employer_id: json["employer_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        branch: json["branch"],
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
        "employer_id": employer_id,
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "branch": branch,
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
