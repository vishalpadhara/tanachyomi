class ForgotPasswordModel{
  bool? isExist;
  int? memberId;
  String? OTP;
  
  ForgotPasswordModel.fromJson(Map<String,dynamic> map){
    if(map.containsKey("IsExists")){
      isExist = map["IsExists"];
    }
    if(map.containsKey("MembersId")){
      memberId = map["MembersId"];
    }
    if(map.containsKey("OneTimePassword")){
      OTP = map["OneTimePassword"];
    }
  }
}