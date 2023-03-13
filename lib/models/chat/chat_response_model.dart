// To parse this JSON data, do
//
//     final chatResponseModel = chatResponseModelFromJson(jsonString);

import 'dart:convert';

ChatResponseModel chatResponseModelFromJson(String str) =>
    ChatResponseModel.fromJson(json.decode(str));

String chatResponseModelToJson(ChatResponseModel data) =>
    json.encode(data.toJson());

class ChatResponseModel {
  ChatResponseModel({
    this.message,
     this.chats,
     this.hod,
     this.hodImage,
     this.chatHistory,
  });

  String? message;
  List<Chat>? chats;
  String? hod;
  String? hodImage;
  List<Chat>? chatHistory;

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) =>
      ChatResponseModel(
        message: json["message"],
        chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
        hod: json["hod"]!,
        hodImage: json["hod_image"] ?? '',
        chatHistory:
            List<Chat>.from(json["chat_history"].map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "chats": List<dynamic>.from(chats!.map((x) => x.toJson())),
        "hod": hod,
        "hod_image": hodImage,
        "chat_history": List<dynamic>.from(chatHistory!.map((x) => x.toJson())),
      };
}

class Chat {
  Chat({
   this.id,
     this.userId,
     this.employerId,
    this.groupChatId,
     this.message,
    this.createdAt,
   this.updatedAt,
    this.employer,
    this.employee,
  });

  int? id;
  int? userId;
  int? employerId;
  dynamic groupChatId;
  String? message;
  String? createdAt;
  String? updatedAt;
  Employer? employer;
  Employee? employee;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        userId: json["user_id"],
        employerId: json["employer_id"],
        groupChatId: json["group_chat_id"],
        message: json["message"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        employer: json["employer"] == null
            ? null
            : Employer.fromJson(json["employer"]),
        employee: json["employee"] == null
            ? null
            : Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employer_id": employerId,
        "group_chat_id": groupChatId,
        "message": message,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "employer": employer?.toJson(),
        "employee": employee?.toJson(),
      };
}

class Employee {
  Employee({
     this.id,
     this.firstName,
  this.lastName,
  });

  int? id;
  String? firstName;
  String? lastName;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        firstName: json["first_name"]!,
        lastName: json["last_name"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
      };
}

class Employer {
  Employer({
     this.id,
    this.company,
     this.userType,
     this.name,
    this.email,
    this.companyPhone,
    this.phone,
   this.street,
     this.city,
     this.town,
   this.postcode,
     this.countryId,
     this.tin,
     this.website,
     this.registrationCertificate,
     this.tinLetter,
     this.logo,
    this.otp,
    this.fcmToken,
     this.status,
    this.createdAt,
     this.updatedAt,
  });

  int? id;
  String? company;
  String? userType;
  String? name;
  String? email;
  String? companyPhone;
  String? phone;
  String? street;
  String? city;
  String? town;
  String? postcode;
  int? countryId;
  String? tin;
  String? website;
  String? registrationCertificate;
  String? tinLetter;
  String? logo;
  String? otp;
  String? fcmToken;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
        id: json["id"],
        company: json["company"]!,
        userType: json["user_type"]!,
        name: json["name"]!,
        email: json["email"]!,
        companyPhone: json["company_phone"],
        phone: json["phone"],
        street: json["street"]!,
        city: json["city"]!,
        town: json["town"]!,
        postcode: json["postcode"],
        countryId: json["country_id"],
        tin: json["tin"]!,
        website: json["website"]!,
        registrationCertificate: json["registration_certificate"]!,
        tinLetter: json["tin_letter"]!,
        logo: json["logo"]!,
        otp: json["otp"],
        fcmToken: json["fcm_token"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company": company,
        "user_type": userType,
        "name": name,
        "email": email,
        "company_phone": companyPhone,
        "phone": phone,
        "street": street,
        "city": city,
        "town": town,
        "postcode": postcode,
        "country_id": countryId,
        "tin": tin,
        "website": website,
        "registration_certificate": registrationCertificate,
        "tin_letter": tinLetter,
        "logo": logo,
        "fcm_token": fcmToken,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}



/*import 'dart:convert';

ChatResponseModel chatResponseModelFromJson(String str) =>
    ChatResponseModel.fromJson(json.decode(str));

String chatResponseModelToJson(ChatResponseModel data) =>
    json.encode(data.toJson());

class ChatResponseModel {
  ChatResponseModel({
    this.message,
    this.chats,
    this.hod,
    
    this.chatHistory,
  });

  String? message;
  List<Chat>? chats;
  String? hod;
  
  List<Chat>? chatHistory;

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) =>
      ChatResponseModel(
        message: json["message"],
        chats: json["chats"] != null
            ? List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x)))
            : null,
        hod: json["hod"],
        
        chatHistory: json["chat_history"] != null
            ? List<Chat>.from(json["chat_history"].map((x) => Chat.fromJson(x)))
            : null,
      );
  Map<String, dynamic> toJson() => {
        "message": message,
        "chats": List<dynamic>.from(chats!.map((x) => x.toJson())),
        "hod": hod,
        
        "chat_history": List<dynamic>.from(chatHistory!.map((x) => x.toJson())),
      };
}

class Chat {
  Chat({
    this.id,
    this.userId,
    this.employerId,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.employer,
  });

  int? id;
  int? userId;
  int? employerId;
  String? message;
  String? createdAt;
  String? updatedAt;
  Employer? employer;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        userId: json["user_id"],
        employerId: json["employer_id"],
        message: json["message"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        employer: json["employer"] == null
            ? null
            : Employer.fromJson(json["employer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employer_id": employerId,
        "message": message,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "employer": employer?.toJson(),
      };
}

class Employer {
  Employer({
    this.id,
    this.company,
    this.userType,
    this.name,
    this.email,
    this.companyPhone,
    this.phone,
    this.street,
    this.city,
    this.town,
    this.postcode,
    this.country,
    this.tin,
    this.website,
    this.registrationCertificate,
    this.tinLetter,
    this.logo,
    this.fcmToken,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? company;
  String? userType;
  String? name;
  String? email;
  String? companyPhone;
  String? phone;
  String? street;
  String? city;
  String? town;
  String? postcode;
  String? country;
  String? tin;
  String? website;
  String? registrationCertificate;
  String? tinLetter;
  String? logo;
  String? fcmToken;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
        id: json["id"],
        company: json["company"],
        userType: json["user_type"],
        name: json["name"],
        email: json["email"],
        companyPhone: json["company_phone"],
        phone: json["phone"],
        street: json["street"],
        city: json["city"],
        town: json["town"],
        postcode: json["postcode"],
        country: json["country"],
        tin: json["tin"],
        website: json["website"],
        registrationCertificate: json["registration_certificate"],
        tinLetter: json["tin_letter"],
        logo: json["logo"],
        fcmToken: json["fcm_token"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company": company,
        "user_type": userType,
        "name": name,
        "email": email,
        "company_phone": companyPhone,
        "phone": phone,
        "street": street,
        "city": city,
        "town": town,
        "postcode": postcode,
        "country": country,
        "tin": tin,
        "website": website,
        "registration_certificate": registrationCertificate,
        "tin_letter": tinLetter,
        "logo": logo,
        "fcm_token": fcmToken,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}*/
