import 'package:arcore_flutter_plugin_example/constants/colors.dart';
import 'package:arcore_flutter_plugin_example/helper/phoneauth.dart';
import 'package:arcore_flutter_plugin_example/widgets/primaryText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthClass auth = AuthClass();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(color: AppColors.primary, fontSize: 25),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 10),
          //     child: Icon(Icons.edit,color: AppColors.primary,size: 35,),
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              // Text("Profile",style: TextStyle(),textAlign: TextAlign.start,),
              ProfilePic(),
              SizedBox(height: 20),
              PrimaryText(
                text: "Mayank Chhatraya",
                color: AppColors.primary,
                size: 28,
              ),
              SizedBox(
                height: 10,
              ),
              PrimaryText(
                text: "+91 9054730952",
                color: AppColors.primary,
                size: 20,
              ),
              SizedBox(height: 40),
              // Padding(
              //   padding: standardPaddingX,
              //   child: ListTile(
              //     title: Text("Address"),
              //     subtitle: Text("HIHIHHIIHI"),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 10),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       color: AppColors.primaryLight,
              //     ),
              //     child: Column(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             "Address",
              //             textAlign: TextAlign.left,
              //             style: TextStyle(
              //               fontSize: 20.0,
              //             ),
              //           ),
              //         ),
              //         ListTile(
              //           leading: Icon(
              //             Icons.house_sharp,
              //             size: 36,
              //             color: AppColors.primary,
              //           ),
              //           title: PrimaryText(
              //             text: "Devajinagr P-2, Surat",
              //             color: AppColors.primary,
              //             size: 15,
              //           ),
              //           trailing: InkWell(
              //               child: Icon(
              //             Icons.edit,
              //             size: 36,
              //             color: AppColors.primary,
              //           )),
              //           // subtitle: Text('This is subtitle'),
              //           selected: true,
              //           onTap: () {},
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              SizedBox(
                height: 20,
              ),

              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 10),
              //   child: Container(
              //     color: AppColors.primaryLight,
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Row(
              //         children: [
              //           Icon(
              //             Icons.house_sharp,
              //             size: 36,
              //             color: AppColors.primary,
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           PrimaryText(
              //             text: "Devajinagr P-2, Surat",
              //             color: AppColors.primary,
              //             size: 15,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              ProfileMenu(
                "Address : \n Devajinagar surat gujarat indin world",
                "assets/icons/User Icon.svg",
                () => {},
              ),
              ProfileMenu(
                "Notifications",
                "assets/icons/Bell.svg",
                () {},
              ),
              ProfileMenu(
                "Settings",
                "assets/icons/Settings.svg",
                () {},
              ),
              ProfileMenu(
                "Help Center",
                "assets/icons/Question mark.svg",
                () {},
              ),
              ProfileMenu(
                "Log Out",
                "assets/icons/Log out.svg",
                () {
                  auth.signOut(context);
                },
              ),
              // SizedBox(
              //   height: 100,
              //   width: MediaQuery.of(context).size.width * .9,
              //   child: Container(
              //     color: Colors.deepOrange[50],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget ProfileMenu(text, icon, press) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.orange,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: Colors.orange,
              width: 22,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/Profile Image.png"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
