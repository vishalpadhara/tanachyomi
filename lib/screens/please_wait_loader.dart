import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/appcolor.dart';

class PleaseWait extends StatelessWidget {
  const PleaseWait({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              "Please wait",
              style: TextStyle(color: AppColor.appColorPrimaryValue),
            ),
          ],
        ),
      ),
    );
  }
}
