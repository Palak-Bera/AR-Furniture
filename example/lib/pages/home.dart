import 'package:arcore_flutter_plugin_example/constants/colors.dart';
import 'package:arcore_flutter_plugin_example/constants/size_config.dart';
import 'package:arcore_flutter_plugin_example/helper/productdata.dart';
import 'package:arcore_flutter_plugin_example/pages/productDetail.dart';
import 'package:arcore_flutter_plugin_example/widgets/primaryText.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCategory = 0;
  // List selectedChairList = chairs;
  Map<dynamic,dynamic> selectedSofaList,selectedChairList,selectedCupboardList,selectedTableList,selectedBedList; 
  // = sofas;

  DatabaseManager db = DatabaseManager();
  var chairss ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chairss = DatabaseManager.maindata;
    selectedChairList = chairss['chairs'];
    selectedSofaList = chairss['sofas'];
    selectedCupboardList = chairss['cupboards'];
    selectedTableList = chairss['table'];
    selectedBedList = chairss['bed'];
  }
  // var ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
          ),
          // head lines
          Padding(
            padding: standardPaddingX,
            child: PrimaryText(
              text: "Discover Your best Furniture",
              size: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          // Search bar
          Padding(
            padding: standardPaddingX,
            child: TextField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[300]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[200]),
                  ),
                  contentPadding: EdgeInsets.all(15),
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      fontSize: 18),
                  prefixIcon:
                      Icon(Icons.search, size: 30, color: Colors.black)),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          //Popular font
          Padding(
            padding: standardPaddingX,
            child: Text("Popular",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
          ),
          // chairs
          Padding(
            padding: standardPaddingX,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                2,
                (index) => productCard(
                    context,
                    selectedChairList['$index']['image'],
                    selectedChairList['$index']['label'],
                    selectedChairList['$index']['price'],
                    selectedChairList['$index']['quantity'],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //sofa
          Padding(
            padding: standardPaddingX,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                2,
                (index) => productCard(
                    context,
                    selectedSofaList["$index"]["image"],
                    selectedSofaList["$index"]["label"],
                    selectedSofaList["$index"]["price"],
                    selectedSofaList["$index"]["quantity"],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //table
          Padding(
            padding: standardPaddingX,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                2,
                (index) => productCard(
                    context,
                    selectedTableList["$index"]["image"],
                    selectedTableList["$index"]["label"],
                    selectedTableList["$index"]["price"],
                    selectedTableList["$index"]["quantity"],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //cupboards
          Padding(
            padding: standardPaddingX,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                2,
                (index) => productCard(
                    context,
                    selectedCupboardList["$index"]["image"],
                    selectedCupboardList["$index"]["label"],
                    selectedCupboardList["$index"]["price"],
                    selectedCupboardList["$index"]["quantity"],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //bed
          Padding(
            padding: standardPaddingX,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                2,
                (index) => productCard(
                    context,
                    selectedBedList['$index']['image'],
                    selectedBedList['$index']['label'],
                    selectedBedList['$index']['price'],
                    selectedBedList['$index']['quantity'],
                    ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }

  Widget productCard(
      BuildContext context, String image, String label, int price , int quantity) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetail(image, label,price, quantity)));
      },
      child: Hero(
        tag: image,
        child: Container(
          height: SizeConfig.blockSizeVertical * 30,
          width: 
          // 120,
          (SizeConfig.screenWidth - 60) / 2,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: TextStyle(
                                fontSize: 16, color: AppColors.textGray),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "₹$price",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
