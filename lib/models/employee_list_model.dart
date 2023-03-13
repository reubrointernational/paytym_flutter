// To parse this JSON data, do
//
//     final employeeListAdminModel = employeeListAdminModelFromJson(jsonString);

import 'dart:convert';

EmployeeListAdminModel employeeListAdminModelFromJson(String str) =>
    EmployeeListAdminModel.fromJson(json.decode(str));

String employeeListAdminModelToJson(EmployeeListAdminModel data) =>
    json.encode(data.toJson());

class EmployeeListAdminModel {
  EmployeeListAdminModel({
    this.message,
    this.employeeList,
  });

  String? message;
  List<EmployeeList>? employeeList;

  factory EmployeeListAdminModel.fromJson(Map<String, dynamic> json) =>
      EmployeeListAdminModel(
        message: json["message"],
        employeeList: json["employee_list"] == null
            ? []
            : List<EmployeeList>.from(
                json["employee_list"]!.map((x) => EmployeeList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "employee_list": employeeList == null
            ? []
            : List<dynamic>.from(employeeList!.map((x) => x.toJson())),
      };
}

class EmployeeList {
  EmployeeList({
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
    this.deviceId,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.forgotPassOtp,
    this.status,
    this.payroll,
    this.department,
    this.branch,
    this.isExpanded = false,
  });

  int? id;
  bool isExpanded;
  int? employerId;
  DateTime? employmentStartDate;
  DateTime? employmentEndDate;
  DateTime? payedDate;
  DateTime? payDate;
  dynamic bankBranchName;
  int? businessId;
  int? departmentId;
  String? salaryType;
  String? rate;
  String? payPeriod;
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
  dynamic deviceId;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic forgotPassOtp;
  int? status;
  dynamic payroll;
  Department? department;
  Branch? branch;

  factory EmployeeList.fromJson(Map<String, dynamic> json) => EmployeeList(
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
        deviceId: json["device_id"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        forgotPassOtp: json["forgot_pass_otp"],
        status: json["status"],
        payroll: json["payroll"],
        department: json["department"] == null
            ? null
            : Department.fromJson(json["department"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
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
        "device_id": deviceId,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "forgot_pass_otp": forgotPassOtp,
        "status": status,
        "payroll": payroll,
        "department": department?.toJson(),
        "branch": branch?.toJson(),
      };
}

class Branch {
  Branch({
    this.id,
    this.employerId,
    this.employerBusinessId,
    this.name,
    this.city,
    this.town,
    this.postcode,
    this.country,
    this.bank,
    this.accountNumber,
    this.qrCode,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? employerId;
  int? employerBusinessId;
  String? name;
  String? city;
  String? town;
  String? postcode;
  String? country;
  String? bank;
  String? accountNumber;
  String? qrCode;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        employerId: json["employer_id"],
        employerBusinessId: json["employer_business_id"],
        name: json["name"],
        city: json["city"],
        town: json["town"],
        postcode: json["postcode"],
        country: json["country"],
        bank: json["bank"],
        accountNumber: json["account_number"],
        qrCode: json["qr_code"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "employer_business_id": employerBusinessId,
        "name": name,
        "city": city,
        "town": town,
        "postcode": postcode,
        "country": country,
        "bank": bank,
        "account_number": accountNumber,
        "qr_code": qrCode,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Department {
  Department({
    this.id,
    this.employerId,
    this.branchId,
    this.depName,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? employerId;
  int? branchId;
  String? depName;
  int? status;
  dynamic createdAt;
  dynamic updatedAt;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        employerId: json["employer_id"],
        branchId: json["branch_id"],
        depName: json["dep_name"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "branch_id": branchId,
        "dep_name": depName,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
