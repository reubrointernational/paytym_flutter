// To parse this JSON data, do
//
//     final mPaisaPaymentModel = mPaisaPaymentModelFromJson(jsonString);

import 'dart:convert';

MPaisaPaymentModel mPaisaPaymentModelFromJson(String str) =>
    MPaisaPaymentModel.fromJson(json.decode(str));

String mPaisaPaymentModelToJson(MPaisaPaymentModel data) =>
    json.encode(data.toJson());

class MPaisaPaymentModel {
  MPaisaPaymentModel({
    this.destinationurl,
    this.requestId,
    this.response,
    this.token,
    this.tokenv2,
  });

  String? destinationurl;
  int? requestId;
  int? response;
  String? token;
  String? tokenv2;

  factory MPaisaPaymentModel.fromJson(Map<String, dynamic> json) =>
      MPaisaPaymentModel(
        destinationurl: json["destinationurl"],
        requestId: json["requestID"],
        response: json["response"],
        token: json["token"],
        tokenv2: json["tokenv2"],
      );

  Map<String, dynamic> toJson() => {
        "destinationurl": destinationurl,
        "requestID": requestId,
        "response": response,
        "token": token,
        "tokenv2": tokenv2,
      };
}
