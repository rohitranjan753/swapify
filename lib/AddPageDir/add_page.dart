import 'package:flutter/material.dart';
import 'package:vbuddyproject/AddPageDir/RentDir/rent_page.dart';
import 'package:vbuddyproject/AddPageDir/SellDir/sell_page.dart';
import 'package:vbuddyproject/Constants/color_constant.dart';
import 'package:vbuddyproject/Constants/image_string.dart';
import 'package:vbuddyproject/Constants/sizes.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("ADD LISTING",style: TextStyle(letterSpacing: textLetterSpacingValue),),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
        ),
        // title: Text(widget.item['creatorname']),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //sell
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SellPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.white,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      child: Container(
                        height: myHeight * 0.34,
                        width: myWidth,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Image.asset(
                              addPageSell,
                              width: myWidth * 0.5,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'SELL',
                            style: TextStyle(
                              fontWeight: buttonTextWeight,
                              letterSpacing: textLetterSpacingValue,
                              fontSize: 35,
                            ),
                          ),

                        ]),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 2,
                        color: Colors.grey,
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'OR',
                          style: TextStyle(fontWeight: buttonTextWeight,fontSize: 30,color: Colors.grey),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 2,
                        color: Colors.grey,
                      )),
                    ],
                  ),
                ),

                //rent
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RentPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.white,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      child: Container(
                        height: myHeight * 0.34,
                        width: myWidth,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              addPageRent,
                              width: myWidth * 0.5,
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            'RENT',
                            style: TextStyle(
                              fontWeight: buttonTextWeight,
                              letterSpacing: textLetterSpacingValue,
                              fontSize: 35,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
