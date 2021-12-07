import 'package:arcore_flutter_plugin_example/Tryin3D.dart';
import 'package:arcore_flutter_plugin_example/constants/colors.dart';
import 'package:arcore_flutter_plugin_example/constants/size_config.dart';
import 'package:arcore_flutter_plugin_example/helper/productdata.dart';
import 'package:arcore_flutter_plugin_example/pages/Loading.dart';
import 'package:arcore_flutter_plugin_example/widgets/primaryText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final String image;
  final String label;
  final int price;
  int quantity;
  ProductDetail(this.image, this.label, this.price, this.quantity);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        height: SizeConfig.screenHeight,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 50),
              height: 500,
              // SizeConfig.screenHeight / 1.7,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.image), fit: BoxFit.cover)),
              child: Padding(
                padding: standardPaddingX,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      fit: FlexFit.loose,
                      child: RawMaterialButton(
                        elevation: 2,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        constraints: BoxConstraints(minWidth: 10, maxWidth: 50),
                        child: Icon(Icons.chevron_left,
                            color: AppColors.black, size: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fillColor: AppColors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.loose,
                      child: RawMaterialButton(
                        elevation: 2,
                        onPressed: () {},
                        constraints: BoxConstraints(
                          minWidth: 10,
                        ),
                        child: Icon(Icons.favorite_border,
                            color: AppColors.black, size: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fillColor: AppColors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
              transform: Matrix4.translationValues(0, -30, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: AppColors.white,
              ),
              width: SizeConfig.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // small line
                  Center(
                    child: Container(
                      width: 50.0,
                      height: 6.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    // SizeConfig.blockSizeVertical * 3.5,
                  ),
                  // lable
                  PrimaryText(
                      text: widget.label.toString(),
                      size: 26,
                      fontWeight: FontWeight.w700),
                  SizedBox(
                    height: 10,
                    // SizeConfig.blockSizeVertical * 2.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // pricce
                      PrimaryText(
                        text: "₹${widget.price.toString()}",
                        size: 32,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                      // counter
                      SizedBox(
                        child: Row(
                          children: [
                            RawMaterialButton(
                              constraints: BoxConstraints(minWidth: 0),
                              onPressed: () {
                                setState(() {
                                  if (widget.quantity > 1) {
                                    widget.quantity--;
                                    print(widget.quantity);
                                  } else {}
                                });
                              },
                              elevation: 0,
                              child: Icon(
                                Icons.remove,
                                color: AppColors.textGray,
                                size: 20,
                              ),
                              fillColor: Colors.grey[200],
                              padding: EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            PrimaryText(
                              text: "${widget.quantity}",
                              size: 18,
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RawMaterialButton(
                              constraints: BoxConstraints(minWidth: 0),
                              elevation: 0,
                              onPressed: () {
                                setState(() {
                                  print(widget.quantity);
                                  widget.quantity++;
                                  print(widget.quantity);
                                });
                              },
                              child: Icon(
                                Icons.add,
                                color: AppColors.textGray,
                                size: 20,
                              ),
                              fillColor: Colors.grey[200],
                              padding: EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    // SizeConfig.blockSizeVertical * 2,
                  ),
                  // PrimaryText(
                  //   text:
                  //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                  //   size: 17,
                  //   color: Colors.grey[500],
                  //   fontWeight: FontWeight.w500,
                  // ),
                  Row(
                    mainAxisAlignment : MainAxisAlignment.spaceBetween,
                    children: [
                      //           TextButton(
                      //             style: TextButton.styleFrom(
                      //               primary: Colors.blue,
                      //               onSurface: Colors.red,
                      //             ),
                      //             onPressed: (){
                      //             Navigator.push(context,
                      // MaterialPageRoute(builder: (context) => CheckImage(testimagepath: widget.image,)));},
                      //             child: Text('Check Image'),
                      //           ),
                      // Try in 3D
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Tryin3D(widget.image)));
                        },
                        child: PrimaryText(
                            text: "Try in 3D", color: AppColors.white, size: 18),
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 15)),
                      ),

                      //Add To Cart
                      ElevatedButton(
                        onPressed: () async {
                          var userid = DatabaseManager.userid;
                          adddatatocard(userid, widget.image, widget.label,
                              widget.price, widget.quantity);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loading()));
                        },
                        child: PrimaryText(
                            text: "ADD TO Cart", color: AppColors.white, size: 18),
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 15)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  adddatatocard(
      String userid, String image, String label, int price, int quantity) {
    return FirebaseFirestore.instance
        .collection('Profile')
        .doc(userid)
        .collection('Cart')
        .add({
      'image': image,
      'label': label,
      'price': price,
      'quantity': quantity,
    });
  }
}
