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
    this.capabilities,
    this.lastCheckedIn,
  });

  String? message;
  Employee? employee;
  String? token;
  int? casual;
  int? absence;
  int? annual;
  int? halfday;
  List<Capability>? capabilities;
  String? lastCheckedIn;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        employee: json["employee"] == null
            ? null
            : Employee.fromJson(json["employee"]),
        token: json["token"],
        casual: json["casual"],
        absence: json["absence"],
        annual: json["annual"],
        halfday: json["halfday"],
        lastCheckedIn: json["last_checked_in"],
        capabilities: json["capabilities"] == null
            ? []
            : List<Capability>.from(
                json["capabilities"]!.map((x) => Capability.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "employee": employee?.toJson(),
        "token": token,
        "casual": casual,
        "absence": absence,
        "annual": annual,
        "halfday": halfday,
        "capabilities": capabilities == null
            ? []
            : List<dynamic>.from(capabilities!.map((x) => x.toJson())),
      };
}

class Capability {
  Capability({
    this.id,
    this.roleId,
    this.employerId,
    this.wages,
    this.projects,
    this.attendance,
    this.approveAttendance,
    this.medical,
    this.contractPeriod,
    this.deductions,
    this.createChatGroups,
    this.createMeetings,
    this.approveLeaves,
    this.viewPayroll,
    this.approvePayroll,
    this.calculatePayroll,
    this.editDeduction,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  int? id;
  int? roleId;
  int? employerId;
  int? wages;
  int? projects;
  int? attendance;
  int? approveAttendance;
  int? medical;
  int? contractPeriod;
  int? deductions;
  int? createChatGroups;
  int? createMeetings;
  int? approveLeaves;
  int? viewPayroll;
  int? approvePayroll;
  int? calculatePayroll;
  int? editDeduction;
  DateTime? createdAt;
  DateTime? updatedAt;
  Role? role;

  factory Capability.fromJson(Map<String, dynamic> json) => Capability(
        id: json["id"],
        roleId: json["role_id"],
        employerId: json["employer_id"],
        wages: json["wages"],
        projects: json["projects"],
        attendance: json["attendance"],
        approveAttendance: json["approve_attendance"],
        medical: json["medical"],
        contractPeriod: json["contract_period"],
        deductions: json["deductions"],
        createChatGroups: json["create_chat_groups"],
        createMeetings: json["create_meetings"],
        approveLeaves: json["approve_leaves"],
        viewPayroll: json["view_payroll"],
        approvePayroll: json["approve_payroll"],
        calculatePayroll: json["calculate_payroll"],
        editDeduction: json["edit_deduction"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "employer_id": employerId,
        "wages": wages,
        "projects": projects,
        "attendance": attendance,
        "approve_attendance": approveAttendance,
        "medical": medical,
        "contract_period": contractPeriod,
        "deductions": deductions,
        "create_chat_groups": createChatGroups,
        "create_meetings": createMeetings,
        "approve_leaves": approveLeaves,
        "view_payroll": viewPayroll,
        "approve_payroll": approvePayroll,
        "calculate_payroll": calculatePayroll,
        "edit_deduction": editDeduction,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "role": role?.toJson(),
      };
}

class Role {
  Role({
    this.id,
    this.roleName,
  });

  int? id;
  String? roleName;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        roleName: json["role_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_name": roleName,
      };
}

class Employee {
  Employee({
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
  String? employmentStartDate;
  String? employmentEndDate;
  String? payedDate;
  String? payDate;
  String? bankBranchName;
  int? businessId;
  int? departmentId;
  String? salaryType;
  String? rate;
  String? payPeriod;
  String? workdaysPerWeek;
  String? totalHoursPerWeek;
  String? extraHoursAtBaseRate;
  String? employeeType;
  String? firstName;
  String? lastName;
  String? company;
  int? branchId;
  int? position;
  String? email;
  String? phone;
  String? dateOfBirth;
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

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
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
        lastName: json["last_name"],
        company: json["company"],
        branchId: json["branch_id"],
        position: json["position"],
        email: json["email"],
        phone: json["phone"],
        dateOfBirth: json["date_of_birth"],
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
        "employment_start_date": employmentStartDate,
        "employment_end_date": employmentEndDate,
        "payed_date": payedDate,
        "pay_date": payDate,
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
        "date_of_birth": dateOfBirth,
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
