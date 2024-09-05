import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/screens/home_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';

class ThankYouDonationScreen extends StatefulWidget {
  const ThankYouDonationScreen({Key? key}) : super(key: key);

  @override
  State<ThankYouDonationScreen> createState() => _ThankYouDonationScreenState();
}

class _ThankYouDonationScreenState extends State<ThankYouDonationScreen> {
  bool isdark = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      isdark = theme.getTheme() == theme.darkTheme ? true : false;
        return WillPopScope(
          onWillPop: (){
            return handleBackPress();
          },
          child: Scaffold(
            body: thankyoudonationbody(),
          ),
        );
      }
    );
  }

  Widget thankyoudonationbody() {
    return
      Container(
      padding: const EdgeInsets.all(15.0),
      // height: MediaQuery.of(context).size.height/1.4,
      color: AppColor.white,
      child: Card(
        elevation: 10,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/vector2.png",
                  fit: BoxFit.fill,
                  color: isdark == true ? AppColor.white:null,
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 2.5,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  "You donated \$5",
                  style: TextStyle(
                      color: isdark == true ? AppColor.appColorSecondaryValue:AppColor.appColorPrimaryValue,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                endIndent: 20,
                indent: 20,
                color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 1.0,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  "Thank you",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                ),
              ),
              Container(
                child: Text(
                  "for your donation",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                endIndent: 20,
                indent: 20,
                color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 1.0,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Text(
                  textAlign: TextAlign.center,
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Parturient malesuada elit iaculis dignissim nunc dapibus. Cursus mi sodales sed neque, semper odio vel.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                endIndent: 120,
                indent: 120,
                color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 1.0,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // elevation: MaterialStateProperty.all(0.0),
                  padding: const EdgeInsets.all(10.0),
                  primary: isdark == true ? AppColor.appColorPrimaryValue:AppColor.appColorSecondaryValue,
                  shadowColor: isdark == true ? AppColor.appColorPrimaryValue:AppColor.appColorSecondaryValue,
                  elevation: 2,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                onPressed: () {
                    // Navigator.pop(context);
                    Navigator.push(context, SlideRightRoute(
                        widget: HomeScreen())
                    );
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width / 1.25,
                  child: Center(
                    child: Text(
                      "Close",
                      style: TextStyle(color: AppColor.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  handleBackPress() {
    return Navigator.push(context, SlideRightRoute(
        widget: HomeScreen())
    );
  }
}
