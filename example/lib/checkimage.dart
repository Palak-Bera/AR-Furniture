import 'package:flutter/material.dart';


class CheckImage extends StatefulWidget {
  final String testimagepath;
  const CheckImage({ Key key , this.testimagepath}) : super(key: key);

  @override
  _CheckImageState createState() => _CheckImageState();
}

class _CheckImageState extends State<CheckImage> {
  String result;
  @override
  void initState() {
 
    super.initState();
    result = widget.testimagepath.replaceAll('.PNG', '-ar.png');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(result),
    );
  }
}