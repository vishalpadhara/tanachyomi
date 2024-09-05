import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';
import 'api_config.dart';

class SimpleHttpParser {
  bool AS = false;

  static bool isRequestLogEnabled = false;
  static Future callPostRawForFullUrl(
      {required var strJson, required String url}) async {
    if (isRequestLogEnabled) {
      Constants.debugLog(SimpleHttpParser, "strJson:$strJson");
    }
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: ApiConfig.httpAuthorizationHeader,
        body: strJson,
      );
      final statusCode = response.statusCode;

      if (statusCode == 200) {
        if (isRequestLogEnabled) {
          Constants.debugLog(
              SimpleHttpParser, "callPostRawApi:JsonData:${response.body}");
          print(response.body);
        }
        return Constants.resultInApi(response.body, false);
      } else if (statusCode == 429) {
        if (isRequestLogEnabled) {
          Constants.debugLog(
              SimpleHttpParser, "callPostRawApi:Status Code Error:$statusCode");
        }

        //SimpleHttpParser.callPostRawApi(url: url, strJson: strJson);
      } else if (statusCode == 401) {
        Fluttertoast.showToast(
            msg: "Unsuccessful", toastLength: Toast.LENGTH_SHORT);
      } else {
        if (isRequestLogEnabled) {
          Constants.debugLog(
              SimpleHttpParser, "callPostRawApi:Status Code Error:$statusCode");
        }
        return Constants.resultInApi("", true);
      }
    } on SocketException {
      if (isRequestLogEnabled) {
        Constants.debugLog(SimpleHttpParser,
            "callPostRawApi:You are not connected to internet ☹");
      }
      return Constants.resultInApi("You are not connected to internet ☹", true);
    } on TimeoutException {
      if (isRequestLogEnabled) {
        Constants.debugLog(SimpleHttpParser, "callPostRawApi:Time out");
      }
      return Constants.resultInApi(
          "The Internet connection has timed out, Please try again.", true);
    } catch (e) {
      if (isRequestLogEnabled) {
        Constants.debugLog(SimpleHttpParser, "Catch Error:$e");
      }
      return Constants.resultInApi("", true);
    }
  }

  static Future callPostRawApi({required var strJson}) async {
    if (isRequestLogEnabled) {
      Constants.debugLog(SimpleHttpParser, "strJson:$strJson");
    }
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.newServerBaseURL!),
        headers: ApiConfig.httpAuthorizationHeader,
        body: strJson,
      );
      final statusCode = response.statusCode;

      if (statusCode == 200) {
        if (isRequestLogEnabled) {
          Constants.debugLog(
              SimpleHttpParser, "callPostRawApi:JsonData:${response.body}");
          print(response.body);
        }
        return Constants.resultInApi(response.body, false);
      } else if (statusCode == 429) {
        if (isRequestLogEnabled) {
          Constants.debugLog(
              SimpleHttpParser, "callPostRawApi:Status Code Error:$statusCode");
        }

        //SimpleHttpParser.callPostRawApi(url: url, strJson: strJson);
      } else if (statusCode == 401) {
        Fluttertoast.showToast(
            msg: "Unsuccessful", toastLength: Toast.LENGTH_SHORT);
      } else {
        if (isRequestLogEnabled) {
          Constants.debugLog(
              SimpleHttpParser, "callPostRawApi:Status Code Error:$statusCode");
        }
        return Constants.resultInApi("", true);
      }
    } on SocketException {
      if (isRequestLogEnabled) {
        Constants.debugLog(SimpleHttpParser,
            "callPostRawApi:You are not connected to internet ☹");
      }
      return Constants.resultInApi("You are not connected to internet ☹", true);
    } on TimeoutException {
      if (isRequestLogEnabled) {
        Constants.debugLog(SimpleHttpParser, "callPostRawApi:Time out");
      }
      return Constants.resultInApi(
          "The Internet connection has timed out, Please try again.", true);
    } catch (e) {
      if (isRequestLogEnabled) {
        Constants.debugLog(SimpleHttpParser, "Catch Error:$e");
      }
      return Constants.resultInApi("", true);
    }
  }

  static Future pushNotificationAPI(
      {required String? url, String? apiName, required var strJson}) async {
    try {
      final response = await http.post(
        Uri.parse(url!),
        headers: ApiConfig.httpAuthorizationHeader,
        body: strJson,
      );
      final statusCode = response.statusCode;

      if (statusCode == 200) {
        if (isRequestLogEnabled) {
          Constants.debugLog(
              SimpleHttpParser, "callPostRawApi:JsonData:${response.body}");
        }
        return Constants.resultInApi(response.body, false);
      } else if (statusCode == 429) {
        if (isRequestLogEnabled) {
          Constants.debugLog(
              SimpleHttpParser, "callPostRawApi:Status Code Error:$statusCode");
        }
      } else if (statusCode == 401) {
        Fluttertoast.showToast(
            msg: "Unsuccessful", toastLength: Toast.LENGTH_SHORT);
      } else {
        if (isRequestLogEnabled) {
          Constants.debugLog(
              SimpleHttpParser, "callPostRawApi:Status Code Error:$statusCode");
        }
        return Constants.resultInApi("", true);
      }
    } on SocketException {
      if (isRequestLogEnabled) {
        Constants.debugLog(SimpleHttpParser,
            "callPostRawApi:You are not connected to internet ☹");
      }
      return Constants.resultInApi("You are not connected to internet ☹", true);
    } on TimeoutException {
      if (isRequestLogEnabled) {
        Constants.debugLog(SimpleHttpParser, "callPostRawApi:Time out");
      }
      return Constants.resultInApi(
          "The Internet connection has timed out, Please try again.", true);
    } catch (e) {
      if (isRequestLogEnabled) {
        Constants.debugLog(SimpleHttpParser, "Catch Error:$e");
      }
      return Constants.resultInApi("", true);
    }
  }

  static Future callPostWithTokenApi(
      {String? url, required var strJson}) async {
    try {
      final response = await http.post(
        Uri.parse(url!),
        headers: ApiConfig.httpAuthorizationHeader,
        body: strJson,
      );

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        Constants.debugLog(
            SimpleHttpParser, "callPostSMSApi:JsonData:${response.body}");
        return Constants.resultInApi(response.body, false);
      } else if (statusCode == 429) {
        Constants.debugLog(
            SimpleHttpParser, "callPostSMSApi:Status Code Error:$statusCode");

        //SimpleHttpParser.callPostRawApi(url: url, strJson: strJson);
      } else {
        Constants.debugLog(
            SimpleHttpParser, "callPostSMSApi:Status Code Error:$statusCode");
        return Constants.resultInApi("", true);
      }
    } on SocketException {
      Constants.debugLog(SimpleHttpParser,
          "callPostSMSApi:You are not connected to internet.");
      return Constants.resultInApi("You are not connected to internet ☹", true);
    } on TimeoutException {
      // print('Time out');
      // throw TimeoutException("The connection has timed out, Please try again");
      Constants.debugLog(SimpleHttpParser, "callPostSMSApi:Time out");
      return Constants.resultInApi(
          "The Internet connection has timed out, Please try again.", true);
    } catch (e) {
      Constants.debugLog(SimpleHttpParser, "callPostSMSApi:Catch Error:$e");
      return Constants.resultInApi("", true);
    }
  }

  static var httpAuthorizationHeader = {
    "Access-Control-Allow-Origin": "*",
    //"Authorization": "Bearer 2004E27B-5CF7-4712-ADBD-1E15DCD3C8E5",
    "Authorization": "Bearer 075AEA19-3106-4356-9893-C5BE776170AC",
    // "Accept": "application/json",
    "Content-type": "application/json"
  };
  static Future callPostWithTokenApi2(
      {String? url, required var strJson}) async {
    try {
      final response = await http.post(
        Uri.parse(url!),
        headers: ApiConfig.httpAuthorizationHeader,
        body: strJson,
      );

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        Constants.debugLog(
            SimpleHttpParser, "callPostSMSApi:JsonData:${response.body}");
        return Constants.resultInApi(response.body, false);
      } else if (statusCode == 429) {
        Constants.debugLog(
            SimpleHttpParser, "callPostSMSApi:Status Code Error:$statusCode");

        //SimpleHttpParser.callPostRawApi(url: url, strJson: strJson);
      } else {
        Constants.debugLog(
            SimpleHttpParser, "callPostSMSApi:Status Code Error:$statusCode");
        return Constants.resultInApi("", true);
      }
    } on SocketException {
      Constants.debugLog(SimpleHttpParser,
          "callPostSMSApi:You are not connected to internet.");
      return Constants.resultInApi("You are not connected to internet ☹", true);
    } on TimeoutException {
      // print('Time out');
      // throw TimeoutException("The connection has timed out, Please try again");
      Constants.debugLog(SimpleHttpParser, "callPostSMSApi:Time out");
      return Constants.resultInApi(
          "The Internet connection has timed out, Please try again.", true);
    } catch (e) {
      Constants.debugLog(SimpleHttpParser, "callPostSMSApi:Catch Error:$e");
      return Constants.resultInApi("", true);
    }
  }

//--------------------------------------------------//
  static Future callPostEncodeApi({required String? url, var strJson}) async {
    Constants.debugLog(SimpleHttpParser, "url:$url");
    Constants.debugLog(SimpleHttpParser, "strJson:$strJson");
    Map body = json.decode(strJson);
    try {
      final response = await http
          .post(Uri.parse(url!),
              headers: ApiConfig.httpPostHeaderForEncode,
              body: body,
              encoding: Encoding.getByName("utf-8"))
          .timeout(const Duration(seconds: 60),
              onTimeout: () => throw TimeoutException(
                  'The connection has timed out, Please try again!'));

      final statusCode = response.statusCode;
      if (statusCode == 200) {
        Constants.debugLog(
            SimpleHttpParser, "callPostEncodeApi:JsonData:${response.body}");

        // var JsonData = json.decode(response.body);

        return Constants.resultInApi(response.body, false);
      } else if (statusCode == 429) {
        Constants.debugLog(SimpleHttpParser,
            "callPostEncodeApi:Status Code Error:$statusCode");
        SimpleHttpParser.callPostEncodeApi(url: url, strJson: strJson);
      } else {
        Constants.debugLog(SimpleHttpParser,
            "callPostEncodeApi:Status Code Error:$statusCode");
        return Constants.resultInApi("", true);
      }
    } on SocketException {
      Constants.debugLog(SimpleHttpParser,
          "callPostEncodeApi:You are not connected to internet.");
      return Constants.resultInApi("You are not connected to internet ☹", true);
    } on TimeoutException {
      // print('Time out');
      // throw TimeoutException("The connection has timed out, Please try again");
      Constants.debugLog(SimpleHttpParser, "callPostEncodeApi:Time out");
      return Constants.resultInApi(
          "The Internet connection has timed out, Please try again.", true);
    } catch (e) {
      Constants.debugLog(SimpleHttpParser, "callPostEncodeApi:Catch Error:$e");
      return Constants.resultInApi("", true);
    }
  }

  static Future multipartProdecudre(
      {required String? url,
      required String? filepath,
      String currentUserId = "",
      String profileorvideo = "",
      String description = ""}) async {
    try {
      var multipartRequest = http.MultipartRequest('POST', Uri.parse(url!));
      multipartRequest.headers.addAll(
          {"Authorization": "Bearer 075AEA19-3106-4356-9893-C5BE776170AC"});
      multipartRequest.fields['Id'] = currentUserId;
      multipartRequest.fields['FileType'] = profileorvideo;
      multipartRequest.fields['Description'] = description;
      multipartRequest.files.add(
        await http.MultipartFile.fromPath(
          "File",
          filepath!,
          filename: filepath.split("/").last,
        ),
      );

      var response = await multipartRequest.send();
      var responsed = await http.Response.fromStream(response);
      //final responseData = json.decode(responsed.body); use this to diagnose the problem.
      final statusCode = responsed.statusCode;
      if (statusCode == 200) {
        return Constants.resultInApi(responsed.body, false);
      } else if (statusCode == 429) {
        //SimpleHttpParser.callPostEncodeApi(url: url, strJson: strJson);
      } else {
        return Constants.resultInApi("", true);
      }
    } on SocketException {
      return Constants.resultInApi("You are not connected to internet ☹", true);
    } on TimeoutException {
      return Constants.resultInApi(
          "The Internet connection has timed out, Please try again.", true);
    } catch (e) {
      return Constants.resultInApi("", true);
    }
  }

  static Future callPostFileUploadApi(
      {required String? url,
      required String? filepath,
      required String? fileParmenter,
      var strJson}) async {
    Map<String, String> headers = {
      "Accesstoken": "075AEA19-3106-4356-9893-C5BE776170AC"
    };

    Map body = json.decode(strJson);

    try {
      var multipartRequest = http.MultipartRequest('POST', Uri.parse(url!));
      multipartRequest.fields != strJson;
      multipartRequest.headers.addAll(headers);
      multipartRequest.files.add(http.MultipartFile(fileParmenter!,
          File(filepath!).readAsBytes().asStream(), File(filepath).lengthSync(),
          filename: filepath.split("/").last));

      http.Response response =
          await http.Response.fromStream(await multipartRequest.send());
      final responseData = json.decode(response.body);
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        return Constants.resultInApi(response.body, false);
      } else if (statusCode == 429) {
        Constants.debugLog(SimpleHttpParser,
            "callPostFileUploadApi:Status Code Error:$statusCode");
        SimpleHttpParser.callPostEncodeApi(url: url, strJson: strJson);
      } else {
        Constants.debugLog(SimpleHttpParser,
            "callPostImageUploadApi:Status Code Error:$statusCode");
        return Constants.resultInApi("", true);
      }
    } on SocketException {
      Constants.debugLog(SimpleHttpParser,
          "callPostImageUploadApi:You are not connected to internet.");
      return Constants.resultInApi("You are not connected to internet ☹", true);
    } on TimeoutException {
      // print('Time out');
      // throw TimeoutException("The connection has timed out, Please try again");
      Constants.debugLog(SimpleHttpParser, "callPostImageUploadApi:Time out");
      return Constants.resultInApi(
          "The Internet connection has timed out, Please try again.", true);
    } catch (e) {
      Constants.debugLog(
          SimpleHttpParser, "callPostImageUploadApi:Catch Error:$e");
      return Constants.resultInApi("", true);
    }
  }

  static Future callGetRawForFullUrl({required String url}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: ApiConfig.httpAuthorizationHeader,
      );
      final statusCode = response.statusCode;

      if (statusCode == 200) {
        if (isRequestLogEnabled) {
          Constants.debugLog(
              SimpleHttpParser, "callPostRawApi:JsonData:${response.body}");
          print(response.body);
        }
        return Constants.resultInApi(response.body, false);
      } else if (statusCode == 429) {
        if (isRequestLogEnabled) {
          Constants.debugLog(
              SimpleHttpParser, "callPostRawApi:Status Code Error:$statusCode");
        }

        //SimpleHttpParser.callPostRawApi(url: url, strJson: strJson);
      } else if (statusCode == 401) {
        Fluttertoast.showToast(
            msg: "Unsuccessful", toastLength: Toast.LENGTH_SHORT);
      } else {
        if (isRequestLogEnabled) {
          Constants.debugLog(
              SimpleHttpParser, "callPostRawApi:Status Code Error:$statusCode");
        }
        return Constants.resultInApi("", true);
      }
    } on SocketException {
      if (isRequestLogEnabled) {
        Constants.debugLog(SimpleHttpParser,
            "callPostRawApi:You are not connected to internet ☹");
      }
      return Constants.resultInApi("You are not connected to internet ☹", true);
    } on TimeoutException {
      if (isRequestLogEnabled) {
        Constants.debugLog(SimpleHttpParser, "callPostRawApi:Time out");
      }
      return Constants.resultInApi(
          "The Internet connection has timed out, Please try again.", true);
    } catch (e) {
      if (isRequestLogEnabled) {
        Constants.debugLog(SimpleHttpParser, "Catch Error:$e");
      }
      return Constants.resultInApi("", true);
    }
  }
}
