import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';

class ErrorScreenPage extends StatefulWidget {
  const ErrorScreenPage({Key? key}) : super(key: key);

  @override
  _ErrorScreenPageState createState() => _ErrorScreenPageState();
}

class _ErrorScreenPageState extends State<ErrorScreenPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Directionality(
          textDirection: Constants.checkRTL != null && Constants.checkRTL!
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.error_outline,
                      size: 90.0, color: AppColor.errorColor),
                  const SizedBox(height: 20.0),
                   Text( "OOPS!",
                      textAlign: TextAlign.center),
                  const SizedBox(height: 10.0),
                   Text("Something Went Wrong",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
