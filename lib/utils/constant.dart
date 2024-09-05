import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:universal_io/io.dart' as ptf;

class Constants {
  static const String token = "token";
  static const String recentlist = "recentlist";
  static const String comparelist = "comparelist";
  static const String prefUserIdKeyInt = "UserId";
  static const String prefUserGuid = "UserGuid";
  static const String isDarkMode = "DarkMode";
  static const String prefGuestUserIdKeyInt = "GuestUserId";
  static const String loginpassword = "LoginPassword";
  static const String loginUserName = "LoginUserName";
  static const String loginemail = "LoginEmail";
  static const String totalAmount = "";
  static const String selectedAddressId = "";
  static const int NORMAL_VALIDATION = 1;
  static const int EMAIL_VALIDATION = 2;
  static const int PHONE_VALIDATION = 3;
  static const int STRONG_PASSWORD_VALIDATION = 4;
  static const int PHONE_OR_EMAIL_VALIDATION = 5;
  static int cartItemCount = 0;
  static const String positionOfMethod = "0";
  static const int NO_INTERNET = 1;
  static const int FOR_LOGIN = 2;
  static const int CREATE_PASSWORD = 0;
  static const int RESET_PASSWORD = 1;
  static const int CHANGE_PASSWORD = 2;
  static const String registrationType = "registrationType";
  static const String prefLanguageId = "LanguageId";
  static const String prefCurrencyId = "CurrencyId";
  static Map<String, String> hashMap = Map<String, String>();
  static bool? checkRTL = false;
  static const String prefRTL = "RTL";
  // static const String checkRTL = "RTL";
  static const String isGuestLogin = "isGuestLogin";
  static var typeOfGroupProductDetailPage = "GroupedProduct";
  static const String isShhippedEnable = "isShhippedEnable";
  static String SubTotalPrice = "";
  // static List<int> compareProductList = <int>[];

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  static Future<bool> isInternetAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static String getValueFromKey(String mapKey, Map map) {
    String key = mapKey.toLowerCase();
    if (map != null &&
        map.containsKey(key) &&
        map[key] != null &&
        map[key].toString().isNotEmpty) {
      return map[key];
    }
    return key;
  }

  static bool isDesktopOS() {
    return ptf.Platform.isMacOS ||
        ptf.Platform.isLinux ||
        ptf.Platform.isWindows;
  }

  static bool isAppOS() {
    return ptf.Platform.isIOS || ptf.Platform.isAndroid;
  }

  static bool isAndroid() {
    return ptf.Platform.isAndroid;
  }

  static bool isIOS() {
    return ptf.Platform.isIOS;
  }

  static bool isWeb() {
    return kIsWeb;
  }

  static progressDialog(
      bool isLoading, BuildContext context, String resourceData) async {
    AlertDialog dialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Container(
          height: 100.0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SpinKitThreeBounce(
                  color: AppColor.appColorPrimaryValue,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Text(
                  resourceData,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          )),
      contentPadding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
    );
    if (!isLoading) {
      Navigator.pop(context, true);
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return dialog;
          });
    }
  }

  static progressDialog1(bool isLoading, String resourceData) {
    return isLoading == true
        ? Container(
            child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SpinKitThreeBounce(
                  color: AppColor.appColorPrimaryValue,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Text(
                  resourceData,
                  style: TextStyle(color: AppColor.appColorPrimaryValue),
                ),
              ],
            ),
          ))
        : Container();
  }

  static Future<String> currentPlatform() async {
    var platformName = '';
    if (kIsWeb) {
      platformName = "Web";
    } else {
      if (ptf.Platform.isAndroid) {
        platformName = "Android";
      } else if (ptf.Platform.isIOS) {
        platformName = "IOS";
      } else if (ptf.Platform.isFuchsia) {
        platformName = "Fuchsia";
      } else if (ptf.Platform.isLinux) {
        platformName = "Linux";
      } else if (ptf.Platform.isMacOS) {
        platformName = "MacOS";
      } else if (ptf.Platform.isWindows) {
        platformName = "Windows";
      }
    }
    // print("platformName :- " + platformName.toString());
    return platformName;
  }

  static Future<bool> isFirstTime(String str) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var isFirstTime = pref.getBool(str);
    if (isFirstTime != null && !isFirstTime) {
      pref.setBool(str, false);
      return false;
    } else {
      pref.setBool(str, false);
      return true;
    }
  }

  ///print log at Screen level to identify it easy.
  static void debugLog(Type? classObject, String? message) {
    try {
      var runtimeTypeName = (classObject).toString();
      if (kDebugMode) {
        print("${runtimeTypeName.toString()}: $message");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static resultInApi(var value, bool? isError) {
    Map<String, dynamic> map = {"isError": isError, "value": value};
    return map;
  }
}

abstract class RefreshListener {
  void onRefresh();
}
