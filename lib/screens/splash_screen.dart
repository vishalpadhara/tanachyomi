import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanachyomi/screens/home_screen.dart';
import 'package:tanachyomi/screens/login_screen.dart';
import 'package:tanachyomi/screens/no_internet_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/clippath.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/current_userinfo.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isInternet = true;
  bool? isLoading = false;
  int? id;

  @override
  initState() {
    super.initState();
    internetConnection();
    setState(() {});
    Timer(const Duration(seconds: 3), () async {
      if (isInternet != null && isInternet! == true) {
        await nextScreen();
      } else {
        Navigator.push(context, SlideRightRoute(widget: NoInternetScreen(
          onPressedRetyButton: () {
            internetConnection();
          },
        )));
        print("No Internet");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonLayoutforSplashLogin(),
    );
  }

  Widget CommonLayoutforSplashLogin() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/wall4.png',
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height / 6,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: new ClipRect(
                            child: new BackdropFilter(
                              filter: new ImageFilter.blur(
                                  sigmaX: 1.0, sigmaY: 1.0),
                              child: new Container(
                                width: MediaQuery.of(context).size.width / 2.3,
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                decoration: new BoxDecoration(
                                    color: Colors.black12.withOpacity(0.3),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                              ),
                            ),
                          ),
                        ),
                        Center(
                            child: Image.asset(
                          "assets/images/tanachyomi.png",
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: MediaQuery.of(context).size.height / 5,
                          fit: BoxFit.fill,
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SpinKitFadingCircle(
                      size: 60,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: /*index.isEven ? Colors.white :*/
                                  Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "SMALL STEPS",
                      style: TextStyle(fontSize: 28, color: Colors.black38),
                    ),
                    Text(
                      "BIG ARCHIEVEMENTS",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 1.0,
                          color: AppColor.appColorSecondaryValue),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          // color: Colors.red,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              ClipPath(
                                clipper: ClipPathValue(),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: Container(
                                    padding: EdgeInsets.only(top: 5),
                                    color: AppColor.appColorPrimaryValue,
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                        "The Tanach Yomi App is Sponsored by",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColor.white),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                              Positioned(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Container(
                                  height: 2,
                                  margin: EdgeInsets.only(right: 10, left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black38,
                                        blurRadius: 3,
                                        offset: Offset(1, 4), // Shadow position
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textcontent()
                  ],
                )),
          ],
        ));
  }

  Widget textcontent() {
    return Container(
      // height: 30,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 12,
          right: MediaQuery.of(context).size.width / 12),
      width: MediaQuery.of(context).size.width,
      child: Text(
          "The Henry, Bertha and Edward Rothman Foundation Rochester NY - Circleville OH - Cleveland OH",
          style: TextStyle(color: Colors.black26, fontSize: 12),
          textAlign: TextAlign.center),
    );
  }

  nextScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      id = pref.getInt(Constants.prefUserIdKeyInt);
      await CurrentUserInfo.setUserIdInPreferenece(id);
    } catch (e) {
      id = null;
    }
    if (id != null) {
      Navigator.push(context, SlideRightRoute(widget: HomeScreen()));
    } else {
      Navigator.push(context, SlideRightRoute(widget: LoginScreen()));
    }
  }

  internetConnection() async {
    try {
      String platformName = await Constants.currentPlatform();
      print("platformName :- " + platformName.toString());
      isInternet = await Constants.isInternetAvailable();
    } catch (e) {
      print('error ${e}');
    }

    isLoading = isInternet;
    if (this.mounted) {
      setState(() {});
    }
  }
}
