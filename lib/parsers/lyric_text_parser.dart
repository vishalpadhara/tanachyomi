import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tanachyomi/config/config.dart';
import 'package:tanachyomi/models/lyrictextModel.dart';

class LyricTextParser{
  static Future callApiForLyricText(String? url) async{
    print("GetUserUrl:$url");
    var response =
    await http.get(
      Uri.parse(url!),
      );
    final statusCode = response.statusCode;
    try {
      if (statusCode == 200) {
        print("success::"+statusCode.toString());
        if (response.body != null && response.body.isNotEmpty) {
          Map<String,dynamic> res = jsonDecode(response.body);
          print("LyricText::"+res.toString());
          LyricTextModel text = LyricTextModel.fromJson(res);
          print("LyricText2::"+text.engtext![0].toString());
          return {
            "errorCode": 0,
            "value": text,
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
        LyricTextParser.callApiForLyricText(url);
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

  static Future callApiForLyricContent(String? url,String? body) async{
    print("GetLyricsUrl:$url\n"+body.toString());
    var response = await http.post(
        Uri.parse(url!),
        body: body,
        headers: Config.httppostheader);
    final statusCode = response.statusCode;
    try {
      if (statusCode == 200) {
        print("success::"+statusCode.toString());
        if (response.body != null && response.body.isNotEmpty) {
          List<LyricTextModel> text = <LyricTextModel>[];
          Map res = jsonDecode(response.body);
          Map<String, dynamic> data = res["data"];
          LyricTextModel model = LyricTextModel.fromJsonDetails(data);
          //List versesinfo = data["Verses"];
          // print("VersesInfo::"+versesinfo.length.toString());
          //text = versesinfo.map((e) => LyricTextModel.fromContentJson(e)).toList();
          return {
            "errorCode": 0,
            "value": model,
          };
        } else {
          return {
            "errorCode":-1,
            "value": "body is null or empty",
          };
        }
      } else if (statusCode == 429) {
        print("Re-Called"+statusCode.toString());
        LyricTextParser.callApiForLyricText(url);
      } else {
        print("failure"+statusCode.toString());
        return {
          "errorCode":-1,
          "value": "Status Code Error:$statusCode",
        };
      }
    } catch (e) {
      print("failure"+statusCode.toString());
      return {
        "errorCode":-1,
        "value": "Error:$e",
      };
    }
  }

  static Future callApiForGetAudio(String? url,String? body) async{
    print("GetAudioUrl:$url\n"+body.toString());
    var response = await http.post(
        Uri.parse(url!),
        body: body,
        headers: Config.httppostheader);
    final statusCode = response.statusCode;
    try {
      if (statusCode == 200) {
        print("success::"+statusCode.toString());
        if (response.body != null && response.body.isNotEmpty) {
          List<LyricTextModel> file = <LyricTextModel>[];
          Map res = jsonDecode(response.body);
          Map data = res["data"];
          List versesinfo = data["FileInfo"];
          // print("VersesInfo::"+versesinfo.length.toString());
          file = versesinfo.map((e) => LyricTextModel.fromAudioJson(e)).toList();
          return {
            "errorCode": 0,
            "value": file,
          };
        } else {
          return {
            "errorCode":-1,
            "value": "body is null or empty",
          };
        }
      } else if (statusCode == 429) {
        print("Re-Called"+statusCode.toString());
        LyricTextParser.callApiForLyricText(url);
      } else {
        print("failure"+statusCode.toString());
        return {
          "errorCode":-1,
          "value": "Status Code Error:$statusCode",
        };
      }
    } catch (e) {
      print("failure"+statusCode.toString());
      return {
        "errorCode":-1,
        "value": "Error:$e",
      };
    }
  }
}