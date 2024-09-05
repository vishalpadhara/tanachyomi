import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/screens/setting_screens/information_screens/about_screen.dart';
import 'package:tanachyomi/screens/setting_screens/information_screens/donate_screen.dart';
import 'package:tanachyomi/screens/setting_screens/information_screens/how_to_screen.dart';
import 'package:tanachyomi/screens/setting_screens/information_screens/survey_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  bool? isdark;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _)  {
      isdark = theme.getTheme() == theme.darkTheme ? true : false;
        return WillPopScope(
          onWillPop: () {
            return handleBackPress();
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.white,
              leading: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.mainbg,),
                ),
              ),
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20.0),
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  // height: 20,
                  padding: EdgeInsets.only(left: 15,bottom: 10,top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text("Information",
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColor.appColorSecondaryValue,
                        fontWeight: FontWeight.bold),),
                ),
              ),
            ),
            body: Container(
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, SlideRightRoute(
                        widget: AboutScreen()
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("About",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500),),
                          Icon(Icons.arrow_forward_ios,size: 20,color: AppColor.appColorSecondaryValue,)
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 2,
                    endIndent: 10,
                    indent: 10,
                    color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
                    thickness: 1.0,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, SlideRightRoute(
                          widget: DonateScreen()
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Donate",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500),),
                          Icon(Icons.arrow_forward_ios,size: 20,color: AppColor.appColorSecondaryValue,)
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 2,
                    endIndent: 10,
                    indent: 10,
                    color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
                    thickness: 1.0,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, SlideRightRoute(
                          widget: SurveyScreen()
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Survey",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500),),
                          Icon(Icons.arrow_forward_ios,size: 20,color: AppColor.appColorSecondaryValue,)
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 2,
                    endIndent: 10,
                    indent: 10,
                    color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
                    thickness: 1.0,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, SlideRightRoute(
                          widget: HowToScreen()
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("How To",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500),),
                          Icon(Icons.arrow_forward_ios,size: 20,color: AppColor.appColorSecondaryValue,)
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 2,
                    endIndent: 10,
                    indent: 10,
                    color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
                    thickness: 1.0,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  handleBackPress() {
    return Navigator.pop(context);
  }
}
