import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanachyomi/utils/constant.dart';

class CurrentUserInfo {
  static String currentUserId = "";
  static getSavedUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    currentUserId =
        (await pref.getInt(Constants.prefUserIdKeyInt) ?? 0).toString();
  }

  static setUserIdInPreferenece(int? id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(Constants.prefUserIdKeyInt, id!);
    currentUserId = (id).toString();
  }
}
