import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomie/model/Ads.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/screen/screens.dart';
import 'package:roomie/widget/widgets.dart';

class AddAdvertise extends StatefulWidget {
  @override
  _AddAdvertiseState createState() => _AddAdvertiseState();
}

class _AddAdvertiseState extends State<AddAdvertise> {
  final formKey = new GlobalKey<FormState>();

  String title, university, city, whasapp, email, description;
  String tag = 'Book';

  @override
  Widget build(BuildContext context) {
    AddAdsProvider adds = Provider.of<AddAdsProvider>(context);

    dosubmit() async {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        var data = {
          'title': title,
          'description': description,
          'tag': tag,
          'university': university,
          'city': city,
          'whatsapp_num': whasapp,
          'email': email,
        };
        print(data);
        var body = json.encode(data);
        print(body);
        await adds.Advertise(body).then((response) {
          print("main code -------------------${response}");
          if (response['status']) {
            //Ads user = response['data'];
            print(response['data']);
            //Provider.of<UserProvider>(context, listen: false).setUser(user);
            //Provider.of<AdsDetailsProvider>(context, listen: true);
            Provider.of<AdsDetailsProvider>(context, listen: false)
                .fetchAdsDetails();

            Navigator.of(context).pop();
            /*
            Navigator.push(
              context,
              new MaterialPageRoute(

                  builder: (context) => NavScreen()
              ),
            );
            */
          } else {
            Flushbar(
              title: "Registration Failed",
              message: response['status'].toString(),
              //response['status'],
              duration: Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: "Invalid form",
          message: "Please Complete the form properly",
          duration: Duration(seconds: 10),
        ).show(context);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        //automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                /*image: DecorationImage(
                image: new AssetImage("assets/ava.jpg"),
                fit: BoxFit.cover,
              ), */
                ),
          ),
          SingleChildScrollView(
            //color: Colors.white,
            //child: Container(
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                  child: Form(
                key: formKey,
                child: Column(children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Text(
                    "It is easy to share your advertisment here ",
                    style: new TextStyle(color: Colors.black45, fontSize: 16.0),
                  ),
                  Padding(padding: EdgeInsets.only(top: 40.0)),
                  CustomTextField(
                      variable: (value) => title = value,
                      maxLine: 2,
                      hint: "title",
                      label: "title",
                      message: "please enter your title",
                      inputType: TextInputType.text),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  CustomTextField(
                      variable: (value) => university = value,
                      maxLine: 1,
                      hint: "university",
                      label: "university",
                      message: "please enter your university",
                      inputType: TextInputType.text),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  CustomTextField(
                      variable: (value) => city = value,
                      maxLine: 1,
                      hint: "city",
                      label: "city",
                      message: "please enter your university",
                      inputType: TextInputType.text),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  CustomTextField(
                      variable: (value) => whasapp = value,
                      maxLine: 1,
                      hint: "whatsapp number",
                      label: "whatsapp",
                      message: "please enter your whatsapp number",
                      inputType: TextInputType.number),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  CustomTextField(
                      variable: (value) => email = value,
                      maxLine: 1,
                      hint: "Email",
                      label: "email",
                      message: "please enter your email",
                      inputType: TextInputType.emailAddress),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey, width: 1.0), // set border width
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      autofocus: true,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.blueGrey),
                      value: tag,
                      items: <String>[
                        "Real State",
                        "Documnet",
                        "Roomate",
                        "Staff",
                        "Book"
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String data) {
                        setState(() {
                          tag = data;
                        });
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  CustomTextField(
                      variable: (value) => description = value,
                      maxLine: 8,
                      hint: "",
                      label: "Description",
                      message: "please enter your description",
                      inputType: TextInputType.multiline),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Colors.cyan,
                    onPressed: dosubmit,
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SUBMIT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              )),
            ),
            //   )
          ),
        ],
      ),
    );
  }
}
