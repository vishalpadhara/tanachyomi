// To parse this JSON data, do
//
//     final memberInfoModel = memberInfoModelFromJson(jsonString);

import 'dart:convert';

MemberInfoModel memberInfoModelFromJson(String str) =>
    MemberInfoModel.fromJson(json.decode(str));

String memberInfoModelToJson(MemberInfoModel data) =>
    json.encode(data.toJson());

class MemberInfoModel {
  MemberInfoModel({
    required this.id,
    required this.isDeleted,
    required this.changedOn,
    required this.tokensIdChangedBy,
    required this.name,
    required this.phoneCountryCode,
    required this.phoneNo,
    required this.country,
    required this.email,
    required this.password,
    required this.filesIdAvatar,
    required this.isSocialFacebook,
    required this.socialFacebookId,
    required this.socialFacebookToken,
    required this.isSocialLinkedIn,
    required this.socialLinkedInId,
    required this.socialLinkedInToken,
    required this.isSocialGmail,
    required this.socialGmailId,
    required this.accessToken,
    required this.isActive,
    required this.filesAvatar,
    required this.settingsIsDarkMode,
    required this.settingsStartDate,
    required this.settingsBooksId,
    required this.settingsChaptersId,
    required this.settingsCycleType,
    required this.settingsIsNotification,
    required this.settingsNotificationTime,
    required this.settingsFontSizeEnglish,
    required this.settingsFontSizeHebrew,
  });

  int id;
  bool isDeleted;
  String changedOn;
  int tokensIdChangedBy;
  String name;
  String phoneCountryCode;
  String phoneNo;
  String country;
  String email;
  String password;
  int filesIdAvatar;
  int isSocialFacebook;
  String socialFacebookId;
  String socialFacebookToken;
  int isSocialLinkedIn;
  String socialLinkedInId;
  String socialLinkedInToken;
  int isSocialGmail;
  String socialGmailId;
  String accessToken;
  bool isActive;
  String filesAvatar;
  bool settingsIsDarkMode;
  String settingsStartDate;
  int settingsBooksId;
  int settingsChaptersId;
  int settingsCycleType;
  bool settingsIsNotification;
  String settingsNotificationTime;
  int settingsFontSizeEnglish;
  int settingsFontSizeHebrew;

  factory MemberInfoModel.fromJson(Map<String, dynamic> json) =>
      MemberInfoModel(
        id: json["Id"],
        isDeleted: json["IsDeleted"],
        changedOn: json["ChangedOn"],
        tokensIdChangedBy: json["TokensId_ChangedBy"],
        name: json["Name"],
        phoneCountryCode: json["PhoneCountryCode"],
        phoneNo: json["PhoneNo"],
        country: json["Country"],
        email: json["Email"],
        password: json["Password"],
        filesIdAvatar: json["FilesId_Avatar"],
        isSocialFacebook: json["IsSocialFacebook"],
        socialFacebookId: json["SocialFacebookId"],
        socialFacebookToken: json["SocialFacebookToken"],
        isSocialLinkedIn: json["IsSocialLinkedIn"],
        socialLinkedInId: json["SocialLinkedInId"],
        socialLinkedInToken: json["SocialLinkedInToken"],
        isSocialGmail: json["IsSocialGmail"],
        socialGmailId: json["SocialGmailId"],
        accessToken: json["AccessToken"],
        isActive: json["IsActive"],
        filesAvatar: json["FilesAvatar"],
        settingsIsDarkMode: json["SettingsIsDarkMode"],
        settingsStartDate: json["SettingsStartDate"],
        settingsBooksId: json["SettingsBooksId"],
        settingsChaptersId: json["SettingsChaptersId"],
        settingsCycleType: json["SettingsCycleType"],
        settingsIsNotification: json["SettingsIsNotification"],
        settingsNotificationTime: json["SettingsNotificationTime"],
        settingsFontSizeEnglish: json["SettingsFontSizeEnglish"],
        settingsFontSizeHebrew: json["SettingsFontSizeHebrew"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "IsDeleted": isDeleted,
        "ChangedOn": changedOn,
        "TokensId_ChangedBy": tokensIdChangedBy,
        "Name": name,
        "PhoneCountryCode": phoneCountryCode,
        "PhoneNo": phoneNo,
        "Country": country,
        "Email": email,
        "Password": password,
        "FilesId_Avatar": filesIdAvatar,
        "IsSocialFacebook": isSocialFacebook,
        "SocialFacebookId": socialFacebookId,
        "SocialFacebookToken": socialFacebookToken,
        "IsSocialLinkedIn": isSocialLinkedIn,
        "SocialLinkedInId": socialLinkedInId,
        "SocialLinkedInToken": socialLinkedInToken,
        "IsSocialGmail": isSocialGmail,
        "SocialGmailId": socialGmailId,
        "AccessToken": accessToken,
        "IsActive": isActive,
        "FilesAvatar": filesAvatar,
        "SettingsIsDarkMode": settingsIsDarkMode,
        "SettingsStartDate": settingsStartDate,
        "SettingsBooksId": settingsBooksId,
        "SettingsChaptersId": settingsChaptersId,
        "SettingsCycleType": settingsCycleType,
        "SettingsIsNotification": settingsIsNotification,
        "SettingsNotificationTime": settingsNotificationTime,
        "SettingsFontSizeEnglish": settingsFontSizeEnglish,
        "SettingsFontSizeHebrew": settingsFontSizeHebrew,
      };
}
