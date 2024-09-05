
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tanachyomi/config/config.dart';
import 'package:tanachyomi/models/userinfomodel.dart';

class ProfileParser{

  static Future callApiForGetUser(String? url, String? body) async{
    print("GetUserUrl:$url");
    var response =
    await http.post(
      Uri.parse(url!),
      body: body,
      headers: Config.httppostheader,);
    final statusCode = response.statusCode;
    try {
      if (statusCode == 200) {
        print("success::"+statusCode.toString());
        if (response.body != null && response.body.isNotEmpty) {
          Map res = jsonDecode(response.body);
          Map data = res["data"];
          Map<String,dynamic> member = data["MemberInfo"];
          UserInfoModel info = UserInfoModel.fromJson(member);
          return {
            "errorCode": 0,
            "value": info,
          };
        } else {
          return {
            "errorCode":-1,
            "value": "body is null or empty",
          };
          // return Constants.resultInApi("body is null or empty", true);
        }
      } else if (statusCode == 429) {
        print("Re-Called"+statusCode.toString());
        ProfileParser.callApiForGetUser(url,body);
      } else {
        print("failure"+statusCode.toString());
        return {
          "errorCode":-1,
          "value": "Status Code Error:$statusCode",
        };
        // return Constants.resultInApi("Status Code Error:$statusCode", true);
      }
    } catch (e) {
      print("failure"+statusCode.toString());
      return {
        "errorCode":-1,
        "value": "Error:$e",
      };
      // return Constants.resultInApi("Error:$e", true);
    }
  }

  static Future callApiForUploadUser(String? url, String? body) async {
    print("UploadUserUrl:$url");
    var response =
    await http.post(
      Uri.parse(url!),
      body: body,
      headers: Config.httppostheader,);
    final statusCode = response.statusCode;
    try {
      if (statusCode == 200) {
        print("success::"+statusCode.toString());
        if (response.body != null && response.body.isNotEmpty) {
          Map res = jsonDecode(response.body);
          Map data = res["data"];
          Map<String,dynamic> member = data["MemberInfo"];
          UserInfoModel info = UserInfoModel.fromJson(member);
          return {
            "errorCode": 0,
            "value": info,
          };
        } else {
          return {
            "errorCode":-1,
            "value": "body is null or empty",
          };
          // return Constants.resultInApi("body is null or empty", true);
        }
      } else if (statusCode == 429) {
        print("Re-Called"+statusCode.toString());
        ProfileParser.callApiForGetUser(url,body);
      } else {
        print("failure"+statusCode.toString());
        return {
          "errorCode":-1,
          "value": "Status Code Error:$statusCode",
        };
        // return Constants.resultInApi("Status Code Error:$statusCode", true);
      }
    } catch (e) {
      print("failure"+statusCode.toString());
      return {
        "errorCode":-1,
        "value": "Error:$e",
      };
      // return Constants.resultInApi("Error:$e", true);
    }
  }

}