import 'package:arcore_flutter_plugin_example/pages/Loading.dart';
import 'package:arcore_flutter_plugin_example/pages/onBoarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";
  String userid = "";

  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context) async {
        print("!!!!!!!!!!!!1111222223333333444455555556666667777778888888verifyphone");
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {

      showSnackBar(context, "Verification Completed");
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (builder) => BottomBar()),
      //     (route) => false);
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    };
    PhoneCodeSent codeSent =
        (String verificationID, [int forceResnedingtoken]) {
          this.verificationID = verificationID;
      showSnackBar(context, "Verification Code sent on the phone number");
      
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar(context, "Time out");
    };
    try {
      await _auth.verifyPhoneNumber(
          timeout: Duration(seconds: 30),
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInwithPhoneNumber(String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: this.verificationID, smsCode: smsCode);

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      print("!!!!!!!!!!!!1111222223333333444455555556666667777778888888vsigngngngngngphone$userCredential");
      print("!!@@@${userCredential.user.metadata.creationTime}");
      final User user = _auth.currentUser; // this is for get user id
      userid = user.uid; 
      if(userid != ""){
        print(userid);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => Loading()),
          (route) => false);
      }else{
        showSnackBar(context, "Invalid Otp Code");
      }

      showSnackBar(context, "logged In");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> signOut(context) async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (builder) => OnBoardingPage()),
          (route) => false);
  }
}
