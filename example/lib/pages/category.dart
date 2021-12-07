import 'package:arcore_flutter_plugin_example/constants/colors.dart';
import 'package:arcore_flutter_plugin_example/constants/size_config.dart';
import 'package:arcore_flutter_plugin_example/helper/productdata.dart';
import 'package:arcore_flutter_plugin_example/models/constant.dart';
import 'package:arcore_flutter_plugin_example/pages/productDetail.dart';
import 'package:arcore_flutter_plugin_example/widgets/primaryText.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int selectedCategoryPage = 0;
  Map<dynamic, dynamic> details, selectedCategoryPageList;
  @override
  void initState() {
   
    super.initState();
    details = DatabaseManager.maindata;
    selectedCategoryPageList = details['chairs'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: PrimaryText(
              text: "Category",
              size: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
          // SizedBox(height: SizeConfig.blockSizeVertical * 3),
          // Category name listview
          SizedBox(
            height: SizeConfig.blockSizeVertical * 7.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.only(
                  left: index == 0 ? 25 : 0,
                  right: 20,
                ),
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCategoryPage = index;
                      selectedCategoryPageList =
                          details['${categories[index]['arrayMappedname']}'];
                    });
                  },
                  child: PrimaryText(
                    text: categories[index]['label'],
                    color: selectedCategoryPage == index
                        ? AppColors.white
                        : AppColors.textGray,
                    fontWeight: FontWeight.w500,
                    size: 18,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                    primary: selectedCategoryPage == index
                        ? AppColors.primary
                        : Colors.grey[200],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          // label name
          Padding(
            padding: standardPaddingX,
            child: PrimaryText(
                text: categories[selectedCategoryPage]['label'],
                fontWeight: FontWeight.w800,
                size: 28),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),

          // Padding(
          //   padding: standardPaddingX,
          //   child: Column(
          //     children: [
          //       Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: List.generate(
          //               2,
          //               (index) => productCard(
          //                   context,
          //                   selectedCategoryPageList[index]["image"],
          //                   selectedCategoryPageList[index]["label"],
          //                   selectedCategoryPageList[index]["price"]))),
          //     ],
          //   ),
          // ),

          Padding(
            padding: standardPaddingY,
            child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 20.0,
                shrinkWrap: true,
                childAspectRatio: .8,
                children: List.generate(
                    selectedCategoryPageList.length,
                    (index) => productCard(
                          context,
                          selectedCategoryPageList["$index"]["image"],
                          selectedCategoryPageList["$index"]["label"],
                          selectedCategoryPageList["$index"]["price"],
                          selectedCategoryPageList["$index"]["quantity"],
                        ))),
          ),
        ],
      ),
    );
  }

  Widget productCard(BuildContext context, String image, String label,
      int price, int quantity) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductDetail(image, label, price, quantity)));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: (SizeConfig.screenWidth - 80) / 2,
        height: SizeConfig.blockSizeVertical * 30,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                          text: label, color: AppColors.textGray, size: 16),
                      SizedBox(height: 5),
                      PrimaryText(
                          text: "₹$price",
                          size: 18,
                          fontWeight: FontWeight.w700),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
