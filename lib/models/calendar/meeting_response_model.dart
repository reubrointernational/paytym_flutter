// To parse this JSON data, do
//
//     final meetingResponseModel = meetingResponseModelFromJson(jsonString);

import 'dart:convert';

MeetingResponseModel meetingResponseModelFromJson(String str) =>
    MeetingResponseModel.fromJson(json.decode(str));

String meetingResponseModelToJson(MeetingResponseModel data) =>
    json.encode(data.toJson());

class MeetingResponseModel {
  String? message;
  List<MeetingsList>? meetingsList;

  MeetingResponseModel({this.message, this.meetingsList});

  // MeetingResponseModel.fromJson(Map<String, dynamic> json) {
  //   message = json['message'];
  //   if (json['meetings_list'] != null) {
  //     print("meeting list not null");
  //     meetingsList = <MeetingsList>[];
  //     json['meetings_list'].forEach((v) {
  //       meetingsList!.add(MeetingsList.fromJson(v));
  //     });
  //
  //     print("meeting list not null1 : ${meetingsList?.length.toString()}");
  //   }
  // }

  factory MeetingResponseModel.fromJson(Map<String, dynamic> json) =>
      MeetingResponseModel(
        message: json["message"],
        meetingsList: json["meetings_list"] == null
            ? []
            : List<MeetingsList>.from(
                json["meetings_list"]!.map((x) => MeetingsList.fromJson(x))),
      );

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['message'] = message;
  //   if (meetingsList != null) {
  //     print("meetinglist:${meetingsList?.length.toString()}");
  //     data['meetings_list'] = meetingsList!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }

  Map<String, dynamic> toJson() => {
        "message": message,
        "meetings": meetingsList == null
            ? []
            : List<dynamic>.from(meetingsList!.map((x) => x.toJson()).toList()),
      };
}

class MeetingsList {
  int? id;
  int? meetingId;
  int? attendeeId;
  Meetings? meetings;

  MeetingsList({this.id, this.meetingId, this.attendeeId, this.meetings});

  MeetingsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meetingId = json['meeting_id'];
    attendeeId = json['attendee_id'];
    meetings =
        json['meetings'] != null ? Meetings.fromJson(json['meetings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['meeting_id'] = this.meetingId;
    data['attendee_id'] = this.attendeeId;
    if (this.meetings != null) {
      data['meetings'] = this.meetings!.toJson();
    }
    return data;
  }
}

class Meetings {
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

  Meetings(
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

  Meetings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    employerId = json['employer_id'];
    name = json['name'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    agenda = json['agenda'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    // meetingAttendeess = json["meetings_list"] == null
    //     ? []
    //     : List<MeetingAttendeess>.from(json["meeting_attendeess"]!
    //         .map((x) => MeetingAttendeess.fromJson(x)));
    if (json['meeting_attendeess'] != null) {
      meetingAttendeess = <MeetingAttendeess>[];
      json['meeting_attendeess'] != null
          ? json['meeting_attendeess'].forEach((v) {
              if (MeetingAttendeess.fromJson(v) != null) {
                meetingAttendeess!.add(MeetingAttendeess.fromJson(v));
              }
            })
          : null;
    }
    // meetingAttendeess = (json['meeting_attendeess'] != null
    //     ? MeetingAttendeess.fromJson(json['meeting_attendeess'])
    //     : null) as List<MeetingAttendeess>?;
    // if (json['meeting_attendeess'] != null) {
    //   meetingAttendeess = <MeetingAttendeess>[];
    //   json['meeting_attendeess'].forEach((v) {
    //     print("object:${v.toString()}");
    //     meetingAttendeess!.add(new MeetingAttendeess.fromJson(v));
    //   });
    // }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

    if (meetingAttendeess != null) {
      data['meeting_attendeess'] =
          meetingAttendeess!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
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

  MeetingAttendeess({
    this.id,
    this.employerId,
    this.jobTitle,
    this.firstName,
    this.lastName,
    this.image,
  });

  factory MeetingAttendeess.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Handle the case where json is null (or return a default value)
      return MeetingAttendeess();
    }

    return MeetingAttendeess(
      id: json['id'],
      employerId: json['employer_id'],
      jobTitle: json['job_title'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      image: json['image'],
    );
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
  int? position;
  String? email;
  String? phone;
  String? dateOfBirth;
  String? street;
  String? city;
  Null? town;
  String? postcode;
  String? countryId;
  String? tin;
  String? fnpf;
  String? bank;
  String? accountNumber;
  String? licenceNo;
  String? licenceExpiryDate;
  String? passportNo;
  String? passportExpiryDate;
  String? image;
  String? isFirst;
  String? otp;
  String? deviceId;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  Null? forgotPassOtp;
  int? status;
  Role? role;

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
      this.status,
      this.role});

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
    position = json['position'];
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
    licenceNo = json['account_number'];
    // licenceNo = json['licence_no'];
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
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
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
    data['position'] = this.position;
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
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}

class Role {
  int? id;
  int? employerId;
  String? roleName;

  Role({this.id, this.employerId, this.roleName});

  Role.fromJson(Map<String, dynamic> json) {
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
