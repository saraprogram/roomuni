import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomie/data/aplocalization.dart';

import 'package:roomie/data/defualtdata.dart';
import 'package:roomie/data/providess.dart';
import 'package:roomie/screen/screens.dart';
import 'package:roomie/screen/setting.dart';



class SubHomePage extends StatelessWidget {
  final DefaultData defaultData = DefaultData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                AppLocalization.of(context).translate('hello-world'),
                style: TextStyle(color: Colors.indigo, fontSize: 30),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingLan(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      top: 15.0,
                      bottom: 15.0),
                  child: new Text(
                    AppLocalization.of(context).translate('login'),
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}