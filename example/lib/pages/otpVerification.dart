import 'package:arcore_flutter_plugin_example/constants/colors.dart';
import 'package:arcore_flutter_plugin_example/helper/phoneauth.dart';
import 'package:arcore_flutter_plugin_example/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:lottie/lottie.dart';

class VerifyOtpScreen extends StatefulWidget {
  // variable for store value which send by the navigator of login page
  final String phoneNo;
  const VerifyOtpScreen({Key key,  this.phoneNo}) : super(key: key);

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  var phonenumber;
  AuthClass authClass = AuthClass();
  String verificationIdFinal;
  String smsCode;

  @override
  void initState() {
    super.initState();
    phonenumber = widget.phoneNo;
    authClass.verifyPhoneNumber("$phonenumber", context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Lottie.network("https://assets7.lottiefiles.com/packages/lf20_m2dlqjva.json",
                height: 300.0,
                width: 250.0,
              ),
            ),
            Stack(
              children: [
                Container(
                  height: size.height * 0.45,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 5.0),
                      ),
                    ],
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10.0,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                            
                              padding: EdgeInsets.all(20.0),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Verification\n\n",
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "Enter the OTP send to your mobile number",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFF373A40),
                                      ),
                                    ),
                                    TextSpan(
                                      text: phonenumber,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFF373A40),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // OTP Text field
                            OtpTextField(
                              numberOfFields: 6,
                              showFieldAsBox: false,
                              borderWidth: 4.0,
                              //runs when a code is typed in
                              onCodeChanged: (String code) {
                                //handle validation or checks here if necessary
                              },
                              //runs when every textfield is filled
                              onSubmit: (String verificationCode) {
                                smsCode = verificationCode;
                                print("OTP :: $smsCode");
                              },
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Text(
                              "Didn't you receive any code?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            InkWell(
                              onTap: () => authClass.verifyPhoneNumber(phonenumber, context),
                              child: Text(
                                "Resend New Code",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Button(
                  size: size,
                  text: "Continue",
                  press: () {
                    print(smsCode);
                    if (smsCode.isNotEmpty) {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => AaengerCha()));
                      authClass.signInwithPhoneNumber(smsCode, context);
                    } else {
                      print("Logged in failed");
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
