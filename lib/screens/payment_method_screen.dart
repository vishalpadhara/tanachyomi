import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/screens/home_screen.dart';
import 'package:tanachyomi/screens/thankyou_donation_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/noleadingspaceformatter.dart';
import 'package:tanachyomi/utils/paypal/paypalpayment.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';
import 'package:tanachyomi/utils/validator.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  TextEditingController nameTextController =
      TextEditingController(text: "John Smith");
  TextEditingController exdateTextController =
      TextEditingController(text: "06 / 2024");
  TextEditingController cardTextController =
      TextEditingController(text: "1234 1234 1234 1234");
  TextEditingController cvvTextController = TextEditingController(text: "123");
  BestTutorSite _site = BestTutorSite.Paypal;
  bool isdark = false;
  String? gender;
  bool ispaypal = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      isdark = theme.getTheme() == theme.darkTheme ? true : false;
        return WillPopScope(
          onWillPop: (){
            return handleBackPress();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: paymentmethodbody(),
          ),
        );
      }
    );
  }

  Widget paymentmethodbody() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 1.8,

                        child: isdark == true ? Image.asset(
                          "assets/images/amicodark.png",
                          alignment: Alignment.bottomCenter,
                        ):Image.asset(
                          "assets/images/amico.png",
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 15,
                      top: 50,
                      child: InkWell(
                          onTap: () {
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
                "Payment Method",
                style: TextStyle(
                    color: isdark == true ? AppColor.appColorPrimaryValue:AppColor.appColorSecondaryValue,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: (){
                setState((){
                  ispaypal = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: isdark == true ? AppColor.mainbg:AppColor.grey1.shade200,
                    border: Border.all(color: isdark == true ? AppColor.mainbg:AppColor.grey1.shade400),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              ispaypal == false ? "assets/images/vector3.png":"assets/images/vector5.png",
                              height: 20,
                              width: 20,
                              color: isdark == true ? AppColor.appColorPrimaryValue:null,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Pay with Credit Card",
                              style: TextStyle(
                                  color: isdark == true ? AppColor.white:AppColor.grey600,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/visa.png",
                              height: 30,
                              width: 40,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              "assets/images/mastercard.png",
                              height: 30,
                              width: 40,
                              fit: BoxFit.fill,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1, right: 1),
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: isdark == true ? AppColor.grey1.shade800:AppColor.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.white)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "Name on Card",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.appColorPrimaryValue),
                                    ),
                                  ),
                                  TextFormField(
                                    cursorColor: AppColor.black,
                                    controller: nameTextController,
                                    style: TextStyle(fontSize: 12),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[^\S*]")),
                                      NoLeadingSpaceFormatter()
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: 10),
                                      constraints: BoxConstraints.tight(
                                          Size.fromHeight(35)),
                                      border: InputBorder.none,
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            color: AppColor.grey600,
                                            fontSize: 14.0,
                                          ),
                                      // labelText: "Email",
                                    ),
                                    textInputAction: TextInputAction.next,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      return Validator.validateFormField(
                                          value,
                                          "name is required",
                                          null,
                                          Constants.NORMAL_VALIDATION);
                                    },
                                    // onFieldSubmitted: (String value) {
                                    //   FocusScope.of(context).requestFocus(secondFocusNode);
                                    // },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 1),
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: isdark == true ? AppColor.grey1.shade800:AppColor.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.white)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "Expiry",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.appColorPrimaryValue),
                                    ),
                                  ),
                                  TextFormField(
                                    style: TextStyle(fontSize: 12),
                                    cursorColor: AppColor.black,
                                    controller: exdateTextController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[^\S*]")),
                                      NoLeadingSpaceFormatter()
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: 10),
                                      constraints: BoxConstraints.tight(
                                          Size.fromHeight(35)),
                                      border: InputBorder.none,
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            color: AppColor.grey600,
                                            fontSize: 14.0,
                                          ),
                                      // labelText: "Email",
                                    ),
                                    textInputAction: TextInputAction.next,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      return Validator.validateFormField(
                                          value,
                                          "Expiry is required",
                                          null,
                                          Constants.NORMAL_VALIDATION);
                                    },
                                    // onFieldSubmitted: (String value) {
                                    //   FocusScope.of(context).requestFocus(secondFocusNode);
                                    // },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1, right: 1),
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: isdark == true ? AppColor.grey1.shade800:AppColor.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.white)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "Card Number",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.appColorPrimaryValue),
                                    ),
                                  ),
                                  TextFormField(
                                    cursorColor: AppColor.black,
                                    controller: cardTextController,
                                    style: TextStyle(fontSize: 12),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[^\S*]")),
                                      NoLeadingSpaceFormatter()
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: 10),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(right:8.0),
                                        child: Image.asset("assets/images/mastercard.png",width:30,height: 15
                                          ,fit: BoxFit.fill,),
                                      ),
                                      prefixIconConstraints: BoxConstraints(maxHeight: 15,maxWidth: 30),
                                      constraints: BoxConstraints.tight(
                                          Size.fromHeight(35)),
                                      border: InputBorder.none,
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            color: AppColor.grey600,
                                            fontSize: 14.0,
                                          ),
                                      // labelText: "Email",
                                    ),

                                    textInputAction: TextInputAction.next,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      return Validator.validateFormField(
                                          value,
                                          "Card Number is required",
                                          null,
                                          Constants.NORMAL_VALIDATION);
                                    },
                                    // onFieldSubmitted: (String value) {
                                    //   FocusScope.of(context).requestFocus(secondFocusNode);
                                    // },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 1),
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: isdark == true ? AppColor.grey1.shade800:AppColor.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.white)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "CVV",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.appColorPrimaryValue),
                                    ),
                                  ),
                                  TextFormField(
                                    style: TextStyle(fontSize: 12),
                                    cursorColor: AppColor.black,
                                    controller: cvvTextController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[^\S*]")),
                                      NoLeadingSpaceFormatter()
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: 10),
                                      constraints: BoxConstraints.tight(
                                          Size.fromHeight(35)),
                                      border: InputBorder.none,
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            color: AppColor.grey600,
                                            fontSize: 14.0,
                                          ),
                                      // labelText: "Email",
                                    ),
                                    textInputAction: TextInputAction.next,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.number,
                                    obscureText: true,
                                    obscuringCharacter: "*",
                                    validator: (value) {
                                      return Validator.validateFormField(
                                          value,
                                          "CVV is required",
                                          null,
                                          Constants.NORMAL_VALIDATION);
                                    },
                                    // onFieldSubmitted: (String value) {
                                    //   FocusScope.of(context).requestFocus(secondFocusNode);
                                    // },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Card(
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        child:
                        ListTile(
                          title: Text('Paypal',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          subtitle: Text(
                            "You will be redirected to the PayPal website after submitting your order",
                            style: TextStyle(fontSize: 10),
                          ),
                          leading: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Image.asset(
                              ispaypal == false ? "assets/images/vector5.png" : "assets/images/vector3.png",
                              fit: BoxFit.fill,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          // toggleable: false,
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 1.0, vertical: 1),
                          // value: "other"/*BestTutorSite.Paypal*/,
                          // groupValue: gender/*_site*/,
                          onTap: () {
                            if(ispaypal == true){
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) =>
                                      PaypalPayment(onFinish: (number) async {
                                        print("Order id : " + number);
                                      },)));
                            }
                            setState(() {
                              ispaypal = true;
                              // gender = value.toString();
                            });
                          },
                        ),
                        // RadioListTile(
                        //   title: Text('Paypal',
                        //       style: TextStyle(fontWeight: FontWeight.w500)),
                        //   subtitle: Text(
                        //     "You will be redirected to the PayPal website after submitting your order",
                        //     style: TextStyle(fontSize: 10),
                        //   ),
                        //   toggleable: false,
                        //   contentPadding: EdgeInsets.symmetric(horizontal: 1.0,vertical: 1),
                        //   value: "other"/*BestTutorSite.Paypal*/,
                        //   groupValue: gender/*_site*/,
                        //   onChanged: (value){
                        //     setState(() {
                        //       gender = value.toString();
                        //     });
                        //   },
                        // ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(right: 10,top: 10),
                        child: Image.asset(
                          "assets/images/paypal.png",
                          width: 40,
                          height: 30,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: AppColor.appColorPrimaryValue,radius: 16,child: Icon(Icons.lock_outline,color: AppColor.white,)),
                  title: Text(
                      "We protect your payment information using encryption to provide bank-level security.",style: TextStyle(fontSize: 12))),
            ),
            SizedBox(
              height: 30,
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
                // Navigator.push(context, SlideRightRoute(
                //     widget: ThankYouDonationScreen())
                // );
                showDialog(
                  context: context,
                  useSafeArea: true,
                  builder: (_) => /*SponsorScreen()*/ThankYouDonationdialog(),
                );
              },
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width / 1.2,
                child: Center(
                  child: Text(
                    "Submit",
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

  Widget ThankYouDonationdialog(){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(15.0),
        // height: MediaQuery.of(context).size.height/1.4,
        color: Colors.transparent,
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
                    height: MediaQuery.of(context).size.height / 4.3,
                    width: MediaQuery.of(context).size.width / 2.1,
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
                  height: 10,
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
                  height: 10,
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
                    style: TextStyle(fontSize: 16),
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
      ),
    );
  }

}

enum BestTutorSite { Paypal }
