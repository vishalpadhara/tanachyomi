import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool? isdark;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      isdark = theme.getTheme() == theme.darkTheme ? true : false;
        return WillPopScope(
          onWillPop: () {
            return handleBackPress();
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: isdark == true ? AppColor.white:AppColor.white,
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColor.grey600,
                  )),
              elevation: 0,
              bottom: PreferredSize(
                  child: Container(
                    color: AppColor.appColorSecondaryValue,
                    height: 4.0,
                  ),
                  preferredSize: Size.fromHeight(4.0)),
              title: Text(
                "Notifications",
                style: TextStyle(color: AppColor.appColorSecondaryValue,fontSize: 18),
              ),
            ),
            body: notificationbody(),
          ),
        );
      }
    );
  }

  Widget notificationbody(){
    return Container(
      child: Center(
        child: Text("No notifications available yet",
        style: TextStyle(color: isdark == true ? AppColor.white:AppColor.appColorPrimaryValue,fontSize: 16),),
      ),
    );
  }

  handleBackPress() {
    return Navigator.pop(context);
  }

}
