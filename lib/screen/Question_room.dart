import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/widget/widgets.dart';
import 'package:roomie/config/configs.dart';
import 'package:roomie/provider/providers.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuestionRoom extends StatelessWidget {
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
      floatingActionButton: AnimatedAddButton(
        name: 'question',
        hero: 'que',
      ),
      body: Consumer2<QuestionDetailsProvider, LikeDetailsProvider>(
          builder: (context, mypModel, mylModel, child) {
        if (mypModel.questions.status == Status.COMPLETED) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _header(context),
              Expanded(
                flex: 7,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      bottom: kFloatingActionButtonMargin + 70),
                  itemCount: mypModel.questions.data.length,
                  itemBuilder: (context, index) {
                    List<Like> projectL = mylModel.likes.data;
                    Questions project = mypModel.questions.data[index];
                    return QuestionContainer(
                      question: project,
                      likes: projectL,
                    );
                  },
                ),
              ),
            ],
          );

          //return Text("${myModel.album.data.length}");
        } else if (mypModel.questions.status == Status.LOADING) {
          return Center(child: CircularProgressIndicator());
        } else if (mypModel.questions.status == Status.ERROR ||
            mylModel.likes.status == Status.ERROR) {
          return Text("Error : ${mypModel.questions.message} ");
        } else {
          return Text("${mypModel.questions.message} ");
        }
      }),
    );
  }
}

Widget _header(context) {
  return Expanded(
    flex: 1,
    child: Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 5, right: 15, left: 15, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('assets/images/as.png'),
          ),
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('assets/images/as.png'),
          ),
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('assets/images/as.png'),
          ),
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('assets/images/as.png'),
          ),
          /*
          Container(
              //padding: EdgeInsets.all(16),
              child: IconButton(
            padding: EdgeInsets.only(top: 1),
            icon: Icon(Icons.adjust, size: 30),
            onPressed: () {
              print("sheet");
            },
          )),
          Container(
              padding: EdgeInsets.all(16),
              height: 70,
              width: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset('assets/categories.png'),
              )),
          Container(
              padding: EdgeInsets.all(16),
              height: 70,
              width: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Icon(Icons.location_city),
              )),
          Container(
              padding: EdgeInsets.all(16),
              height: 70,
              width: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Icon(Icons.filter),
              )),
          */
        ],
      ),
    ),
  );
}
