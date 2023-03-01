// To parse this JSON data, do
//
//     final medicalListAdminModel = medicalListAdminModelFromJson(jsonString);

import 'dart:convert';

MedicalListAdminModel medicalListAdminModelFromJson(String str) =>
    MedicalListAdminModel.fromJson(json.decode(str));

String medicalListAdminModelToJson(MedicalListAdminModel data) =>
    json.encode(data.toJson());

class MedicalListAdminModel {
  MedicalListAdminModel({
    required this.message,
    required this.extraDetails,
  });

  String message;
  List<ExtraDetail> extraDetails;

  factory MedicalListAdminModel.fromJson(Map<String, dynamic> json) =>
      MedicalListAdminModel(
        message: json["message"],
        extraDetails: List<ExtraDetail>.from(
            json["extra_details"].map((x) => ExtraDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "extra_details":
            List<dynamic>.from(extraDetails.map((x) => x.toJson())),
      };
}

class ExtraDetail {
  ExtraDetail({
    this.id,
    this.employeeId,
    this.employerId,
    this.docType,
    this.docLink,
    this.bloodGrp,
    this.allergies,
    this.medicalIssues,
    this.measurement,
    this.extraLeave,
    this.paidStatus,
    this.commissionBonus,
    this.createdAt,
    this.updatedAt,
    this.users,
  });

  int? id;
  int? employeeId;
  int? employerId;
  String? docType;
  String? docLink;
  String? bloodGrp;
  String? allergies;
  String? medicalIssues;
  String? measurement;
  String? extraLeave;
  String? paidStatus;
  String? commissionBonus;
  DateTime? createdAt;
  DateTime? updatedAt;
  Users? users;

  factory ExtraDetail.fromJson(Map<String, dynamic> json) => ExtraDetail(
        id: json["id"],
        employeeId: json["employee_id"],
        employerId: json["employer_id"],
        docType: json["doc_type"],
        docLink: json["doc_link"],
        bloodGrp: json["blood_grp"],
        allergies: json["allergies"],
        medicalIssues: json["medical_issues"],
        measurement: json["measurement"],
        extraLeave: json["extra_leave"],
        paidStatus: json["paid_status"],
        commissionBonus: json["commission_bonus"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        users: json["users"] != null ? Users.fromJson(json["users"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "employer_id": employerId,
        "doc_type": docType,
        "doc_link": docLink,
        "blood_grp": bloodGrp,
        "allergies": allergies,
        "medical_issues": medicalIssues,
        "measurement": measurement,
        "extra_leave": extraLeave,
        "paid_status": paidStatus,
        "commission_bonus": commissionBonus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "users": users?.toJson(),
      };
}

class Users {
  Users({
    this.id,
    this.employerId,
    this.employmentStartDate,
    this.employmentEndDate,
    this.payedDate,
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
    this.forgotPassOtp,
    this.status,
  });

  int? id;
  int? employerId;
  String? employmentStartDate;
  String? employmentEndDate;
  String? payedDate;
  String? bankBranchName;
  String? businessId;
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
  DateTime? dateOfBirth;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  String? forgotPassOtp;
  int? status;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        employerId: json["employer_id"],
        employmentStartDate: json["employment_start_date"],
        employmentEndDate: json["employment_end_date"],
        payedDate: json["payed_date"],
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        forgotPassOtp: json["forgot_pass_otp"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "employment_start_date": employmentStartDate,
        "employment_end_date": employmentEndDate,
        "payed_date": payedDate,
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
            "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "forgot_pass_otp": forgotPassOtp,
        "status": status,
      };
}
