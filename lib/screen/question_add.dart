import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomie/config/palette.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/widget/widgets.dart';

class AddQuestion extends StatefulWidget {

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final formKey = new GlobalKey<FormState>();

  String  title,university,city,tag,description;

  @override
  Widget build(BuildContext context) {

    AddQuestionProvider addques = Provider.of<AddQuestionProvider>(context);


    var dosubmit = () async {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        var data = {
          'title' : title,
          'description' : description,
          'tag': tag,
          'university': 'defualt',
          'city': 'default',
        };
        print(data);
        var body = json.encode(data);
        print(body);
        await addques.AddQuestion(body).then((response) {
          if (response['status']) {
            //Ads user = response['data'];
            //Provider.of<UserProvider>(context, listen: false).setUser(user);
            //Provider.of<AdsDetailsProvider>(context, listen: true);
            Provider.of<QuestionDetailsProvider>(context, listen: false).fetchPostDetails();
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
              title: "Added question Failed",
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

    };


    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Add Question',
          style: const TextStyle(
            color: Palette.facebookBlue,
            fontSize: 24.0,
            letterSpacing: -1.2,
          ),
        ),
      ),

      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage("assets/ava.jpg"),
                fit: BoxFit.cover,
              ),
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
                    child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          AdsText(text:'share your question to find best help from our users',fontWeight: FontWeight.normal,
                              fontSize: 25.0,colors: Colors.grey),
                          Padding(padding: EdgeInsets.only(top: 30.0)),
                          CustomTextField(variable:(value) => title = value,maxLine: 1, hint: "title", message: "please share your title", inputType: TextInputType.text),
                          Padding(padding: EdgeInsets.only(top: 30.0)),
                          CustomTextField(variable:(value) => description = value,maxLine: 10, hint: "enter your question", message: "please enter your question", inputType: TextInputType.multiline),
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          DropdownButton<String>(
                            isExpanded: true,
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                                color: Colors.cyan
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.cyan,
                            ),
                            value: tag,
                            items: <String>['Real State', 'Documnet', 'Roomate', 'Staff', 'Book'].map((String value) {
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
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: Colors.blueGrey,
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
