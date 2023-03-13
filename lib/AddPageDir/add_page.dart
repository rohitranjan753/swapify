import 'package:flutter/material.dart';
import 'package:vbuddyproject/AddPageDir/SellDir/sell_page.dart';
import 'package:vbuddyproject/SearchPageDir/SearchPage.dart';

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
      body: Column(
        children: [

          //sell
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SellPage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: Container(
                  height: myHeight * 0.3,
                  width: myWidth,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/profile/12.jpg',
                        width: myWidth * 0.5,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Sell'),
                  ]),
                ),
              ),
            ),
          ),

          Text('OR'),

          //rent
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Container(
                height: myHeight * 0.3,
                width: myWidth,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/profile/12.jpg',
                      width: myWidth * 0.5,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Rent'),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
