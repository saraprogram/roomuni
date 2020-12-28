import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomie/config/configs.dart';
import 'package:roomie/config/palette.dart';
import 'package:roomie/data/aplocalization.dart';
//import 'package:roomie/data/app_localizations.dart';
import 'package:roomie/localizations.dart';


import 'package:roomie/main.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/logout_provider.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/screen/screens.dart';
import 'package:roomie/screen/setting.dart';

//import 'app_localizations.dart'; // <--- Using relative Path


class SettingRoom extends StatefulWidget {
  @override
  _SettingRoomState createState() => _SettingRoomState();
}

class _SettingRoomState extends State<SettingRoom> {
  bool remove;
  Users userLoad = Users();
  String image_url;
  String user_name;


  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  void dispose() {
getPref();
    super.dispose();
  }

  getPref() async {
    Users fMain = await UserPreferences().getUser();
    String url = await UserPreferences().getimage();

    print("url-------------------$image_url");



    setState(() {
      userLoad = fMain;
      image_url = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    LogoutProvider log = Provider.of<LogoutProvider>(context);
    GetUserProvider geti = Provider.of<GetUserProvider>(context);



    doLogout() async {
      String token = await UserPreferences().getToken();
      var data = {
        'token': token,
      };
      await log.Logout(data).then((response) async {
        if (response['status'] == 'success') {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => MyApp()),
          );
        }
      }).catchError((error) => Flushbar(
            title: "Failed Logout",
            message: error.toString(),
            duration: Duration(seconds: 5),
          ).show(context));
    }

    gu() async {
      String token = await UserPreferences().getToken();
      var data = {
        'token': token,
      };
      await geti.Getuser().then((response) async {
        if (response['status'] == 'success') {
          image_url = response['image_url'];
          user_name = response['user'][0]['name'];

          print("user . url ---------------------$image_url--------$user_name");

        }
      }).catchError((error) => Flushbar(
        title: "Failed Logout",
        message: error.toString(),
        duration: Duration(seconds: 5),
      ).show(context));
    }


    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Palette.roomieBlue,
          title: Text(
            'Roomie',
          ),
          automaticallyImplyLeading: false,
        ),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 250.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 25.0),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.blueGrey,
                            child: CircleAvatar(
                              minRadius: 53.0,
                              maxRadius: 53.0,
                              backgroundImage:  NetworkImage("$image_url"),
                              backgroundColor: Colors.transparent,

                              //child: Image.network(image_url),
                            ),
                          ),
                        ),
                        Text(userLoad.name.toString()),
                      ],
                    ),
                  ),
                  Divider(),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(),
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
                               "login",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(),
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
                                AppLocalization.of(context).translate('hello-world'),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Divider(),
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
                                "setting",
                                //AppLocalizations.of(context).translate('Setting'),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(),
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
                                AppLocalization.of(context).translate('hello-world'),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(),
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
                                AppLocalization.of(context).translate('hello-world'),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (ctxt) => new AlertDialog(
                                        title: Text("Logout Confirmation"),
                                        content: Text(
                                            "Are you sure to logout ?"),
                                        actions: [
                                          FlatButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text("Continue"),
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                              doLogout();
                                            },
                                          ), // set up the AlertDialog
                                        ],
                                      ) // show the dialog
                                  );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0,
                                  right: 25.0,
                                  top: 15.0,
                                  bottom: 15.0),
                              child: new Text(
                                "Logout",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
