import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomie/data/aplocalization.dart';

import 'package:roomie/data/defualtdata.dart';
import 'package:roomie/data/providess.dart';
import 'package:roomie/data/subhome.dart';



class HomePage extends StatelessWidget {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Let\'s speak '),
                  Consumer<CurrentData>(
                    builder: (context, currentData, child) {
                      return Container(
                        width: 100,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: DropdownButton<String>(
                          value: currentData.defineCurrentLanguage(context),
                          icon: Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                          iconSize: 20,
                          elevation: 0,
                          style: TextStyle(color: Colors.white),
                          underline: Container(
                            height: 1,
                          ),
                          dropdownColor: Colors.indigo,
                          onChanged: (String newValue) {
                            currentData.changeLocale(newValue);
                          },
                          items: defaultData.languagesListDefault
                              .map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
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
                      builder: (context) => SubHomePage(),
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