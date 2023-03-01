// To parse this JSON data, do
//
//     final employeeListModel = employeeListModelFromJson(jsonString);

import 'dart:convert';

EmployeeListModel employeeListModelFromJson(String str) => EmployeeListModel.fromJson(json.decode(str));

String employeeListModelToJson(EmployeeListModel data) => json.encode(data.toJson());

class EmployeeListModel {
    EmployeeListModel({
        this.message = '',
        required this.employeeList,
    });

    String message;
    List<EmployeeList> employeeList;

    factory EmployeeListModel.fromJson(Map<String, dynamic> json) => EmployeeListModel(
        message: json["message"],
        employeeList: List<EmployeeList>.from(json["employee_list"].map((x) => EmployeeList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "employee_list": List<dynamic>.from(employeeList.map((x) => x.toJson())),
    };
}

class EmployeeList {
    EmployeeList({
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

    factory EmployeeList.fromJson(Map<String, dynamic> json) => EmployeeList(
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
        "date_of_birth": "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
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
