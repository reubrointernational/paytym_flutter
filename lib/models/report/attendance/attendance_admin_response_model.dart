// To parse this JSON data, do
//
//     final attendanceAdminModel = attendanceAdminModelFromJson(jsonString);

import 'dart:convert';

AttendanceAdminModel attendanceAdminModelFromJson(String str) => AttendanceAdminModel.fromJson(json.decode(str));

String attendanceAdminModelToJson(AttendanceAdminModel data) => json.encode(data.toJson());

class AttendanceAdminModel {
    AttendanceAdminModel({
        required this.message,
        required this.history,
    });

    String message;
    List<History> history;

    factory AttendanceAdminModel.fromJson(Map<String, dynamic> json) => AttendanceAdminModel(
        message: json["message"],
        history: List<History>.from(json["history"].map((x) => History.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
    };
}

class History {
    History({
        required this.id,
        required this.userId,
        required this.employerId,
        required this.checkIn,
        this.checkOut,
        required this.status,
        required this.date,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
    });

    int id;
    int userId;
    int employerId;
    DateTime checkIn;
    DateTime? checkOut;
    String status;
    DateTime date;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        userId: json["user_id"],
        employerId: json["employer_id"],
        checkIn: DateTime.parse(json["check_in"]),
        checkOut: json["check_out"] == null ? null : DateTime.parse(json["check_out"]),
        status: json["status"],
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employer_id": employerId,
        "check_in": checkIn.toIso8601String(),
        "check_out": checkOut?.toIso8601String(),
        "status": status,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
    };
}

class User {
    User({
        required this.id,
        required this.employerId,
        this.employeeType,
        required this.firstName,
        required this.lastName,
        required this.company,
        required this.branch,
        this.position,
        required this.email,
        required this.phone,
        required this.dateOfBirth,
        required this.street,
        required this.city,
        required this.town,
        required this.postcode,
        required this.country,
        required this.tin,
        required this.fnpf,
        required this.bank,
        required this.accountNumber,
        this.image,
        required this.isFirst,
        this.otp,
        this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
        this.forgotPassOtp,
        required this.status,
    });

    int id;
    int employerId;
    dynamic employeeType;
    String firstName;
    String lastName;
    String company;
    String branch;
    int? position;
    String email;
    String phone;
    DateTime dateOfBirth;
    String street;
    String city;
    String town;
    String postcode;
    String country;
    String tin;
    String fnpf;
    String bank;
    String accountNumber;
    String? image;
    String isFirst;
    String? otp;
    DateTime? emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic forgotPassOtp;
    int status;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        employerId: json["employer_id"],
        employeeType: json["employee_type"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        branch: json["branch"],
        position: json["position"],
        email: json["email"],
        phone: json["phone"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
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
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        forgotPassOtp: json["forgot_pass_otp"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "employee_type": employeeType,
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "branch": branch,
        "position": position,
        "email": email,
        "phone": phone,
        "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
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
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "forgot_pass_otp": forgotPassOtp,
        "status": status,
    };
}








