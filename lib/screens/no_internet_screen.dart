import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/text_utils.dart';

class NoInternetScreen extends StatefulWidget {
  final GestureTapCallback? onPressedRetyButton;

  NoInternetScreen({Key? key, required this.onPressedRetyButton})
      : super(key: key);

  @override
  _NoInternetScreenState createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen>
    with WidgetsBindingObserver {
  Completer? completer = Completer();
  // bool? _useWhiteStatusBarForeground;
  // bool? _useWhiteNavigationBarForeground;

  @override
  void initState() {
    if (mounted) {
      setState(() {});
    }
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: body()),
    );
  }

  Widget body() {
    changeStatusColor(Colors.black);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/no_internet.png",
                height: 130.0,
                color: AppColor.appColorPrimaryValue,
                fit: BoxFit.cover,
              ),
              const Padding(padding: EdgeInsets.only(top: 10.0)),
              SubHeadText(
                text: "No Internet Connection",
                align: TextAlign.center,
                color: AppColor.appColorPrimaryValue,
              ),
              const Padding(padding: EdgeInsets.only(top: 10.0)),
              TitleText(
                text: "Enable your internet connection and try again.",
                align: TextAlign.center,
                color: AppColor.appColorPrimaryValue,
              ),
              const Padding(padding: EdgeInsets.only(top: 27.0)),
              ElevatedButton(
                onPressed: widget.onPressedRetyButton,
                child: const Text("Retry Again"),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // if (_useWhiteStatusBarForeground != null) {
      //   FlutterStatusbarcolor.setStatusBarWhiteForeground(
      //       _useWhiteStatusBarForeground!);
      // }
      // if (_useWhiteNavigationBarForeground != null) {
      //   FlutterStatusbarcolor.setNavigationBarWhiteForeground(
      //       _useWhiteNavigationBarForeground!);
      // }
    }
    super.didChangeAppLifecycleState(state);
  }

  changeStatusColor(Color color) async {
    try {
      // await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
      // if (useWhiteForeground(color)) {
        // FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        // FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      // } else {
        // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        // FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
        // _useWhiteStatusBarForeground = false;
        // _useWhiteNavigationBarForeground = false;
      // }
    } on PlatformException catch (e) {
      Constants.debugLog(NoInternetScreen, e.toString());
    }
  }

  changeNavigationColor(Color color) async {
    try {
      // await FlutterStatusbarcolor.setNavigationBarColor(color, animate: true);
    } on PlatformException catch (e) {
      Constants.debugLog(NoInternetScreen, e.toString());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
