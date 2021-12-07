// import 'package:arcore_flutter_plugin_example/pages/homePage.dart';
import 'package:arcore_flutter_plugin_example/constants/colors.dart';
import 'package:arcore_flutter_plugin_example/pages/Loading.dart';
import 'package:arcore_flutter_plugin_example/pages/home.dart';
import 'package:arcore_flutter_plugin_example/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 22.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 6.0),
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          key: introKey,
          pages: [
            PageViewModel(
              title: "Decorate your home ",
              body:
                  "Fill your space with the beauty that it deserves",
              image: _buildImage('1'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title:  "Minimal Design More Comfortness",
              body:
                  "We assure that with our product you will get maximum comfort.",
              image: _buildImage('2'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Arrange furniture in virtual way",
              body:
                  "Make a smart move by virtually setting  the furniture at your home",
              image: _buildImage('3'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Book your comfort now",
              body: "",
              image: _buildImage('4'),
              footer: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () => _onIntroEnd(context),
                      child:
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // mainAxisSize: Main,
                              children: [
                            Icon(
                              Icons.call,
                              size: 30.0,
                            ),
                            Text(
                              'Login With Phone Number',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () => signInWithGoogle(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 30.0,
                              width: 30.0,
                              child:
                                  Image.asset('assets/images/google_logo.png'),
                            ),
                            // ),
                            Text(
                              'Login With Google',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              decoration: pageDecoration,
            ),
          ],
          showSkipButton: true,
          showDoneButton: false,
          skipFlex: 0,
          nextFlex: 0,
          skip: const Text('Skip',style: TextStyle(
            color: AppColors.primary,
          ),),
          next: nextButton(),

          //  indicator button
          dotsDecorator: DotsDecorator(
            size: Size(10.0, 10.0),
            color: 
            Color(0xFFBDBDBD),
            activeColor: AppColors.primary,
            activeSize: Size(24.0, 12.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset(
        'assets/images/$assetName.png',
        scale: 0.9,
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget nextButton() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(50),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Icon(Icons.arrow_forward_ios_rounded,color: AppColors.primary,),
    );
  }

  //navigation function
  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

      UserCredential userCredential =
            await _auth.signInWithCredential(credential);
      final User user = _auth.currentUser;
      print("usercre: $userCredential");
      print("UID :: ${user.uid}");
      print("Display :: ${user.displayName}");
      print("emial::${user.email}");
      
     Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => Loading()),
            (route) => false);
    
  }
  // Future<String?> signInwithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
      // await _auth.signInWithCredentia
}
