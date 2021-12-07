import 'package:arcore_flutter_plugin_example/constants/colors.dart';
import 'package:arcore_flutter_plugin_example/helper/productdata.dart';
import 'package:arcore_flutter_plugin_example/pages/bottomAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseManager db = DatabaseManager();
  var chairs;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    // chairs = await db.chairs();
    // print(chairs);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: firestore.collection('Product Details').doc('Details').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
          return BottomBar(data: data);
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SpinKitCubeGrid(
              color: AppColors.primary,
              size: 100.0,
            ),
          ),
        );
      },
    );
  }
}
