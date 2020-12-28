import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roomie/config/palette.dart';
import 'package:roomie/screen/MyQue_room.dart';
import 'package:roomie/screen/screens.dart';

import 'MyAds_room.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Palette.roomieBlue,
        title: Text(
          'Roomie',
        ),
        automaticallyImplyLeading: false,
      ),
      body: new Column(
        children: [
          new Column(
            children: [
              Container(
                child: SizedBox(
                  height: 250,
                  child: Card(),
                ),
              ),
              Divider(),
              Container(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 180,
                            width: 160,
                            child: Card(
                              color: Colors.white60,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyAds(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Center(
                                          child: Icon(
                                        Icons.tap_and_play,
                                        size: 90,
                                        color: Colors.cyan,
                                      )),
                                    ),
                                    //Padding(padding: EdgeInsets.only(top:10)),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0,
                                          right: 25.0,
                                          top: 15.0,
                                          bottom: 15.0),
                                      child: Text(
                                        "My Advertise",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 180,
                            width: 160,
                            child: Card(
                              color: Colors.white60,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyQue(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Center(
                                          child: Icon(
                                        Icons.question_answer,
                                        size: 90,
                                        color: Colors.cyan,
                                      )),
                                    ),
                                    //Padding(padding: EdgeInsets.only(top:10)),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0,
                                          right: 25.0,
                                          top: 15.0,
                                          bottom: 15.0),
                                      child: Text(
                                        "My Question",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: SizedBox(
                          height: 180,
                          width: 160,
                          child: Card(
                            color: Colors.white60,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePage(),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Center(
                                        child: Icon(
                                      Icons.bookmark_border,
                                      size: 90,
                                      color: Colors.cyan,
                                    )),
                                  ),
                                  //Padding(padding: EdgeInsets.only(top:10)),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0,
                                        right: 25.0,
                                        top: 15.0,
                                        bottom: 15.0),
                                    child: Text(
                                      "My Bookmark",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
