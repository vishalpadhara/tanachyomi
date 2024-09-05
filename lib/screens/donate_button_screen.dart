import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/screens/billing_address_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/noleadingspaceformatter.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';
import 'package:tanachyomi/utils/validator.dart';

class DonateButtonScreen extends StatefulWidget {
  const DonateButtonScreen({Key? key}) : super(key: key);

  @override
  State<DonateButtonScreen> createState() => _DonateButtonScreenState();
}

class _DonateButtonScreenState extends State<DonateButtonScreen> {
  List<String> price = <String>[
    "\$5\n/month",
    "\$10\n/month",
    "\$18\n/month",
    "\$36\n/month",
    "\$54\n/month",
    "\$100\n/month"
  ];

  List<bool> indexvalue = <bool>[false, false, false, false, false, false];
  TextEditingController surveyTextController = TextEditingController(text: "JohnSmith in honor of Cohen");
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
            resizeToAvoidBottomInset: true,
            body: donatebuttonbody(),
          ),
        );
      }
    );
  }

  Widget donatebuttonbody() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Image.asset(
                          "assets/images/donate.png",
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 15,
                      top: 50,
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                          child: Icon(Icons.arrow_back_ios)))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                "Monthly Commitment",
                style: TextStyle(
                    color: isdark == true ? AppColor.appColorPrimaryValue:AppColor.appColorSecondaryValue,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Text(
                "Select one of our monthly contributions or enter the amount you want",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
            paymentoption(),
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
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                // height: 100,
                padding: EdgeInsets.only(left: 10, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Message Sponsored by",
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColor.appColorPrimaryValue),
                      ),
                    ),
                    TextFormField(
                      cursorColor: AppColor.black,
                      controller: surveyTextController,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      // minLines: 1,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [NoLeadingSpaceFormatter()],
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.only(bottom: 8),
                        // constraints:
                        // BoxConstraints.tight(Size.fromHeight(40)),
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
                            "Survey is required",
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
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // elevation: MaterialStateProperty.all(0.0),
                padding: const EdgeInsets.all(10.0),
                primary: isdark == true ? AppColor.appColorSecondaryValue:AppColor.grey600,
                shadowColor: isdark == true ? AppColor.appColorSecondaryValue:AppColor.grey600,
                elevation: 2,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              onPressed: () {
                Navigator.push(context, SlideRightRoute(
                    widget: BillingAddressScreen())
                );
              },
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width / 1.15,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/coins.png",height: 20,width: 30,fit: BoxFit.fill,),
                      SizedBox(width: 2,),
                      Text(
                        "Sponsor Now",
                        style: TextStyle(color: AppColor.white),
                      ),
                    ],
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
    );
  }

  Widget paymentoption() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      padding: EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
          color: isdark == true ? AppColor.mainbg:AppColor.grey1.shade100,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Text("Choose Amount",
              style: TextStyle(
                  color: isdark == true ? AppColor.appColorPrimaryValue:AppColor.appColorSecondaryValue, fontSize: 14)),
          // SizedBox(height: 5),
          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: MediaQuery.of(context).size.height / 10),
              itemCount: 6,
              shrinkWrap: true,
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
              primary: false,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    for (int i = 0; i < indexvalue.length; i++) {
                      indexvalue[i] = false;
                    }
                    print("object"+indexvalue.toString());
                    setState(() {
                        indexvalue[index] = true;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              indexvalue[index] == true
                                  ? BoxShadow(
                                      color:
                                      isdark == true ?
                                      AppColor.appColorSecondaryValue:AppColor.appColorPrimaryValue,
                                      blurRadius: 5.0,
                                      spreadRadius: 3)
                                  : BoxShadow(
                                      color: isdark == true ? AppColor.grey1.shade800:AppColor.white,
                                      blurRadius: 0,
                                      spreadRadius: 0),
                            ],
                            color: isdark == true ? AppColor.grey1.shade800:Colors.white,
                            border: Border.all(color: indexvalue[index] == true ?isdark == true ?AppColor.appColorSecondaryValue:AppColor.appColorPrimaryValue:AppColor.grey1.shade500),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(
                            price[index],
                            style: TextStyle(
                                color: indexvalue[index] == true
                                    ? isdark == true ? AppColor.appColorSecondaryValue:AppColor.appColorPrimaryValue
                                    : isdark == true ? AppColor.white:AppColor.black),
                          ),
                        ),
                      ),
                      indexvalue[index] == true
                          ? Positioned(
                              right: 5,
                              top: 5,
                              child: Image.asset(
                                "assets/images/vector1.png",
                                fit: BoxFit.fill,
                                color: isdark == true ? AppColor.appColorSecondaryValue:null,
                                width: 20,
                                height: 20,
                              ))
                          : Container()
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }

  handleBackPress() {
    return Navigator.pop(context);
  }
}
