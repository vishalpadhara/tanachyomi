import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/theme.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  bool? isdark = false;
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
                "About",
                style: TextStyle(color: AppColor.appColorSecondaryValue,fontSize: 18),
              ),
            ),
            body: aboutbody(),
          ),
        );
      }
    );
  }

  Widget aboutbody(){
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
                child: Text("A Little Bit about this App",style: TextStyle(fontSize: 16,color: isdark == true ? AppColor.appColorPrimaryValue:AppColor.black),)),
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
              // padding: EdgeInsets.only(top: 20),
              child: Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: isdark == true ? AppColor.mainbg:AppColor.appColorPrimaryValue,
                  child: CircleAvatar(
                    radius: 70,
                    // backgroundImage: AssetImage("assets/images/usa.png"),
                    child: Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/images/wall1.jpg",)
                              ,fit: BoxFit.fill
                          )),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ut ullamcorper quam.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20,),
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
                child: Text("A Little Bit about this App",style: TextStyle(fontSize: 16,color: isdark == true ? AppColor.appColorPrimaryValue:AppColor.black),)),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text(
                "Quisque sit amet ultricies sapien, et porttitor purus.Phasellus scelerisque nibh vitae arcu ultricies, eget pulvinar nisl sollicitudin.\n \n Morbi nec semper justo. Integer efficitur velit et odio venenatis faucibus. Curabitur ultrices fermentum dapibus. Quisque imperdiet ex sollicitudin orci convallis aliquet. Cras ut quam volutpat, varius tellus sit amet, dictum purus. Nullam id odio consectetur.",
                style: TextStyle(fontSize: 16),
              ),
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
