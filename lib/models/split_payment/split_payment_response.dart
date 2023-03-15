import 'dart:convert';

SplitPaymentResponseModel splitPaymentResponseModelFromJson(String str) => SplitPaymentResponseModel.fromJson(json.decode(str));

String splitPaymentResponseModelToJson(SplitPaymentResponseModel data) => json.encode(data.toJson());

class SplitPaymentResponseModel {
    SplitPaymentResponseModel({
        this.message,
         this.splitpayment,
    });

    String? message;
    Splitpayment? splitpayment;

    factory SplitPaymentResponseModel.fromJson(Map<String, dynamic> json) => SplitPaymentResponseModel(
        message: json["message"],
        splitpayment: Splitpayment.fromJson(json["splitpayment"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "splitpayment": splitpayment!.toJson(),
    };
}

class Splitpayment {
    Splitpayment({
       this.employerId,
         this.employeeId,
         this.paymentWallet,
         this.amount,
         this.updatedAt,
         this.createdAt,
         this.id,
    });

    String? employerId;
    String? employeeId;
    String? paymentWallet;
    String? amount;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory Splitpayment.fromJson(Map<String, dynamic> json) => Splitpayment(
        employerId: json["employer_id"],
        employeeId: json["employee_id"],
        paymentWallet: json["payment_wallet"],
        amount: json["amount"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "employer_id": employerId,
        "employee_id": employeeId,
        "payment_wallet": paymentWallet,
        "amount": amount,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
    };
}