import 'package:flutter/material.dart';

import 'package:vbuddyproject/Model/homepage_single_row_model.dart';

class HomePageSingleItem extends StatelessWidget {
  final List<HomeSingleRowModel>? item;
  final index;

  HomePageSingleItem({this.item, this.index});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GestureDetector(
          onTap: (){
            // if(index == 0){
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
            // }
            // else{
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage()));
            // }
            // Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedPage(selectPlace: item![index],)));
          },
          child: Container(
              height: myHeight * 0.4,
              // width: myWidth * 0.3,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 7,
                      spreadRadius: 3,
                      offset: Offset(0, 5)),
                ],
                image: DecorationImage(
                    image: AssetImage(
                      item![index].image.toString(),
                    ),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: myHeight * 0.06,
                        width: myWidth * 0.12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 40, 93, 116)
                                .withOpacity(0.5)),
                        child: Icon(
                          Icons.bookmark_add_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      bottom: 30,
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item![index].name.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: myWidth * 0.02,
                              ),
                              Text(
                                item![index].location.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: myHeight * 0.01,
                          ),
                          Row(
                            children: [
                              Text(
                                'Starting At',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(
                                width: myWidth * 0.03,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 7),
                                child: Container(
                                  // height: myHeight * 0.06,
                                  // width: myWidth * 0.12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.2)),
                                  child: Text(
                                    item![index].price.toString() + '\$',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),),
        ),
      ),
    );
  }
}
