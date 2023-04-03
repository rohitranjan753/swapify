import 'package:flutter/material.dart';
import 'package:vbuddyproject/AddPageDir/SellDir/sell_page.dart';

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //sell
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => SellPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.grey[100],
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
                              'assets/images/buy2.jpg',
                              width: myWidth * 0.5,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Sell',
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),

                Text(
                  'OR',
                  style: TextStyle(fontSize: 30),
                ),

                //rent
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey[100],
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
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            'assets/images/rent2.jpg',
                            width: myWidth * 0.5,
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          'Rent',
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        ),
                      ]),
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
