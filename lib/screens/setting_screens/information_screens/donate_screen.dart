import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/screens/donate_button_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({Key? key}) : super(key: key);

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
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
                "Donate",
                style: TextStyle(color: AppColor.appColorSecondaryValue,fontSize: 18),
              ),
            ),
            body: donatebody(),
          ),
        );
      }
    );
  }

  Widget donatebody(){
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
                child: Text("Make Nach Nook even Better!",style: TextStyle(fontSize: 16,color: isdark == true ? AppColor.appColorPrimaryValue:AppColor.black),)),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ut ullamcorper quam, eu condimentum massa. In vitae imperdiet est, quis ornare tellus. Mauris molestie elit sit amet egestas sagittis. Mauris velit urna, tristique quis quam sit amet, vestibulum bibendum dui. Phasellus sit amet hendrerit nisl. Nullam vulputate odio id nunc tincidunt, vel pulvinar quam vestibulum. Mauris at imperdiet elit, non vulputate dolor. Integer in dui luctus, volutpat dui in, congue orci.\n\n Quisque sit amet ultricies sapien, et porttitor purus.Phasellus scelerisque nibh vitae arcu ultricies, eget pulvinar nisl sollicitudin. Morbi nec semper justo. Integer efficitur velit et odio venenatis faucibus. Curabitur ultrices fermentum dapibus. Quisque imperdiet ex sollicitudin orci convallis aliquet. Cras ut quam volutpat, varius tellus sit amet, dictum purus. Nullam id odio consectetur, placerat odio sit amet, ultrices dui. Ut quis placerat ex, vel ultrices ligula. Nullam nec tortor nec dolor commodo mollis. Nunc nec massa rhoncus, tristique turpis quis, varius turpis. Sed eu consequat purus. ",
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
            SizedBox(height: 15,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // elevation: MaterialStateProperty.all(0.0),
                padding: const EdgeInsets.all(10.0),
                primary: AppColor.appColorPrimaryValue,
                shadowColor: AppColor.appColorPrimaryValue,
                elevation: 2,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              onPressed: () {

              },
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width / 1.15,
                child: Center(
                  child: Text(
                    "DONATE",
                    style: TextStyle(color: AppColor.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleBackPress() {
    return Navigator.pop(context);
  }
}
