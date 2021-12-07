import 'package:flutter/material.dart';

const EdgeInsets standardPaddingX = EdgeInsets.only(left: 25, right: 25);
const EdgeInsets standardPaddingY = EdgeInsets.symmetric(vertical: 20 , horizontal: 25);

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static Size size;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}
