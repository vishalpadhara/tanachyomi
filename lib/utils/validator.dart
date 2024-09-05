// *************************************************************************
// *                                                                       *
// * nopcommerceplus - Flutter Mobile App (Android & IOS) for nopCommerce  *
// * Copyright (c) Forefront Infotech. All Rights Reserved.                *
// *                                                                       *
// *************************************************************************
// *                                                                       *
// * Email: info@nopcommerceplus.com                                       *
// * Website: http://www.nopcommerceplus.com                               *
// *                                                                       *
// *************************************************************************
// *                                                                       *
// * This  software is furnished  under a license  and  may  be  used  and *
// * modified  only in  accordance with the terms of such license and with *
// * the  inclusion of the above  copyright notice.  This software or  any *
// * other copies thereof may not be provided or  otherwise made available *
// * to any  other  person.   No title to and ownership of the software is *
// * hereby transferred.                                                   *
// *                                                                       *
// * You may not reverse  engineer, decompile, defeat  license  encryption *
// * mechanisms  or  disassemble this software product or software product *
// * license.  Forefront Infotech may terminate this license if you don't  *
// * comply with  any  of  the  terms and conditions set forth in  our end *
// * user license agreement (EULA).  In such event,  licensee  agrees to   *
// * return licensor  or destroy  all copies of software  upon termination *
// * of the license.                                                       *
// *                                                                       *
// * Please see the  License file for the full End User License Agreement. *
// * The  complete license agreement is also available on  our  website at *
// * http://www.nopcommerceplus.com/enterprise-license                     *
// *                                                                       *
// *************************************************************************


import 'package:tanachyomi/utils/constant.dart';

class Validator {
  static Pattern emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regexEmail = new RegExp(emailPattern.toString());

  static Pattern phonePattern =
      "\\d{10}|(?:\\d{3}-){2}\\d{4}|\\(\\d{3}\\)\\d{3}-?\\d{4}";
  static RegExp regexPhone = new RegExp(phonePattern.toString());

  static String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  static RegExp regExp = new RegExp(patttern);

  static validateEmail(String value, String errorTextForEmptyField,
      String errorTextForInvalidField) {
    if (value.isNotEmpty) {
      if (regexEmail.hasMatch(value)) {
        return null;
      } else {
        return errorTextForInvalidField;
      }
    } else {
      return errorTextForEmptyField;
    }
  }

  static validateFormField(String? value, String? errorTextForEmptyField,
      String? errorTextInvalidField, int? type) {
    switch (type) {
      case Constants.NORMAL_VALIDATION:
        if (value!.isEmpty) {
          return errorTextForEmptyField;
        }
        break;

      case Constants.EMAIL_VALIDATION:
        return validateEmail(
            value!, errorTextForEmptyField!, errorTextInvalidField!);
        break;

      case Constants.PHONE_VALIDATION:
        if (value!.length == 0) {
          return errorTextForEmptyField;
          // 'Please enter mobile number';
        } else if (!regExp.hasMatch(value)) {
          return errorTextInvalidField;
          // 'Please enter valid mobile number';
        }
        return null;

      case Constants.STRONG_PASSWORD_VALIDATION:
        if (value!.isNotEmpty) {
          if (value.length >= 6) {
            return null;
          } else {
            return errorTextInvalidField;
          }
        } else {
          return errorTextForEmptyField;
        }
        break;

      case Constants.PHONE_OR_EMAIL_VALIDATION:
        if (value!.isNotEmpty) {
          if (regexEmail.hasMatch(value)) {
            return null;
          } else if (isNumeric(value)) {
            return null;
          } else {
            return errorTextInvalidField;
          }
        } else {
          return errorTextForEmptyField;
        }
        break;
    }
  }

  // static bool isNumeric(String s) {
  //   if (s == null) {
  //     return false;
  //   }
  //   // ignore: deprecated_member_use, unnecessary_null_comparison
  //   return double.parse(s, (e) => 0) != null;
  // }
  static bool isNumeric(String string) {
    if (string == null || string.isEmpty) {
      return false;
    }
    // Try to parse input string to number.
    // Both integer and double work.
    // Use int.tryParse if you want to check integer only.
    // Use double.tryParse if you want to check double only.
    final number = num.tryParse(string);

    if (number == null) {
      return false;
    }

    return true;
  }
}
