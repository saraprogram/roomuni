import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomie/data/AppLanguage.dart';
import 'package:roomie/data/aplocalization.dart';
import 'package:roomie/data/defualtdata.dart';
import 'package:roomie/data/lang.dart';
import 'package:roomie/data/providess.dart';
import 'package:roomie/provider/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingLan extends StatelessWidget {

  final String title;

   SettingLan({this.title});

  @override
  Widget build(BuildContext context) {
    final DefaultData defaultData = DefaultData();

    //var appLanguage = Provider.of<AppLanguage>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //title: Text(title),
          /*
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Language>(
                underline: SizedBox(),
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                onChanged: (Language language) {
                  appLanguage.changeLanguage(Locale("en"));

                  //_changeLanguage(language);
                },
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                    value: e,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          e.flag,
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(e.name)
                      ],
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          ],
          */
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 100.0),
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

              Center(
                child: new Text(
                  AppLocalization.of(context).translate('login'),
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              /*
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[


                  RaisedButton(
                    onPressed: () async {
                      appLanguage.changeLanguage(Locale("en"));
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString('language_code', 'en');
                    },
                    child: Text('English'),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      appLanguage.changeLanguage(Locale("ar"));
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString('language_code', 'ar');


                    },
                    child: Text('العربي'),
                  )
                ],
              ),
            RaisedButton(
                child: Text("Change Theme"),
                onPressed:(){
                  print("pressed");
                  Provider.of<ThemeModel>(context).toggleTheme();
                }
            )
*/
            ],
          ),
        ),
      ),
    );
  }
}
