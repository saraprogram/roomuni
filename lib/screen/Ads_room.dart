import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:roomie/config/palette.dart';
import 'package:roomie/data/aplocalization.dart';



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

class AdsRoom extends StatefulWidget {
  @override
  _AdsRoomState createState() => _AdsRoomState();
}

class _AdsRoomState extends State<AdsRoom> {
  get context => context;

  @override
  Widget build(BuildContext context) {
    //Provider.of<AdsDetailsProvider>(context, listen: false);
    Future<void> getMoreData() {
      return Provider.of<AdsDetailsProvider>(context, listen: false)
          .fetchAdsDetails();
    }
    //-----------------------------------------------







//----------------------------------------------------
 return  Scaffold(
   backgroundColor: Colors.white,
   appBar: AppBar(
     backgroundColor: Palette.roomieBlue,
     title:Text( AppLocalization.of(context).translate('hello-world'),),
     /*
     Text(
     AppLocalizations.of(context)
         .translate("Roomie"),
     ),

      */
     automaticallyImplyLeading: false,
   ),
   floatingActionButton: AnimatedAddButton(
     name: 'advertise',
     hero: 'ad',
   ),
   //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   body: Consumer<AdsDetailsProvider>(builder: (context, myModel, child) {
     if (myModel.ads.status == Status.COMPLETED) {
       print(myModel.ads.data);
       return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           _header(context),
           _banner(context),
           Expanded(
             flex: 7,
             child: RefreshIndicator(
               onRefresh: getMoreData,
               child: ListView.builder(
                 padding: const EdgeInsets.only(
                     bottom: kFloatingActionButtonMargin + 70),
                 itemCount: myModel.ads.data.length,
                 itemBuilder: (context, index) {
                   Ads project = myModel.ads.data[index];
                   return AdsContainer(
                     ads: project,
                   );
                 },
//scrollDirection: Axis.vertical,
                 shrinkWrap: true,
               ),
             ),
           ),
         ],
       );
       //print(myModel.ads.status);
       //return Text("${myModel.album.data.length}");
     } else if (myModel.ads.status != Status.COMPLETED) {
       print(myModel.ads.data);

       return Center(
           child:
           //buildShowDialog(context),
           CircularProgressIndicator());
     } else if (myModel.ads.status == Status.ERROR) {
       return Text("Error : ${myModel.ads.message} ");
     } else {
       return Text("${myModel.ads.message}");
     }
   }),
 );


  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

Widget _header(context) {
  return Expanded(
    flex: 1,
    child: Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 0, right: 15, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('assets/images/logo.png'),
          ),
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('assets/images/email_icon.png'),
          ),
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('assets/images/user_icon.png'),
          ),
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('assets/images/password_icon.png'),
          ),
          /*
          Container(
            //padding: EdgeInsets.all(16),
              child:IconButton(
                padding: EdgeInsets.only(top:1),
                icon: Icon(Icons.adjust, size: 30),
                onPressed: () {
                  print("sheet");
                  _filter(context);
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
        */
        ],
      ),
    ),
  );
}

Widget _banner(context) {
  var dodo = () async {};
  CarouselController buttonCarouselController = CarouselController();
  return Expanded(
    flex: 2,
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 3, bottom: 7),
      child: CarouselSlider(
        items: [
          "https://png.pngtree.com/thumb_back/fw800/back_pic/00/03/35/09561e11143119b.jpg",
          "https://png.pngtree.com/thumb_back/fw800/back_pic/04/61/87/28586f2eec77c26.jpg",
          "https://png.pngtree.com/thumb_back/fh260/back_pic/04/29/70/37583fdf6f4050d.jpg",
          "https://ak6.picdn.net/shutterstock/videos/6982306/thumb/1.jpg"
        ].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.cyan),
                child: longButtons(
                  title: "Advertisment Banner",
                  fun: dodo,
                  color: Colors.black45,
                  textcolor: Colors.red,
                ),
                //Text('text $i', style: TextStyle(fontSize: 16.0),)
              );
            },
          );
        }).toList(),
        carouselController: buttonCarouselController,
        options: CarouselOptions(
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
  );
}

void _filter(context) {
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
      });
}
