class CountryModel{
  String? name, code;
  
  CountryModel.fromJson(Map<String,dynamic> map){
    if(map.containsKey("country_code")){
      code = map["country_code"];
    }
    if(map.containsKey("country_name")){
      name = map["country_name"];
    }
  }
}