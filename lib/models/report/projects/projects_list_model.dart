// To parse this JSON data, do
//
//     final projectListModel = projectListModelFromJson(jsonString);

import 'dart:convert';

ProjectListModel projectListModelFromJson(String str) =>
    ProjectListModel.fromJson(json.decode(str));

String projectListModelToJson(ProjectListModel data) =>
    json.encode(data.toJson());

class ProjectListModel {
  String? message;
  List<ProjectsList>? projectsLists;
  List<TotalCost>? totalCost;

  ProjectListModel({
    this.message,
    this.projectsLists,
    this.totalCost,
  });

  factory ProjectListModel.fromJson(Map<String, dynamic> json) =>
      ProjectListModel(
        message: json["message"],
        projectsLists: json["projects lists"] == null
            ? []
            : List<ProjectsList>.from(
                json["projects lists"]!.map((x) => ProjectsList.fromJson(x))),
        totalCost: json["total cost"] == null
            ? []
            : List<TotalCost>.from(
                json["total cost"]!.map((x) => TotalCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "projects lists": projectsLists == null
            ? []
            : List<dynamic>.from(projectsLists!.map((x) => x.toJson())),
        "total cost": totalCost == null
            ? []
            : List<dynamic>.from(totalCost!.map((x) => x.toJson())),
      };
}

class ProjectsList {
  int? id;
  int? employerId;
  int? branchId;
  int? businessId;
  DateTime? startDate;
  DateTime? endDate;
  String? name;
  String? description;
  int? budget;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Branch? branch;
  List<ProjectsListEmployeeproject>? employeeproject;

  ProjectsList({
    this.id,
    this.employerId,
    this.branchId,
    this.businessId,
    this.startDate,
    this.endDate,
    this.name,
    this.description,
    this.budget,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.branch,
    this.employeeproject,
  });

  factory ProjectsList.fromJson(Map<String, dynamic> json) => ProjectsList(
        id: json["id"],
        employerId: json["employer_id"],
        branchId: json["branch_id"],
        businessId: json["business_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        name: json["name"],
        description: json["description"],
        budget: json["budget"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        employeeproject: json["employeeproject"] == null
            ? []
            : List<ProjectsListEmployeeproject>.from(json["employeeproject"]!
                .map((x) => ProjectsListEmployeeproject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "branch_id": branchId,
        "business_id": businessId,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "name": name,
        "description": description,
        "budget": budget,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "branch": branch?.toJson(),
        "employeeproject": employeeproject == null
            ? []
            : List<dynamic>.from(employeeproject!.map((x) => x.toJson())),
      };
}

class Branch {
  int? id;
  String? name;

  Branch({
    this.id,
    this.name,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}




class ProjectsListEmployeeproject {
  int? id;
  int? employerId;
  int? employeeId;
  int? projectId;
  PurpleUser? user;

  ProjectsListEmployeeproject({
    this.id,
    this.employerId,
    this.employeeId,
    this.projectId,
    this.user,
  });

  factory ProjectsListEmployeeproject.fromJson(Map<String, dynamic> json) =>
      ProjectsListEmployeeproject(
        id: json["id"],
        employerId: json["employer_id"],
        employeeId: json["employee_id"],
        projectId: json["project_id"],
        user: json["user"] == null ? null : PurpleUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "employee_id": employeeId,
        "project_id": projectId,
        "user": user?.toJson(),
      };
}

class PurpleUser {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  int? branchId;
  Branch? branch;

  PurpleUser({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
    this.branchId,
    this.branch,
  });

  factory PurpleUser.fromJson(Map<String, dynamic> json) => PurpleUser(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        branchId: json["branch_id"],
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "branch_id": branchId,
        "branch": branch?.toJson(),
      };
}

class TotalCost {
  int? id;
  int? employerId;
  int? branchId;
  int? businessId;
  DateTime? startDate;
  DateTime? endDate;
  String? name;
  String? description;
  int? budget;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Branch? branch;
  List<TotalCostEmployeeproject>? employeeproject;

  TotalCost({
    this.id,
    this.employerId,
    this.branchId,
    this.businessId,
    this.startDate,
    this.endDate,
    this.name,
    this.description,
    this.budget,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.branch,
    this.employeeproject,
  });

  factory TotalCost.fromJson(Map<String, dynamic> json) => TotalCost(
        id: json["id"],
        employerId: json["employer_id"],
        branchId: json["branch_id"],
        businessId: json["business_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        name: json["name"],
        description: json["description"],
        budget: json["budget"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        employeeproject: json["employeeproject"] == null
            ? []
            : List<TotalCostEmployeeproject>.from(json["employeeproject"]!
                .map((x) => TotalCostEmployeeproject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "branch_id": branchId,
        "business_id": businessId,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "name": name,
        "description": description,
        "budget": budget,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "branch": branch?.toJson(),
        "employeeproject": employeeproject == null
            ? []
            : List<dynamic>.from(employeeproject!.map((x) => x.toJson())),
      };
}

class TotalCostEmployeeproject {
  int? id;
  int? employerId;
  int? employeeId;
  int? projectId;
  FluffyUser? user;

  TotalCostEmployeeproject({
    this.id,
    this.employerId,
    this.employeeId,
    this.projectId,
    this.user,
  });

  factory TotalCostEmployeeproject.fromJson(Map<String, dynamic> json) =>
      TotalCostEmployeeproject(
        id: json["id"],
        employerId: json["employer_id"],
        employeeId: json["employee_id"],
        projectId: json["project_id"],
        user: json["user"] == null ? null : FluffyUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "employee_id": employeeId,
        "project_id": projectId,
        "user": user?.toJson(),
      };
}

class FluffyUser {
  int? id;
  int? employerId;
  String? jobTitle;
  DateTime? employmentStartDate;
  DateTime? employmentEndDate;
  dynamic checkInDefault;
  dynamic checkOutDefault;
  String? checkOutRequred;
  DateTime? payedDate;
  DateTime? payDate;
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
  String? countryId;
  String? tin;
  String? fnpf;
  String? bank;
  String? accountNumber;
  String? image;
  String? isFirst;
  String? otp;
  String? deviceId;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic forgotPassOtp;
  int? status;
  Branch? branch;

  FluffyUser({
    this.id,
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
    this.image,
    this.isFirst,
    this.otp,
    this.deviceId,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.forgotPassOtp,
    this.status,
    this.branch,
  });

  factory FluffyUser.fromJson(Map<String, dynamic> json) => FluffyUser(
        id: json["id"],
        employerId: json["employer_id"],
        jobTitle: json["job_title"],
        employmentStartDate: json["employment_start_date"] == null
            ? null
            : DateTime.parse(json["employment_start_date"]),
        employmentEndDate: json["employment_end_date"] == null
            ? null
            : DateTime.parse(json["employment_end_date"]),
        checkInDefault: json["check_in_default"],
        checkOutDefault: json["check_out_default"],
        checkOutRequred: json["check_out_requred"],
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
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        forgotPassOtp: json["forgot_pass_otp"],
        status: json["status"],
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "job_title": jobTitle,
        "employment_start_date":
            "${employmentStartDate!.year.toString().padLeft(4, '0')}-${employmentStartDate!.month.toString().padLeft(2, '0')}-${employmentStartDate!.day.toString().padLeft(2, '0')}",
        "employment_end_date":
            "${employmentEndDate!.year.toString().padLeft(4, '0')}-${employmentEndDate!.month.toString().padLeft(2, '0')}-${employmentEndDate!.day.toString().padLeft(2, '0')}",
        "check_in_default": checkInDefault,
        "check_out_default": checkOutDefault,
        "check_out_requred": checkOutRequred,
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
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "forgot_pass_otp": forgotPassOtp,
        "status": status,
        "branch": branch?.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
