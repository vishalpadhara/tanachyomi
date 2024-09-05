import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/screens/billing_address_screen.dart';

import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/noleadingspaceformatter.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';
import 'package:tanachyomi/utils/validator.dart';

class SponsorScreen extends StatefulWidget {
  const SponsorScreen({Key? key}) : super(key: key);

  @override
  State<SponsorScreen> createState() => _SponsorScreenState();
}

class _SponsorScreenState extends State<SponsorScreen> {
  TextEditingController surveyTextController =
      TextEditingController(text: "JohnSmith in honor of Cohen");
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
            // appBar: AppBar(title: Text("donate"),),
            backgroundColor: Colors.transparent,
            body: sponsorBody(),
          ),
        );
      }
    );
  }

  Widget sponsorBody() {
    return
      Container(
      color:  Colors.transparent,
      child: Card(
        elevation: 10,
        margin: EdgeInsets.only(top: 25.0,right: 15,left: 15,bottom: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width,
                        child: isdark == true ? Image.asset(
                          "assets/images/amicodark.png",
                          alignment: Alignment.bottomCenter,
                        ):Image.asset(
                          "assets/images/amico.png",
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                      Positioned(
                        left: 15,
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      ),
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
                endIndent: 20,
                indent: 20,
                color: isdark == true ? AppColor.white :Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 1.0,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "SPONSOR",
                  style: TextStyle(
                      color: isdark == true ? AppColor.appColorPrimaryValue : AppColor.appColorSecondaryValue,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Center(
                  child: Text(
                    "Become a sponsor of this \n day of learning for an \n amount of",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
                endIndent: 120,
                indent: 120,
                color: isdark == true ? AppColor.white : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 1.0,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  // margin: EdgeInsets.only(left: 15, right: 15),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    color: isdark == true ? AppColor.mainbg : AppColor.grey1.shade100,
                    // borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                        color: isdark == true ? AppColor.grey1.shade800 :AppColor.white,
                        border: Border.all(color: isdark == true ? AppColor.white : AppColor.grey1.shade300),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Column(
                      children: [
                        Center(
                          child: Text("\$180",
                              style: TextStyle(
                                  color: isdark == true ? AppColor.white :AppColor.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20)),
                        ),
                        Center(
                          child: Text("Per day",
                              style: TextStyle(
                                  color: AppColor.appColorSecondaryValue,
                                  fontSize: 14)),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                endIndent: 120,
                indent: 120,
                color: isdark == true ? AppColor.white :Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 1.0,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  // height: 100,
                  padding: EdgeInsets.only(left: 10, bottom: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: isdark == true ? AppColor.white :Colors.grey.withOpacity(0.2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "Message Sponsored by",
                          style: TextStyle(
                              fontSize: 14, color: AppColor.appColorPrimaryValue),
                        ),
                      ),
                      TextFormField(
                        cursorColor: AppColor.black,
                        controller: surveyTextController,
                        maxLines: 3,
                        // minLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.multiline,
                        inputFormatters: [NoLeadingSpaceFormatter()],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 8),
                          // constraints: BoxConstraints.tight(Size.fromHeight(40)),
                          border: InputBorder.none,
                          labelStyle:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: AppColor.grey600,
                                    fontSize: 24.0,
                                  ),
                        ),

                        textInputAction: TextInputAction.done,
                        // focusNode: secondFocusNode,
                        validator: (value) {
                          return Validator.validateFormField(
                              value,
                              "message is required",
                              null,
                              Constants.NORMAL_VALIDATION);
                        },
                      ),
                    ],
                  ),
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // elevation: MaterialStateProperty.all(0.0),
                    padding: const EdgeInsets.all(10.0),
                    primary: isdark == true ? AppColor.appColorSecondaryValue : AppColor.grey600,
                    shadowColor: isdark == true ? AppColor.appColorSecondaryValue :AppColor.grey600,
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: BillingAddressScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width / 1.15,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/coins.png",
                            height: 20,
                            width: 30,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Sponsor Now",
                            style: TextStyle(color: AppColor.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  handleBackPress() {
    return Navigator.pop(context);
  }
}
