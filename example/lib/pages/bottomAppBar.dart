import 'package:arcore_flutter_plugin_example/constants/colors.dart';
import 'package:arcore_flutter_plugin_example/constants/size_config.dart';
import 'package:arcore_flutter_plugin_example/helper/productdata.dart';
import 'package:arcore_flutter_plugin_example/pages/cart.dart';
import 'package:arcore_flutter_plugin_example/pages/category.dart';
import 'package:arcore_flutter_plugin_example/pages/home.dart';
import 'package:arcore_flutter_plugin_example/pages/profile.dart';
import 'package:arcore_flutter_plugin_example/widgets/primaryText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
// import 'package:furniture_app/pages/cart.dart';
// import 'package:furniture_app/pages/category.dart';

// import 'package:furniture_app/pages/home.dart';


// Stateful widget created
class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
  var data;
  // BottomBar({Key key}) : super(key: key);
  BottomBar({Key key,  this.data}) : super(key: key);
}

class _BottomBarState extends State<BottomBar> {
// index given for tabs
  int currentIndex = 0;
  var PData;
  DatabaseManager db = DatabaseManager();
    
  var chairss ;
  @override
  void initState(){
    super.initState();
    final auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    var userid = user.uid;
    PData = widget.data;
    db.saveData(PData,userid);
   
    // print("********//////85233674$PData");
  }
  
  // Method for index value
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

// Number of tabs
  final tabs = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    ProfilePage(),
    // LoginScreen(),
    // LoginScreen(),
    // HomePage(data : ),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: currentIndex,
        children: tabs,
      ),
      // bottom app bar
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        shape: CircularNotchedRectangle(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // button 1
              GestureDetector(
                onTap: () {
                  setBottomBarIndex(0);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: currentIndex == 0
                            ? AppColors.primaryLight
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/home.svg',
                          width: 20,
                          color: currentIndex == 0
                              ? AppColors.primary
                              : Colors.grey,
                        ),
                        currentIndex == 0
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: PrimaryText(
                                    text: 'Home',
                                    size: 16,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700),
                              )
                            : SizedBox()
                      ],
                    )),
              ),
              // button 2
              GestureDetector(
                onTap: () {
                  setBottomBarIndex(1);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: currentIndex == 1
                            ? AppColors.primaryLight
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/category.svg',
                          width: 20,
                          color: currentIndex == 1
                              ? AppColors.primary
                              : Colors.grey,
                        ),
                        currentIndex == 1
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: PrimaryText(
                                    text: 'Category',
                                    size: 16,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700),
                              )
                            : SizedBox()
                      ],
                    )),
              ),
              // button 3
              GestureDetector(
                onTap: () {
                  setBottomBarIndex(2);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: currentIndex == 2
                            ? AppColors.primaryLight
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/cart.svg',
                          width: 20,
                          color: currentIndex == 2
                              ? AppColors.primary
                              : Colors.grey,
                        ),
                        currentIndex == 2
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: PrimaryText(
                                    text: 'Cart',
                                    size: 16,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700),
                              )
                            : SizedBox()
                      ],
                    ),),
              ),
              // button 4
               GestureDetector(
                onTap: () {
                  setBottomBarIndex(3);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: currentIndex == 3
                          ? AppColors.primaryLight
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/user.svg',
                        width: 20,
                        color:
                            currentIndex == 3 ? AppColors.primary : Colors.grey,
                      ),
                      currentIndex == 3
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: PrimaryText(
                                  text: 'Profile',
                                  size: 16,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

