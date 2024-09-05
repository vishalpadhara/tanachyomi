import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tanachyomi/config/config.dart';
import 'package:tanachyomi/models/forgorpasswordmodel.dart';
class ForgotPasswordParser{

  static Future callApi(String? url, String? strJson) async {
    print("ForgotPasswordUrl:$url");
    var response =
    await http.post(
      Uri.parse(url!),
      body: strJson,
      headers: Config.httppostheader);
    final statusCode = response.statusCode;

    try {
      if (statusCode == 200) {
        print("success::"+statusCode.toString());
        if (response.body != null && response.body.isNotEmpty) {
          Map res = jsonDecode(response.body);
          Map data = res["data"];
          Map<String,dynamic> otpdata = data["OneTimePass"];
          ForgotPasswordModel otpgetdata = ForgotPasswordModel.fromJson(otpdata);
          return {
            "errorCode": 0,
            "value": otpgetdata,
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
        ForgotPasswordParser.callApi(url,strJson);
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

  static Future callApiForValidateOtp(String? url, String? strJson) async {
    print("ForgotPasswordUrl:$url");
    var response =
    await http.post(
      Uri.parse(url!),
      body: strJson,
      headers: Config.httppostheader);
    final statusCode = response.statusCode;

    try {
      if (statusCode == 200) {
        print("success::"+statusCode.toString());
        if (response.body != null && response.body.isNotEmpty) {
          Map res = jsonDecode(response.body);
          Map data = res["data"];
          String? valid = data["OtpValid"];
          return {
            "errorCode": 0,
            "value": valid,
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
        ForgotPasswordParser.callApi(url,strJson);
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

  static Future callApiForResetPassword(String? url, String? strJson) async {
    print("ForgotPasswordUrl:$url");
    var response =
    await http.post(
      Uri.parse(url!),
      body: strJson,
      headers: Config.httppostheader);
    final statusCode = response.statusCode;

    try {
      if (statusCode == 200) {
        print("success::"+statusCode.toString());
        if (response.body != null && response.body.isNotEmpty) {
          Map res = jsonDecode(response.body);
          // Map data = res["data"];
          String? valid = res["info"];
          return {
            "errorCode": 0,
            "value": valid,
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
        ForgotPasswordParser.callApi(url,strJson);
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