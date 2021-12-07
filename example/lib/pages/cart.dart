import 'package:arcore_flutter_plugin_example/constants/colors.dart';
import 'package:arcore_flutter_plugin_example/constants/size_config.dart';
import 'package:arcore_flutter_plugin_example/helper/productdata.dart';
import 'package:arcore_flutter_plugin_example/pages/Loading.dart';
import 'package:arcore_flutter_plugin_example/widgets/primaryText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CollectionReference profile =
      FirebaseFirestore.instance.collection('Profile');

  int cartlength;
  var cartdata;
  int totalpay = 0;
  bool waitingcheck = true;
  bool dataisnot = true;

  getdata(userid) {
    profile
        .doc(userid)
        .collection('Cart')
        .get()
        .then((QuerySnapshot querySnapshot) {
      cartlength = querySnapshot.docs.length;
      cartdata = querySnapshot.docs;
      for (int i = 0; i < cartlength; i++) {
        totalpay = totalpay + (cartdata[i]['price']) * cartdata[i]['quantity'];
        print(totalpay);
      }
      setState(() {
        waitingcheck = false;
        if(totalpay == 0)
          dataisnot = false;
      });
    });
  }

  Future<void> deleteUser(int delid) {
    // print(userid);
    var deleteid = cartdata[delid].id;
    return profile
        .doc(userid)
        .collection('Cart')
        .doc(deleteid)
        .delete()
        .then((value) => print("Sucessfull"))
        .catchError((onError) => print("Failde $onError"));
  }

  Widget waiting() {
    return Center(
        child: CircularProgressIndicator(
      color: AppColors.primary,
      strokeWidth: 4.0,
    ));
  }

  String userid;
  @override
  void initState() {
    userid = DatabaseManager.userid;
    getdata(userid);
    print(userid);
  }

  @override
  Widget build(BuildContext context) {
    return waitingcheck
        ? waiting()
        : Scaffold(
            body: dataisnot ? ListView(
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                // head lines
                Padding(
                  padding: standardPaddingX,
                  child: PrimaryText(
                    text: "My Items",
                    size: 36,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1.5,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    cartlength,
                    (index) => cartCard(cartdata[index], index),
                    // cartCard(),
                  ),
                ),

                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),

                Padding(
                  padding: standardPaddingX,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryText(text: "Total : "),
                      PrimaryText(text: "₹$totalpay"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ) : Center(
              child: PrimaryText(
                size: 35,
                text: "Your cart is empty !",
                color: Colors.red,
              ),
            )
          );
  }

  Widget cartCard(var cartdatadoc, int ind) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 200,
          width: MediaQuery.of(context).size.width,
          // width: 600,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('${cartdatadoc["image"]}'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${cartdatadoc["label"]}",
                        style:
                            TextStyle(fontSize: 25, color: AppColors.textGray,fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "₹${cartdatadoc["price"]}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Quantity : ${cartdatadoc["quantity"]}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 5),
                      SizedBox(height: 12),
                      MaterialButton(
                        onPressed: () {
                          // setState(() {
                          //   waitingcheck = true;
                          // });
                          deleteUser(ind);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loading()));
                        },
                        color: AppColors.primaryLight,
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: AppColors.primary,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Remove",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
