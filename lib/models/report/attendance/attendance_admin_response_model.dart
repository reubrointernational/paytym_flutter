// To parse this JSON data, do
//
//     final attendanceAdminModel = attendanceAdminModelFromJson(jsonString);

/*import 'dart:convert';

AttendanceAdminModel attendanceAdminModelFromJson(String str) =>
    AttendanceAdminModel.fromJson(json.decode(str));

String attendanceAdminModelToJson(AttendanceAdminModel data) =>
    json.encode(data.toJson());

class AttendanceAdminModel {
  AttendanceAdminModel({
    required this.message,
    required this.history,
  });

  String message;
  List<History> history;

  factory AttendanceAdminModel.fromJson(Map<String, dynamic> json) =>
      AttendanceAdminModel(
        message: json["message"],
        history:
            List<History>.from(json["history"].map((x) => History.fromJson(x))),
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
    required this.checkOut,
    required this.status,
    this.approveReject,
    this.reason,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  int id;
  int userId;
  int employerId;
  String? checkIn;
  String? checkOut;
  String? status;
  dynamic approveReject;
  dynamic reason;
  String? date;
  String? createdAt;
  String? updatedAt;
  User? user;

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        userId: json["user_id"],
        employerId: json["employer_id"],
        checkIn: json["check_in"],
        checkOut: json["check_out"],
        status: json["status"],
        approveReject: json["approve_reject"],
        reason: json["reason"],
        date: json["date"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employer_id": employerId,
        "check_in": checkIn,
        "check_out": checkOut,
        "status": status,
        "approve_reject": approveReject,
        "reason": reason,
        "date":
            date,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user!.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.employerId,
    this.employmentStartDate,
    this.employmentEndDate,
    this.bankBranchName,
    this.businessId,
    required this.departmentId,
    required this.salaryType,
    this.rate,
    this.payPeriod,
    this.workdaysPerWeek,
    this.totalHoursPerWeek,
    this.extraHoursAtBaseRate,
    this.employeeType,
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.branchId,
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
    required this.image,
    required this.isFirst,
    required this.otp,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.forgotPassOtp,
    required this.status,
  });

  int id;
  int employerId;
  dynamic employmentStartDate;
  dynamic employmentEndDate;
  dynamic bankBranchName;
  dynamic businessId;
  int departmentId;
  String? salaryType;
  dynamic rate;
  dynamic payPeriod;
  dynamic workdaysPerWeek;
  dynamic totalHoursPerWeek;
  dynamic extraHoursAtBaseRate;
  dynamic employeeType;
  String? firstName;
  String? lastName;
  String? company;
  int branchId;
  dynamic position;
  String? email;
  String? phone;
  DateTime dateOfBirth;
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
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  dynamic forgotPassOtp;
  int status;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        employerId: json["employer_id"],
        employmentStartDate: json["employment_start_date"],
        employmentEndDate: json["employment_end_date"],
        bankBranchName: json["bank_branch_name"],
        businessId: json["business_id"],
        departmentId: json["department_id"],
        salaryType: json["salary_type"],
        rate: json["rate"],
        payPeriod: json["pay_period"],
        workdaysPerWeek: json["workdays_per_week"],
        totalHoursPerWeek: json["total_hours_per_week"],
        extraHoursAtBaseRate: json["extra_hours_at_base_rate"],
        employeeType: json["employee_type"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        branchId: json["branch_id"],
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
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        forgotPassOtp: json["forgot_pass_otp"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "employment_start_date": employmentStartDate,
        "employment_end_date": employmentEndDate,
        "bank_branch_name": bankBranchName,
        "business_id": businessId,
        "department_id": departmentId,
        "salary_type": salaryType,
        "rate": rate,
        "pay_period": payPeriod,
        "workdays_per_week": workdaysPerWeek,
        "total_hours_per_week": totalHoursPerWeek,
        "extra_hours_at_base_rate": extraHoursAtBaseRate,
        "employee_type": employeeType,
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "branch_id": branchId,
        "position": position,
        "email": email,
        "phone": phone,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
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
        "forgot_pass_otp": forgotPassOtp,
        "status": status,
      };
}*/

import 'dart:convert';

AttendanceAdminModel attendanceAdminModelFromJson(String str) =>
    AttendanceAdminModel.fromJson(json.decode(str));

String attendanceAdminModelToJson(AttendanceAdminModel data) =>
    json.encode(data.toJson());

class AttendanceAdminModel {
  AttendanceAdminModel({
    required this.message,
    required this.history,
  });

  String message;
  List<History> history;

  factory AttendanceAdminModel.fromJson(Map<String, dynamic> json) =>
      AttendanceAdminModel(
        message: json["message"],
        history:
            List<History>.from(json["history"].map((x) => History.fromJson(x))),
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
    this.approveReject,
    this.reason,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  int id;
  int userId;
  int employerId;
  String? checkIn;
  String? checkOut;
  String status;
  dynamic approveReject;
  dynamic reason;
  String date;
  String createdAt;
  String updatedAt;
  User? user;

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        userId: json["user_id"],
        employerId: json["employer_id"],
        checkIn: json["check_in"],
        checkOut: json["check_out"],
        status: json["status"],
        approveReject: json["approve_reject"],
        reason: json["reason"],
        date: json["date"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employer_id": employerId,
        "check_in": checkIn,
        "check_out": checkOut,
        "status": status,
        "approve_reject": approveReject,
        "reason": reason,
        "date": date,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user?.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.employerId,
    required this.employmentStartDate,
    required this.employmentEndDate,
    required this.payedDate,
    required this.payDate,
    this.bankBranchName,
    required this.businessId,
    required this.departmentId,
    required this.salaryType,
    this.rate,
    this.payPeriod,
    required this.workdaysPerWeek,
    required this.totalHoursPerWeek,
    required this.extraHoursAtBaseRate,
    this.employeeType,
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.branchId,
    this.position,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.street,
    required this.city,
    required this.town,
    required this.postcode,
    required this.countryId,
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
  dynamic employmentStartDate;
  dynamic employmentEndDate;
  dynamic payedDate;
  dynamic payDate;
  dynamic bankBranchName;
  int? businessId;
  int departmentId;
  String salaryType;
  dynamic rate;
  dynamic payPeriod;
  String? workdaysPerWeek;
  String? totalHoursPerWeek;
  String? extraHoursAtBaseRate;
  dynamic employeeType;
  String firstName;
  String lastName;
  String company;
  int branchId;
  int? position;
  dynamic email;
  String phone;
  dynamic dateOfBirth;
  String street;
  String city;
  String town;
  String postcode;
  dynamic countryId;
  String tin;
  String fnpf;
  String bank;
  String accountNumber;
  String? image;
  String isFirst;
  String? otp;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic forgotPassOtp;
  int status;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        employerId: json["employer_id"],
        employmentStartDate: json["employment_start_date"],
        employmentEndDate: json["employment_end_date"],
        payedDate: json["payed_date"],
        payDate: json["pay_date"],
        bankBranchName: json["bank_branch_name"],
        businessId: json["business_id"],
        departmentId: json["department_id"],
        salaryType: json["salary_type"],
        rate: json["rate"],
        payPeriod: json["pay_period"],
        workdaysPerWeek: json["workdays_per_week"],
        totalHoursPerWeek: json["total_hours_per_week"],
        extraHoursAtBaseRate: json["extra_hours_at_base_rate"],
        employeeType: json["employee_type"],
        firstName: json["first_name"],
        lastName: json["last_name"]!,
        company: json["company"]!,
        branchId: json["branch_id"],
        position: json["position"],
        email: json["email"]!,
        phone: json["phone"]!,
        dateOfBirth: json["date_of_birth"],
        street: json["street"]!,
        city: json["city"]!,
        town: json["town"]!,
        postcode: json["postcode"],
        countryId: json["country_id"],
        tin: json["tin"],
        fnpf: json["fnpf"]!,
        bank: json["bank"]!,
        accountNumber: json["account_number"],
        image: json["image"],
        isFirst: json["isFirst"],
        otp: json["otp"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        forgotPassOtp: json["forgot_pass_otp"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "employment_start_date":
            "${employmentStartDate!.year.toString().padLeft(4, '0')}-${employmentStartDate!.month.toString().padLeft(2, '0')}-${employmentStartDate!.day.toString().padLeft(2, '0')}",
        "employment_end_date":
            "${employmentEndDate!.year.toString().padLeft(4, '0')}-${employmentEndDate!.month.toString().padLeft(2, '0')}-${employmentEndDate!.day.toString().padLeft(2, '0')}",
        "payed_date":
            "${payedDate.year.toString().padLeft(4, '0')}-${payedDate.month.toString().padLeft(2, '0')}-${payedDate.day.toString().padLeft(2, '0')}",
        "pay_date":
            "${payDate.year.toString().padLeft(4, '0')}-${payDate.month.toString().padLeft(2, '0')}-${payDate.day.toString().padLeft(2, '0')}",
        "bank_branch_name": bankBranchName,
        "business_id": businessId,
        "department_id": departmentId,
        "salary_type": salaryType,
        "rate": rate,
        "pay_period": payPeriod,
        "workdays_per_week": workdaysPerWeek,
        "total_hours_per_week": totalHoursPerWeek,
        "extra_hours_at_base_rate": extraHoursAtBaseRate,
        "employee_type": employeeType,
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "branch_id": branchId,
        "position": position,
        "email": email,
        "phone": phone,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "street": street,
        "city": city,
        "town": town,
        "postcode": postcode,
        "country_id": countryId,
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
