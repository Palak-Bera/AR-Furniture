import 'dart:io';
import 'package:arcore_flutter_plugin_example/pages/Loading.dart';
import 'package:arcore_flutter_plugin_example/pages/onBoarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart'
    show ArCoreController;


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  print('ARCORE IS AVAILABLE?');
  print(await ArCoreController.checkArCoreAvailability());

  print('\nAR SERVICES INSTALLED?');
  print(await ArCoreController.checkIsArCoreInstalled());
  await Firebase.initializeApp();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };

  runApp(
      MyApp(),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // String router = "";
    return MaterialApp(
      title: 'AR APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: HexColor(hexColor),
      ),
      // initialRoute: "home",
      // routes: {
      //   'home' : (context)=> OnBoardingPage(),
      //   // 'second' : (context)=> LoginScreen(),
      //   'Third' : (context) => HomePage(),
      //   // 'homefirst': (context) => HomeFirst(),
      //   // 'secondfirst': (context)=> HomeSecond(),
      // },
      home: 
      // OnBoardingPage(),
      StreamBuilder<User>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Loading();
            }
            return OnBoardingPage();
          }),
    );
  }
}