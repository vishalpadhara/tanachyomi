// To parse this JSON data, do
//
//     final RegisterationModel = RegisterationModelFromJson(jsonString);

import 'dart:convert';

RegisterationModel RegisterationModelFromJson(String str) =>
    RegisterationModel.fromJson(json.decode(str));

String RegisterationModelToJson(RegisterationModel data) =>
    json.encode(data.toJson());

class RegisterationModel {
  RegisterationModel({
    this.email,
    this.password,
    this.socialFacebookId,
    this.socialFacebookToken,
    this.socialLinkedInId,
    this.socialLinkedInToken,
    this.socialGmailId,
    this.name,
    this.phoneCountryCode,
    this.phoneNo,
  });

  String? email;
  String? password;
  String? socialFacebookId;
  String? socialFacebookToken;
  String? socialLinkedInId;
  String? socialLinkedInToken;
  String? socialGmailId;
  String? name;
  String? phoneCountryCode;
  String? phoneNo;

  factory RegisterationModel.fromJson(Map<String, dynamic> json) =>
      RegisterationModel(
        email: json["Email"],
        password: json["Password"],
        socialFacebookId: json["SocialFacebookId"],
        socialFacebookToken: json["SocialFacebookToken"],
        socialLinkedInId: json["SocialLinkedInId"],
        socialLinkedInToken: json["SocialLinkedInToken"],
        socialGmailId: json["SocialGmailId"],
        name: json["Name"],
        phoneCountryCode: json["PhoneCountryCode"],
        phoneNo: json["PhoneNo"],
      );

  Map<String, dynamic> toJson() => {
        "Email": email,
        "Password": password,
        "SocialFacebookId": socialFacebookId,
        "SocialFacebookToken": socialFacebookToken,
        "SocialLinkedInId": socialLinkedInId,
        "SocialLinkedInToken": socialLinkedInToken,
        "SocialGmailId": socialGmailId,
        "Name": name,
        "PhoneCountryCode": phoneCountryCode,
        "PhoneNo": phoneNo,
      };
}
