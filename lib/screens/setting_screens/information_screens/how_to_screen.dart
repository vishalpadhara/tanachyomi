import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/theme.dart';

class HowToScreen extends StatefulWidget {
  const HowToScreen({Key? key}) : super(key: key);

  @override
  State<HowToScreen> createState() => _HowToScreenState();
}

class _HowToScreenState extends State<HowToScreen> {
  bool? isdark = false;
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
                "How To",
                style: TextStyle(color: AppColor.appColorSecondaryValue,fontSize: 18),
              ),
            ),
            body: howbody(),
          ),
        );
      }
    );
  }

  Widget howbody(){
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.only(left: 15),
                color: isdark == true ? AppColor.mainbg:AppColor.grey1.shade300,
                width: MediaQuery.of(context).size.width,
                height: 30,
                alignment: Alignment.centerLeft,
                child: Text("Home Screen",style: TextStyle(fontSize: 16,color: isdark == true ? AppColor.appColorPrimaryValue:AppColor.black))),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ut ullamcorper quam, eu condimentum massa. In vitae imperdiet est, quis ornare tellus. Mauris molestie elit sit amet egestas sagittis.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 15,),
            Divider(
              height: 2,
              endIndent: 15,
              indent: 15,
              color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
              thickness: 1.0,
            ),
            SizedBox(height: 20,),

            Container(
                padding: EdgeInsets.only(left: 15),
                color: isdark == true ? AppColor.mainbg:AppColor.grey1.shade300,
                width: MediaQuery.of(context).size.width,
                height: 30,
                alignment: Alignment.centerLeft,
                child: Text("Library Screen",style: TextStyle(fontSize: 16,color: isdark == true ? AppColor.appColorPrimaryValue:AppColor.black),)),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ut ullamcorper quam, eu condimentum massa. In vitae imperdiet est, quis ornare tellus. Mauris molestie elit sit amet egestas sagittis.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 15,),
            Divider(
              height: 2,
              endIndent: 15,
              indent: 15,
              color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
              thickness: 1.0,
            ),
            SizedBox(height: 20,),

            Container(
                padding: EdgeInsets.only(left: 15),
                color: isdark == true ? AppColor.mainbg:AppColor.grey1.shade300,
                width: MediaQuery.of(context).size.width,
                height: 30,
                alignment: Alignment.centerLeft,
                child: Text("Setting Screen",style: TextStyle(fontSize: 16,color: isdark == true ? AppColor.appColorPrimaryValue:AppColor.black),)),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ut ullamcorper quam, eu condimentum massa. In vitae imperdiet est, quis ornare tellus. Mauris molestie elit sit amet egestas sagittis.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 15,),
            Divider(
              height: 2,
              endIndent: 15,
              indent: 15,
              color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
              thickness: 1.0,
            ),
            SizedBox(height: 20,),

            Container(
                padding: EdgeInsets.only(left: 15),
                color: isdark == true ? AppColor.mainbg:AppColor.grey1.shade300,
                width: MediaQuery.of(context).size.width,
                height: 30,
                alignment: Alignment.centerLeft,
                child: Text("Profile Screen",style: TextStyle(fontSize: 16,color: isdark == true ? AppColor.appColorPrimaryValue:AppColor.black),)),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ut ullamcorper quam, eu condimentum massa. In vitae imperdiet est, quis ornare tellus. Mauris molestie elit sit amet egestas sagittis.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 15,),
            Divider(
              height: 2,
              endIndent: 15,
              indent: 15,
              color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
              thickness: 1.0,
            ),
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }

  handleBackPress() {
    return Navigator.pop(context);
  }

}
