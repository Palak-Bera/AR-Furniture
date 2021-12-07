import 'package:arcore_flutter_plugin_example/pages/Loading.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //where to go
      home:  Loading(),
      // Scaffold(
      //   appBar: AppBar(
      //     title: Text("Hello World - ArCore Pluggin"),
      //   ),
      // ),
    );
  }
}
