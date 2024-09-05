class UserInfoModel{
  String? name;
  String? phoneno;
  String? email;
  String? country;
  String? guid;
  String? imageguid;
  int? isfacebook;
  int? islinkedin;
  String? countrycode;
  int? isgmail;

  UserInfoModel.fromJson(Map<String,dynamic> map){
    if(map.containsKey("Name")){
      name = map["Name"];
    }
    if(map.containsKey("Email")){
      email = map["Email"];
    }
    if(map.containsKey("Country")){
      country = map["Country"];
    }
    if(map.containsKey("PhoneNo")){
      phoneno = map["PhoneNo"];
    }
    if(map.containsKey("PhoneCountryCode")){
      countrycode = map["PhoneCountryCode"];
    }
    if(map.containsKey("FilesAvatar")){
      imageguid = map["FilesAvatar"];
    }
    if(map.containsKey("IsSocialFacebook")){
      isfacebook = map["IsSocialFacebook"];
    }
    if(map.containsKey("IsSocialLinkedIn")){
      islinkedin = map["IsSocialLinkedIn"];
    }
    if(map.containsKey("IsSocialGmail")){
      isgmail = map["IsSocialGmail"];
    }
  }

  UserInfoModel.fromImageUploadJson(Map<String,dynamic> map){
    if(map.containsKey("FileUrl")){
      guid = map["FileUrl"];
    }
  }
  
}