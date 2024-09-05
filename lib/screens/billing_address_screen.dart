import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/screens/payment_method_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/noleadingspaceformatter.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';
import 'package:tanachyomi/utils/validator.dart';

class BillingAddressScreen extends StatefulWidget {
  const BillingAddressScreen({Key? key}) : super(key: key);

  @override
  State<BillingAddressScreen> createState() => _BillingAddressScreenState();
}

class _BillingAddressScreenState extends State<BillingAddressScreen> {
  TextEditingController fnameTextController =
  TextEditingController(text: "John");
  TextEditingController lnameTextController =
  TextEditingController(text: "Smith");
  TextEditingController emailTextController =
  TextEditingController(text:"johnpaul@myemail.com");
  TextEditingController addressTextController =
  TextEditingController();
  TextEditingController cityTextController =
  TextEditingController(text:"California");
  TextEditingController stateTextController =
  TextEditingController(text:"Los Angeles");
  TextEditingController zipTextController =
  TextEditingController(text:"22341");
  TextEditingController ccodeTextController =
  TextEditingController(text:"US");
  TextEditingController phoneTextController =
  TextEditingController(text:"+1 (555) 000-0000");
  bool isdark = false;
  final CountryDetails? details = CountryCodes.detailsForLocale(Locale('US','US'));

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
            body: billingbody(),
          ),
        );
      }
    );
  }

  Widget billingbody(){
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
                "Billing Address",
                style: TextStyle(
                    color: isdark == true ? AppColor.appColorPrimaryValue:AppColor.appColorSecondaryValue,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:5.0),
                            child: Text("First Name",style: TextStyle(fontSize: 14,color: AppColor.appColorPrimaryValue),),
                          ),
                          TextFormField(
                            cursorColor: AppColor.black,
                            controller: fnameTextController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp("[^\*]")),
                              NoLeadingSpaceFormatter()
                            ],
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 10),
                                constraints: BoxConstraints.tight(Size.fromHeight(
                                    35)),
                                border: InputBorder. none,
                                labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: AppColor.grey600,
                                  fontSize: 14.0,
                                ),
                              // labelText: "Email",
                            ),
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validator.validateFormField(
                                  value,
                                  "firstname is required",
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
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:5.0),
                            child: Text("Last Name",style: TextStyle(fontSize: 14,color: AppColor.appColorPrimaryValue),),
                          ),
                          TextFormField(
                            cursorColor: AppColor.black,
                            controller: lnameTextController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp("[^\*]")),
                              NoLeadingSpaceFormatter()
                            ],
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 10),
                                constraints: BoxConstraints.tight(Size.fromHeight(
                                    35)),
                                border: InputBorder. none,
                                labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: AppColor.grey600,
                                  fontSize: 14.0,
                                ),
                              // labelText: "Email",
                            ),
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validator.validateFormField(
                                  value,
                                  "Lastname is required",
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:5.0),
                      child: Text("Email",style: TextStyle(fontSize: 14,color: AppColor.appColorPrimaryValue),),
                    ),
                    TextFormField(
                      cursorColor: AppColor.black,
                      controller: emailTextController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[^\*]")),
                        NoLeadingSpaceFormatter()
                      ],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10),
                          constraints: BoxConstraints.tight(Size.fromHeight(
                              35)),
                          border: InputBorder. none,
                          labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppColor.grey600,
                            fontSize: 14.0,
                          ),
                          icon: Icon(Icons.mail,color: AppColor.iconValue)
                        // labelText: "Email",
                      ),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return Validator.validateFormField(
                            value,
                            "Email is required",
                            "Invalid Email",
                            Constants.EMAIL_VALIDATION);
                      },
                      // onFieldSubmitted: (String value) {
                      //   FocusScope.of(context).requestFocus(secondFocusNode);
                      // },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:5.0),
                      child: Text("Street Address",style: TextStyle(fontSize: 14,color: AppColor.appColorPrimaryValue),),
                    ),
                    TextFormField(
                      cursorColor: AppColor.black,
                      controller: addressTextController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[^\*]")),
                        NoLeadingSpaceFormatter()
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10),
                        constraints: BoxConstraints.tight(Size.fromHeight(
                            35)),
                        border: InputBorder. none,
                        labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppColor.grey600,
                          fontSize: 14.0,
                        ),
                        // labelText: "Email",
                      ),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return Validator.validateFormField(
                            value,
                            "Address is required",
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:5.0),
                      child: Text("City",style: TextStyle(fontSize: 14,color: AppColor.appColorPrimaryValue),),
                    ),
                    TextFormField(
                      cursorColor: AppColor.black,
                      controller: cityTextController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[^\*]")),
                        NoLeadingSpaceFormatter()
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10),
                        constraints: BoxConstraints.tight(Size.fromHeight(
                            35)),
                        border: InputBorder. none,
                        labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppColor.grey600,
                          fontSize: 14.0,
                        ),
                        suffixIcon: Icon(Icons.keyboard_arrow_down,size: 20,color:isdark == true ? AppColor.white:AppColor.mainbg)
                        // labelText: "Email",
                      ),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return Validator.validateFormField(
                            value,
                            "City is required",
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
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:5.0),
                            child: Text("State/Province",style: TextStyle(fontSize: 14,color: AppColor.appColorPrimaryValue),),
                          ),
                          TextFormField(
                            cursorColor: AppColor.black,
                            controller: stateTextController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp("[^\*]")),
                              NoLeadingSpaceFormatter()
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 10),
                              constraints: BoxConstraints.tight(Size.fromHeight(
                                  35)),
                              border: InputBorder. none,
                              labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: AppColor.grey600,
                                fontSize: 14.0,
                              ),
                                suffixIcon: Icon(Icons.keyboard_arrow_down,size: 20,color:isdark == true ? AppColor.white:AppColor.mainbg)
                              // labelText: "Email",
                            ),
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validator.validateFormField(
                                  value,
                                  "State is required",
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
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:5.0),
                            child: Text("Zip Code",style: TextStyle(fontSize: 14,color: AppColor.appColorPrimaryValue),),
                          ),
                          TextFormField(
                            cursorColor: AppColor.black,
                            controller: zipTextController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp("[^\*]")),
                              NoLeadingSpaceFormatter()
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 10),
                              constraints: BoxConstraints.tight(Size.fromHeight(
                                  35)),
                              border: InputBorder. none,
                              labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: AppColor.grey600,
                                fontSize: 14.0,
                              ),
                                suffixIcon: Icon(Icons.keyboard_arrow_down,size: 20,color:isdark == true ? AppColor.white:AppColor.mainbg)
                              // labelText: "Email",
                            ),
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validator.validateFormField(
                                  value,
                                  "Zip Code is required",
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:5.0),
                      child: Text("Phone",style: TextStyle(fontSize: 14,color: AppColor.appColorPrimaryValue),),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex:1,
                          child:Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(details!.alpha2Code.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                                // SizedBox(width: 5,),
                                Icon(Icons.keyboard_arrow_down,size: 20,color: isdark == true ? AppColor.white:AppColor.mainbg)
                              ],
                            ),
                          )
                          // TextFormField(
                          //   cursorColor: AppColor.black,
                          //   controller: ccodeTextController,
                          //   inputFormatters: [
                          //     FilteringTextInputFormatter.allow(RegExp("[^\S*]")),
                          //     NoLeadingSpaceFormatter()
                          //   ],
                          //   decoration: InputDecoration(
                          //       contentPadding: EdgeInsets.only(bottom: 10),
                          //       constraints: BoxConstraints.tight(Size.fromHeight(
                          //           35)),
                          //       border: InputBorder. none,
                          //       labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          //         color: AppColor.grey600,
                          //         fontSize: 14.0,
                          //       ),
                          //       suffixIcon: Icon(Icons.keyboard_arrow_down,size: 20,color:isdark == true ? AppColor.white:AppColor.mainbg)
                          //     // labelText: "Email",
                          //   ),
                          //   textInputAction: TextInputAction.next,
                          //   autovalidateMode: AutovalidateMode.onUserInteraction,
                          //   keyboardType: TextInputType.text,
                          //   validator: (value) {
                          //     return Validator.validateFormField(
                          //         value,
                          //         "Country Code is required",
                          //         null,
                          //         Constants.NORMAL_VALIDATION);
                          //   },
                          //   // onFieldSubmitted: (String value) {
                          //   //   FocusScope.of(context).requestFocus(secondFocusNode);
                          //   // },
                          // ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          flex: 6,
                          child: TextFormField(
                            cursorColor: AppColor.black,
                            controller: phoneTextController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp("[^\*]")),
                              NoLeadingSpaceFormatter()
                            ],
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 10),
                                constraints: BoxConstraints.tight(Size.fromHeight(
                                    35)),
                                border: InputBorder. none,
                                labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: AppColor.grey600,
                                  fontSize: 14.0,
                                ),
                              // labelText: "Email",
                            ),
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validator.validateFormField(
                                  value,
                                  "Phone is required",
                                  null,
                                  Constants.NORMAL_VALIDATION);
                            },
                            // onFieldSubmitted: (String value) {
                            //   FocusScope.of(context).requestFocus(secondFocusNode);
                            // },
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
              // padding: EdgeInsets.only(left: 15,right: 15),
              child: Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Checkbox(
                      splashRadius: 10,
                      value: false, onChanged: (bool? value) {  },
                      // onChanged: (bool value) {
                      //   setState(() {
                      //     // this.value = value;
                      //   });
                      // },
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex:8,
                    child: Text(
                      'My billing and shipping adress are the same',
                      style: TextStyle(fontSize: 15),
                    ),
                  ), //Text//SizedBox
                  /** Checkbox Widget **/

                ],
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // elevation: MaterialStateProperty.all(0.0),
                padding: const EdgeInsets.all(10.0),
                primary: isdark == true ? AppColor.appColorSecondaryValue:AppColor.grey600,
                shadowColor: isdark == true ? AppColor.appColorPrimaryValue:AppColor.grey600,
                elevation: 2,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              onPressed: () {
                Navigator.push(context, SlideRightRoute(widget: PaymentMethodScreen()));
              },
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width / 1.2,
                child: Center(
                  child: Text(
                    "Next",
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
