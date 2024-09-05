class LoginModel{
  int? errcode;
  String? message;
  int? id;
  
  LoginModel.fromJson(Map<String,dynamic> map){
    if(map.containsKey("HttpErrorCode")){
      errcode = map["HttpErrorCode"];
    }
    if(map.containsKey("HttpErrorMessage")){
      message = map["HttpErrorMessage"];
    }
    if(map.containsKey("Id")){
      id = map["Id"];
    }
  }
}