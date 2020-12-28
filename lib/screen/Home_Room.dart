import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:roomie/config/palette.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/widget/widgets.dart';
import 'package:provider/provider.dart';
import 'package:roomie/config/configs.dart';
import 'package:roomie/config/api_response.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class HomeRoom extends StatelessWidget {

  CarouselController buttonCarouselController = CarouselController();

  get context => context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          'Roomie',
        ),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: AnimatedAddButton(name: 'advertise',),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body:Consumer<AdsDetailsProvider>(builder: (context, myModel, child) {
        if (myModel.ads.status == Status.COMPLETED) {
          print(myModel.ads.status);

          return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex:1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 2 ,right: 5,left: 5),
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //padding: EdgeInsets.all(16),
                            child:IconButton(
                              padding: EdgeInsets.only(top:1),
                              icon: Icon(Icons.adjust, size: 30),
                              onPressed: () {
                                print("sheet");
                                _SaraPicker(context);
                              },
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(16),
                            height: 70,
                            width: 70,
                            child: ClipRRect(

                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.asset('assets/categories.png'),

                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(16),
                            height: 70,
                            width: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Icon(Icons.location_city),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(16),
                            height: 70,
                            width: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Icon(Icons.filter),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top:3 ,bottom:7),
                  child: CarouselSlider(
                    items: [
                      "https://png.pngtree.com/thumb_back/fw800/back_pic/00/03/35/09561e11143119b.jpg",
                      "https://png.pngtree.com/thumb_back/fw800/back_pic/04/61/87/28586f2eec77c26.jpg",
                      "https://png.pngtree.com/thumb_back/fh260/back_pic/04/29/70/37583fdf6f4050d.jpg",
                      "https://ak6.picdn.net/shutterstock/videos/6982306/thumb/1.jpg"].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.cyan
                              ),
                              child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                          );
                        },
                      );
                    }).toList(),
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      aspectRatio: 2.0,
                      initialPage: 2,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child:
                ListView.builder(
                  padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 70),
                  itemCount: myModel.ads.data.length,
                  itemBuilder: (context, index) {
                    Ads project = myModel.ads.data[index];
                    return AdsContainer(ads: project,);
                  },
//scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                ),    ),
            ],

          );




          //return Text("${myModel.album.data.length}");
        }
        else if (myModel.ads.status != Status.COMPLETED) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Text("${myModel.ads.message}");
        }
      }),

    );
  }
}

  //***********************************
/*
  void slideSheet() {
    showModalBottomSheet(
        elevation:10.0,
        context: context,
        builder: (context) {
          return SafeArea(
            child: Container(
              color: Color(0xFF737373),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Row1')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Row2')
                      ],
                    )


                  ],
                ),
              ),
            ),
          );
        });
  }


 */

  void _SaraPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              height: 300,
              color: Colors.amber,
              child: new Wrap(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Close BottomSheet'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        print('test');
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }


/*
Widget adsDisplay(BuildContext context) {
  return Consumer<AdsDetailsProvider>(builder: (context, myModel, child) {
    if (myModel.ads.status == Status.COMPLETED) {
      print(myModel.ads.status);
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 70),
        itemCount: myModel.ads.data.length,
        itemBuilder: (context, index) {
          Ads project = myModel.ads.data[index];
          return AdsContainer(ads: project,);
        },
        //scrollDirection: Axis.vertical,
        shrinkWrap: true,
      );

      //return Text("${myModel.album.data.length}");
    } else if (myModel.ads.status == Status.ERROR) {
      return Text("Error : ${myModel.ads.message}");
    } else {
      return Text("${myModel.ads.message}");
    }
  });
}
*/