import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;


class Tryin3D extends StatefulWidget {
  final String image;
  Tryin3D(this.image);

  @override
  _Tryin3DState createState() => _Tryin3DState();
}

class _Tryin3DState extends State<Tryin3D> {
  // static String routeName = "/Aaenger";

  ArCoreController arCoreController;

  String result;
  @override
  void initState() {

    super.initState();
    result = widget.image.replaceAll('.PNG', '-ar.png');
  }

  @override
  void dispose() {
    super.dispose();
    arCoreController.dispose();
  }

  void WhenArCoreViewCreated(ArCoreController arCore){
    arCoreController = arCore;
    arCoreController.onPlaneTap = controlOnPlaneTap;
  }

  void controlOnPlaneTap(List<ArCoreHitTestResult> hitResults){
    final hit = hitResults.first;
    print("Tap On Image");
    // Add character
    addcharacter(hit);
  }

  Future addcharacter(ArCoreHitTestResult hit) async{
    final bytes = (await rootBundle.load(result)).buffer.asUint8List();

    final characterPos = ArCoreNode(
      image: ArCoreImage(bytes: bytes,width: 250,height: 250),
      position: hit.pose.translation + vector.Vector3( 0.0,0.0,0.0),
      rotation: hit.pose.rotation + vector.Vector4(0.0,0.0,0.0,0.0),
    );

    arCoreController.addArCoreNodeWithAnchor(characterPos);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("AR Avenger"),
      //   centerTitle: true,
      // ),
      body: ArCoreView(
        onArCoreViewCreated: WhenArCoreViewCreated,
        enableTapRecognizer: true,
      ),
    );
  }
}
