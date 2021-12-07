import 'package:arcore_flutter_plugin_example/constants/colors.dart';
import 'package:flutter/material.dart';





class PrimaryText extends StatelessWidget {
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final TextAlign textAlign;

  PrimaryText(
      {this.size: 20,
      this.text,
      this.fontWeight: FontWeight.w600,
      this.color: AppColors.black,
      this.textAlign: TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontFamily: 'Roboto',
          fontWeight: fontWeight,
          fontSize: size,),
    );
  }
}
