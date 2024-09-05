import 'dart:convert';

import 'package:tanachyomi/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:tanachyomi/models/registerationmodel.dart';
import 'package:tanachyomi/models/userinfomodel.dart';

class RegisterationParser {
  static Future callApiforRegister(String url, String body) async {
    print("RegisterationUrl:$url\n" + body);
    var response = await http.post(
      Uri.parse(url),
      body: body,
      headers: Config.httppostheader,
    );
    final statusCode = response.statusCode;
    try {
      if (statusCode == 200) {
        print("success" + statusCode.toString());
        if (response.body != null && response.body.isNotEmpty) {
          RegisterationModel? model;
          Map res = jsonDecode(response.body);
          Map data = res["data"];
          if (data.containsKey("MemberInfo")) {
            Map<String, dynamic> member = data["MemberInfo"];
            model = RegisterationModel.fromJson(member);
          }
          String? message;
          if (res.containsKey("info")) {
            message = res["info"];
          }
          return {
            "errorCode": 0,
            "value": [message, model],
            // "value": message,
          };
        } else {
          return {
            "errorCode": -1,
            "value": "body is null or empty",
          };
          // return Constants.resultInApi("body is null or empty", true);
        }
      } else if (statusCode == 429) {
        print("Re-Called" + statusCode.toString());
        RegisterationParser.callApiforRegister(url, body);
      } else {
        print("failure" + statusCode.toString());
        return {
          "errorCode": -1,
          "value": "Status Code Error:$statusCode",
        };
        // return Constants.resultInApi("Status Code Error:$statusCode", true);
      }
    } catch (e) {
      print("failure" + statusCode.toString());
      return {
        "errorCode": -1,
        "value": "Error:$e",
      };
      // return Constants.resultInApi("Error:$e", true);
    }
  }

  static Future callApiforUploadImage(String url, String body, int id) async {
    print("RegisterationUploadImageUrl:$url\n" + body.toString());

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers["Authorization"] =
        "Bearer 14FE34B2-9547-43F5-A57C-F0DC7DE81AA9";
    request.headers["Content-Type"] = "multipart/form-data";
    request.fields["Id"] = id.toString();
    request.files.add(await http.MultipartFile.fromPath("File", body,
        filename: "test.${body.split("/").last}"));

    http.Response response =
        await http.Response.fromStream(await request.send());

    final statusCode = response.statusCode;
    try {
      if (statusCode == 200) {
        print("success" + statusCode.toString());
        if (response.body != null && response.body.isNotEmpty) {
          UserInfoModel? model;
          Map res = jsonDecode(response.body);
          Map data = res["data"];
          print("FILEIMAGEDATA" + data.toString());
          if (data.containsKey("FileInfo")) {
            Map<String, dynamic> member = data["FileInfo"];
            model = UserInfoModel.fromImageUploadJson(member);
            print("GUID::" + model.guid!);
          }
          String? message;
          if (res.containsKey("info")) {
            message = res["info"];
          }
          return {
            "errorCode": 0,
            "value": [message, model],
          };
        } else {
          return {
            "errorCode": -1,
            "value": "body is null or empty",
          };
          // return Constants.resultInApi("body is null or empty", true);
        }
      } else if (statusCode == 429) {
        print("Re-Called" + statusCode.toString());
        // RegisterationParser.callApiforUploadImage(url,body);
      } else {
        print("failure" + statusCode.toString());
        return {
          "errorCode": -1,
          "value": "Status Code Error:$statusCode",
        };
        // return Constants.resultInApi("Status Code Error:$statusCode", true);
      }
    } catch (e) {
      print("failure" + statusCode.toString());
      return {
        "errorCode": -1,
        "value": "Error:$e",
      };
      // return Constants.resultInApi("Error:$e", true);
    }
  }
}
