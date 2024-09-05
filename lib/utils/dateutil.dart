import 'package:intl/intl.dart';
import 'package:tanachyomi/utils/constant.dart';

class DateUtil {
  // 'yyyy-MM-dd HH:mm' =>"2022-02-11 04:14"
  static const DATE_FORMAT = 'yyyy-MM-dd HH:mm';
  // 'yy-MM-dd hh:mm:ss aaa' =>"22-02-11 04:15:03 AM"
  static const DATE_FORMAT1 = 'yy-MM-dd hh:mm:ss aaa';
  // 'dd-MM-yy hh:mm:ss aaa'=>"11-02-22 04:15:29 AM"
  static const DATE_FORMAT2 = 'dd-MM-yy hh:mm:ss aaa';
  // 'yyyy-MM-dd'=>"2022-02-11"
  static const DATE_FORMAT3 = 'yyyy-MM-dd';
  // 'dd-MM-yyyy'=>"11-02-2022"
  static const DATE_FORMAT4 = 'dd-MM-yyyy';
  // 'dd/MM/yyyy hh:mm:ss aaa'=>"11/02/2022 04:16:58 AM"
  static const DATE_FORMAT5 = 'dd/MM/yyyy hh:mm:ss aaa';
  // 'dd/MM/yyyy'=>"11/02/2022"
  static const DATE_FORMAT6 = 'dd/MM/yyyy';
  // dd/MMM/yyyy=>"11/Feb/2022"
  static const DATE_FORMAT7 = 'dd/MMM/yyyy';
  // 'hh:mm:ss aaa'=>"04:17:38 AM"
  static const DATE_FORMAT8 = 'hh:mm:ss aaa';
  // 'eeee'=>"Friday"
  static const DATE_FORMAT9 = 'eeee';
  // 'EEE'=>"Fri"
  static const DATE_FORMAT10 = 'EEE';
  // 'MMMM'=>"February"
  static const DATE_FORMAT11 = 'MMMM';
  // 'hh:mm:ss aaa'=>"04:17 AM"
  static const DATE_FORMAT12 = 'hh:mm aaa';

  String LocalFormat(String utcTime, String dateFormat) {
    String updatedDt = "";
    try {
      var strToDateTime = DateTime.parse(utcTime.toString());
      final convertLocal = strToDateTime.toLocal();

      updatedDt = DateFormat(dateFormat).format(convertLocal);
    } catch (e) {
      Constants.debugLog(DateUtil, "LocalFormat:error:${e.toString()}");
    }
    return updatedDt.toString();
  }

  static DateTime? StingToDate(String time, String dateFormat) {
    DateTime? input = null;
    try {
      input = DateFormat(dateFormat).parse(time.toString());
    } catch (e) {
      Constants.debugLog(DateUtil, "StingToDate:error:${e.toString()}");
    }
    return input!;
  }

  // DateTime StingToDate(String time, String dateFormat) {
  //   DateTime? input;
  //   try {
  //     input = DateFormat(dateFormat).parse(time.toString());
  //   } catch (e) {
  //     Constants.debugLog(DateUtil, "StingToDate:error:${e.toString()}");
  //   }
  //   return input!;
  // }

  String DateToString(DateTime? time, String dateFormat) {
    String? input = "";
    try {
      input = DateFormat(dateFormat).format(time!);
    } catch (e) {
      Constants.debugLog(DateUtil, "DateToSting:error:${e.toString()}");
    }
    return input ?? "";
  }
}
