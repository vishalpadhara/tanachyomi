import 'dart:convert';

class UserModel {
  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.profileImageUrl,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? profileImageUrl;

  static String addGoogleUserInfo(
      String userName, String email, String imageUrl, String name) {
    Map<String, dynamic> map = {
      'UId': userName,
      'Email': email,
      'ImageUrl': imageUrl,
      'Name': name
    };
    return json.encode(map);
  }

  static String addUserRegisterationInfo(
      String Name,
      String Email,
      String SocialFacebookId,
      String SocialFacebookToken,
      String SocialLinkedInId,
      String SocialLinkedInToken,
      String SocialGmailId,
      String SocialAppleId,
      String PhoneCountryCode,
      String country,
      String PhoneNo,
      String Password) {
    Map<String, dynamic> map = {
      'Email': Email,
      'Password': Password,
      'SocialFacebookId': SocialFacebookId,
      'SocialFacebookToken': SocialFacebookToken,
      'SocialLinkedInId': SocialLinkedInId,
      'SocialLinkedInToken': SocialLinkedInToken,
      'SocialGmailId': SocialGmailId,
      'SocialAppleId': SocialAppleId,
      'Name': Name,
      'Country': country,
      'PhoneCountryCode': PhoneCountryCode,
      'PhoneNo': PhoneNo,
    };
    return json.encode(map);
  }

  static String addUserUploadInfo(
      String id,
      String Name,
      String SocialFacebookId,
      String SocialFacebookToken,
      String SocialLinkedInId,
      String SocialLinkedInToken,
      String SocialGmailId,
      String SocialAppleId,
      String PhoneCountryCode,
      String PhoneNo,
      String country) {
    Map<String, dynamic> map = {
      // 'Email': Email,
      // 'Password': Password,
      'Id': id,
      'Name': Name,
      'SocialFacebookId': SocialFacebookId,
      'SocialFacebookToken': SocialFacebookToken,
      'SocialLinkedInId': SocialLinkedInId,
      'SocialLinkedInToken': SocialLinkedInToken,
      'SocialGmailId': SocialGmailId,
      'SocialAppleId': SocialAppleId,
      'PhoneCountryCode': PhoneCountryCode,
      'PhoneNo': PhoneNo,
      'Country': country
    };
    return json.encode(map);
  }

  static String addUserLoginInfo(
      String Email,
      String Password,
      String SocialFacebookId,
      String SocialFacebookToken,
      String SocialLinkedInId,
      String SocialLinkedInToken,
      String SocialGmailId,
      String SocialAppleId) {
    Map<String, dynamic> map = {
      'Email': Email,
      'SocialGmailId': SocialGmailId,
      'Password': Password,
      'SocialFacebookId': SocialFacebookId,
      'SocialFacebookToken': SocialFacebookToken,
      'SocialLinkedInId': SocialLinkedInId,
      'SocialLinkedInToken': SocialLinkedInToken,
      'SocialAppleId': SocialAppleId,
    };
    return json.encode(map);
  }

  static String addUserGetOtpInfo(String Email) {
    Map<String, dynamic> map = {
      'Email': Email,
    };
    return json.encode(map);
  }

  static String addUserValidateOtpInfo(String otp, String id) {
    Map<String, dynamic> map = {'Id': id, 'Otp': otp};
    return json.encode(map);
  }

  static String addUserResetPasswordInfo(String id, String password) {
    Map<String, dynamic> map = {'Id': id, 'Password': password};
    return json.encode(map);
  }

  static String getUserInfo(String id) {
    Map<String, dynamic> map = {
      'Id': id,
    };
    return json.encode(map);
  }

  static Map addUserUploadImageInfo(String id, String filepath) {
    Map<String, dynamic> map = {'Id': id, 'File': filepath};
    return map /*json.encode(map)*/;
  }

  //used in sub_list_of_library screen
  static String addBookChapterTitle(int bookid) {
    Map<String, dynamic> map = {
      'BooksId': bookid.toString(),
    };
    return json.encode(map);
  }

  //used in library screen
  static String addBookTitle(String name) {
    Map<String, dynamic> map = {
      'BookType': name,
    };
    return json.encode(map);
  }

  //Used in HomePage
  static String addCurrentDate(String date) {
    Map<String, dynamic> map = {'Date': date};
    return json.encode(map);
  }

  //Used in lyricsdemo
  static String addFileId(int fileid) {
    Map<String, dynamic> map = {
      'FilesId': fileid.toString(),
    };
    return json.encode(map);
  }

  //Used in lyricsdemo
  static String addBookChapterId(int bookid) {
    Map<String, dynamic> map = {
      'ChaptersId': bookid.toString(),
    };
    return json.encode(map);
  }

  //Used in setting screen
  static String addSaveSetting(
      String id,
      bool isDarkMode,
      String startDate,
      int bookid,
      int chaptersId,
      int cycleType,
      bool isNotify,
      String notifyTime) {
    Map<String, dynamic> map = {
      "Id": id.toString(),
      "SettingsIsDarkMode": isDarkMode,
      "SettingsStartDate": startDate.toString(),
      "SettingsBooksId": bookid,
      "SettingsChaptersId": chaptersId,
      "SettingsCycleType": cycleType, //7
      "SettingsIsNotification": isNotify,
      "SettingsNotificationTime": notifyTime.toString()
    };
    return json.encode(map);
  }
}
