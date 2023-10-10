// // To parse this JSON data, do
// //
// //     final meetingListAdminModel = meetingListAdminModelFromJson(jsonString);
//
import 'dart:convert';

MeetingListAdminModel meetingListAdminModelFromJson(String str) =>
    MeetingListAdminModel.fromJson(json.decode(str));

String meetingListAdminModelToJson(MeetingListAdminModel data) =>
    json.encode(data.toJson());

class MeetingListAdminModel {
  String? message;
  List<MeetingsListe>? meetingsListe;

  MeetingListAdminModel({this.message, this.meetingsListe});

  MeetingListAdminModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['meetings liste'] != null) {
      meetingsListe = <MeetingsListe>[];
      json['meetings liste'].forEach((v) {
        meetingsListe!.add(MeetingsListe.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    if (this.meetingsListe != null) {
      data['meetings liste'] =
          this.meetingsListe!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MeetingsListe {
  int? id;
  int? userId;
  int? employerId;
  String? name;
  String? date;
  String? startTime;
  String? endTime;
  String? agenda;
  String? location;
  String? createdAt;
  String? updatedAt;
  List<MeetingAttendeess>? meetingAttendeess;
  User? user;

  MeetingsListe(
      {this.id,
      this.userId,
      this.employerId,
      this.name,
      this.date,
      this.startTime,
      this.endTime,
      this.agenda,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.meetingAttendeess,
      this.user});

  MeetingsListe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    employerId = json['employer_id'];
    name = json['name'];
    // date = json['date'];
    date:
    json["date"] == null ? null : DateTime.parse(json["date"]);
    startTime = json['start_time'];
    endTime = json['end_time'];
    agenda = json['agenda'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['meeting_attendeess'] != null) {
      meetingAttendeess = <MeetingAttendeess>[];
      json['meeting_attendeess'].forEach((v) {
        meetingAttendeess!.add(MeetingAttendeess.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['employer_id'] = this.employerId;
    data['name'] = this.name;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['agenda'] = this.agenda;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.meetingAttendeess != null) {
      data['meeting_attendeess'] =
          this.meetingAttendeess!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class MeetingAttendeess {
  int? id;
  int? employerId;
  String? jobTitle;
  String? firstName;
  String? lastName;
  String? image;

  MeetingAttendeess(
      {this.id,
      this.employerId,
      this.jobTitle,
      this.firstName,
      this.lastName,
      this.image});

  MeetingAttendeess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employerId = json['employer_id'];
    jobTitle = json['job_title'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['employer_id'] = this.employerId;
    data['job_title'] = this.jobTitle;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    return data;
  }
}

class User {
  int? id;
  int? employerId;
  String? jobTitle;
  String? employmentStartDate;
  String? employmentEndDate;
  String? checkInDefault;
  String? checkOutDefault;
  String? checkOutRequred;
  String? payedDate;
  String? payDate;
  String? bankBranchName;
  int? businessId;
  int? departmentId;
  String? salaryType;
  String? rate;
  String? payPeriod;
  Null? workdaysPerWeek;
  Null? totalHoursPerWeek;
  Null? extraHoursAtBaseRate;
  String? employeeType;
  String? firstName;
  String? lastName;
  String? company;
  int? branchId;
  Position? position;
  String? email;
  String? phone;
  String? dateOfBirth;
  String? street;
  String? city;
  Null? town;
  String? postcode;
  String? countryId;
  String? tin;
  Null? fnpf;
  String? bank;
  String? accountNumber;
  Null? licenceNo;
  Null? licenceExpiryDate;
  Null? passportNo;
  Null? passportExpiryDate;
  String? image;
  String? isFirst;
  String? otp;
  String? deviceId;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  Null? forgotPassOtp;
  int? status;

  User(
      {this.id,
      this.employerId,
      this.jobTitle,
      this.employmentStartDate,
      this.employmentEndDate,
      this.checkInDefault,
      this.checkOutDefault,
      this.checkOutRequred,
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
      this.licenceNo,
      this.licenceExpiryDate,
      this.passportNo,
      this.passportExpiryDate,
      this.image,
      this.isFirst,
      this.otp,
      this.deviceId,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.forgotPassOtp,
      this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employerId = json['employer_id'];
    jobTitle = json['job_title'];
    employmentStartDate = json['employment_start_date'];
    employmentEndDate = json['employment_end_date'];
    checkInDefault = json['check_in_default'];
    checkOutDefault = json['check_out_default'];
    checkOutRequred = json['check_out_requred'];
    payedDate = json['payed_date'];
    payDate = json['pay_date'];
    bankBranchName = json['bank_branch_name'];
    businessId = json['business_id'];
    departmentId = json['department_id'];
    salaryType = json['salary_type'];
    rate = json['rate'];
    payPeriod = json['pay_period'];
    workdaysPerWeek = json['workdays_per_week'];
    totalHoursPerWeek = json['total_hours_per_week'];
    extraHoursAtBaseRate = json['extra_hours_at_base_rate'];
    employeeType = json['employee_type'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    branchId = json['branch_id'];
    position = json['position'] != null
        ? new Position.fromJson(json['position'])
        : null;
    email = json['email'];
    phone = json['phone'];
    dateOfBirth = json['date_of_birth'];
    street = json['street'];
    city = json['city'];
    town = json['town'];
    postcode = json['postcode'];
    countryId = json['country_id'];
    tin = json['tin'];
    fnpf = json['fnpf'];
    bank = json['bank'];
    accountNumber = json['account_number'];
    licenceNo = json['licence_no'];
    licenceExpiryDate = json['licence_expiry_date'];
    passportNo = json['passport_no'];
    passportExpiryDate = json['passport_expiry_date'];
    image = json['image'];
    isFirst = json['isFirst'];
    otp = json['otp'];
    deviceId = json['device_id'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    forgotPassOtp = json['forgot_pass_otp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employer_id'] = this.employerId;
    data['job_title'] = this.jobTitle;
    data['employment_start_date'] = this.employmentStartDate;
    data['employment_end_date'] = this.employmentEndDate;
    data['check_in_default'] = this.checkInDefault;
    data['check_out_default'] = this.checkOutDefault;
    data['check_out_requred'] = this.checkOutRequred;
    data['payed_date'] = this.payedDate;
    data['pay_date'] = this.payDate;
    data['bank_branch_name'] = this.bankBranchName;
    data['business_id'] = this.businessId;
    data['department_id'] = this.departmentId;
    data['salary_type'] = this.salaryType;
    data['rate'] = this.rate;
    data['pay_period'] = this.payPeriod;
    data['workdays_per_week'] = this.workdaysPerWeek;
    data['total_hours_per_week'] = this.totalHoursPerWeek;
    data['extra_hours_at_base_rate'] = this.extraHoursAtBaseRate;
    data['employee_type'] = this.employeeType;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company'] = this.company;
    data['branch_id'] = this.branchId;
    if (this.position != null) {
      data['position'] = this.position!.toJson();
    }
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['date_of_birth'] = this.dateOfBirth;
    data['street'] = this.street;
    data['city'] = this.city;
    data['town'] = this.town;
    data['postcode'] = this.postcode;
    data['country_id'] = this.countryId;
    data['tin'] = this.tin;
    data['fnpf'] = this.fnpf;
    data['bank'] = this.bank;
    data['account_number'] = this.accountNumber;
    data['licence_no'] = this.licenceNo;
    data['licence_expiry_date'] = this.licenceExpiryDate;
    data['passport_no'] = this.passportNo;
    data['passport_expiry_date'] = this.passportExpiryDate;
    data['image'] = this.image;
    data['isFirst'] = this.isFirst;
    data['otp'] = this.otp;
    data['device_id'] = this.deviceId;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['forgot_pass_otp'] = this.forgotPassOtp;
    data['status'] = this.status;
    return data;
  }
}

class Position {
  int? id;
  int? employerId;
  String? roleName;

  Position({this.id, this.employerId, this.roleName});

  Position.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employerId = json['employer_id'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employer_id'] = this.employerId;
    data['role_name'] = this.roleName;
    return data;
  }
}
