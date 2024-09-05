import 'package:flutter/material.dart';

class AppColor {
  static Color primarySwatchColor = Colors.white;

  static MaterialColor errorColor = Colors.red;
  static MaterialColor disableColor = Colors.grey;

  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color grey = Color(0xFFFAFAFA);
  static Color grey600 = Colors.grey.shade600;

  // static int appColorPrimaryValue = 0x74c6c4;//0xFFC70851;
  static Color appColorPrimaryValue = Color.fromRGBO(212, 192, 136, 1);//0xFFC70851;
  static Color appColorPrimarydull = Color.fromRGBO(212, 192, 136, 0.5);//0xFFC70851;
  static Color progressbar = Color.fromRGBO(98, 96, 110, 1);//0xFFC70851;

  static Color appColorSecondaryValue = Color.fromRGBO(116, 198, 196, 1); //0xFFC70851;


  static Color mainbg = Color.fromRGBO(81, 80, 90, 1);//0xFFC70851;
  static Color box = Color.fromRGBO(176, 111, 129, 0.2);//0xFFC70851;
  static Color boxback = Color.fromRGBO(245, 245, 245, 1);//0xFFC70851;

  static Color iconValue = Color.fromRGBO(229, 229, 229,1); //0xFFC70851;

  static int _greyPrimaryValue = 0xFF9E9E9E;

  static  MaterialColor grey1 = MaterialColor(
    _greyPrimaryValue,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFAFAFA),
      // 100: Color(0xFFFFFFFF),
      // 100: Color(0xFFF5F5F5),
      200: Color(0xFFEEEEEE),
      300: Color(0xFFE0E0E0),
      350: Color(0xFFD6D6D6), // only for raised button while pressed in light theme
      400: Color(0xFFBDBDBD),
      500: Color(_greyPrimaryValue),
      600: Color(0xFF757575),
      700: Color(0xFF616161),
      800: Color(0xFF424242),
      850: Color(0xFF303030), // only for background color in dark theme
      900: Color(0xFF212121),
    },
  );

  static const MaterialColor white1 = const MaterialColor(
    0xFFFFFFFF,
    const <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFFFFFFF),
      200: const Color(0xFFFFFFFF),
      300: const Color(0xFFFFFFFF),
      400: const Color(0xFFFFFFFF),
      500: const Color(0xFFFFFFFF),
      600: const Color(0xFFFFFFFF),
      700: const Color(0xFFFFFFFF),
      800: const Color(0xFFFFFFFF),
      900: const Color(0xFFFFFFFF),
    },
  );

}