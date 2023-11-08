// To parse this JSON data, do
//
//     final overtimeListResponseModel = overtimeListResponseModelFromJson(jsonString);

import 'dart:convert';

AdvanceResponseModel advanceResponseModelFromJson(String str) =>
    AdvanceResponseModel.fromJson(json.decode(str));

String advanceResponseModelToJson(AdvanceResponseModel data) =>
    json.encode(data.toJson());

class AdvanceResponseModel {
  AdvanceResponseModel({
    required this.message,
    required this.employeeList,
  });

  String message;
  List<EmployeesList> employeeList;

  factory AdvanceResponseModel.fromJson(Map<String, dynamic> json) =>
      AdvanceResponseModel(
        message: json["message"],
        employeeList: json["employee_list"] == null
            ? []
            : List<EmployeesList>.from(
                json["employee_list"]!.map((x) => EmployeesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "employee_list": employeeList == null
            ? []
            : List<dynamic>.from(employeeList.map((x) => x.toJson())),
      };
}

class EmployeesList {
  EmployeesList({
    this.id,
    this.employerId,
    this.userid,
    this.advanceAmount,
    this.date,
    this.totalHours,
    this.status,
    this.reason,
    this.declineReason,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.branch,
  });

  int? id;
  int? employerId;
  int? userid;
  DateTime? date;
  String? advanceAmount;
  String? totalHours;
  String? status;
  String? reason;
  String? declineReason;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  dynamic branch;

  factory EmployeesList.fromJson(Map<String, dynamic> json) => EmployeesList(
        id: json["id"],
        employerId: json["employer_id"],
        userid: json["user_id"],
        date: json["requested_date"] == null
            ? null
            : DateTime.parse(json["requested_date"]),
        totalHours: json["total_hours"],
        advanceAmount: json["advance_amount"],
        status: json["status"],
        reason: json["description"],
        declineReason: json["decline_reason"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        branch: json["branch"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "employee_id": userid,
        "requested_date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "total_hours": totalHours,
        "status": status,
        "description": reason,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "branch": branch,
      };
}

class User {
  User({
    this.id,
    this.employerId,
    this.employmentStartDate,
    this.employmentEndDate,
    this.payedDate,
    this.payDate,
    this.bankBranchName,
    this.businessId,
    this.departmentId,
    this.salaryType,
    this.rate,
    this.payPeriod,
    this.workdaysPerWeek,
    this.totalHoursPerWeek,
    this.extraHoursAtBaseRate,
    this.employeeType,
    this.firstName,
    this.lastName,
    this.company,
    this.branchId,
    this.position,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.street,
    this.city,
    this.town,
    this.postcode,
    this.countryId,
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
    this.forgotPassOtp,
    this.status,
  });

  int? id;
  int? employerId;
  DateTime? employmentStartDate;
  DateTime? employmentEndDate;
  DateTime? payedDate;
  DateTime? payDate;
  dynamic bankBranchName;
  int? businessId;
  int? departmentId;
  String? salaryType;
  dynamic rate;
  dynamic payPeriod;
  String? workdaysPerWeek;
  String? totalHoursPerWeek;
  String? extraHoursAtBaseRate;
  dynamic employeeType;
  String? firstName;
  String? lastName;
  String? company;
  int? branchId;
  dynamic position;
  String? email;
  String? phone;
  DateTime? dateOfBirth;
  String? street;
  String? city;
  String? town;
  String? postcode;
  String? countryId;
  String? tin;
  String? fnpf;
  String? bank;
  String? accountNumber;
  String? image;
  String? isFirst;
  String? otp;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic forgotPassOtp;
  int? status;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        employerId: json["employer_id"],
        employmentStartDate: json["employment_start_date"] == null
            ? null
            : DateTime.parse(json["employment_start_date"]),
        employmentEndDate: json["employment_end_date"] == null
            ? null
            : DateTime.parse(json["employment_end_date"]),
        payedDate: json["payed_date"] == null
            ? null
            : DateTime.parse(json["payed_date"]),
        payDate:
            json["pay_date"] == null ? null : DateTime.parse(json["pay_date"]),
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
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        street: json["street"],
        city: json["city"],
        town: json["town"],
        postcode: json["postcode"],
        countryId: json["country_id"],
        tin: json["tin"],
        fnpf: json["fnpf"],
        bank: json["bank"],
        accountNumber: json["account_number"],
        image: json["image"],
        isFirst: json["isFirst"],
        otp: json["otp"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
            "${payedDate!.year.toString().padLeft(4, '0')}-${payedDate!.month.toString().padLeft(2, '0')}-${payedDate!.day.toString().padLeft(2, '0')}",
        "pay_date":
            "${payDate!.year.toString().padLeft(4, '0')}-${payDate!.month.toString().padLeft(2, '0')}-${payDate!.day.toString().padLeft(2, '0')}",
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
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
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
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "forgot_pass_otp": forgotPassOtp,
        "status": status,
      };
}