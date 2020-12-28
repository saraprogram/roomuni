import 'dart:convert';
import 'dart:io' as i;

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/screen/screens.dart';
import 'package:roomie/widget/widgets.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

enum SingingCharacter { male, female }

// ...

SingingCharacter _character1 = SingingCharacter.male;


class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool _terms=false ;
  bool _policy = false;
  i.File _image;
  FileImage _img;
  i.File imageFile;
  bool _status = true;
  bool pressed = false;

  String _name, _email, _password, _cPassword, _character, term ,policy;


  @override
  Widget build(BuildContext context) {
    RegisterProvider reg = Provider.of<RegisterProvider>(context);

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );


    _imgFromCamera() async {
      PickedFile image = await ImagePicker().getImage(
          source: ImageSource.camera,
          imageQuality: 50,
          maxWidth: 200.0,
          maxHeight: 300.0
      );

      setState(() {
        _image = i.File(image.path);
      });
    }

    _imgFromGallery() async {
      PickedFile image = await ImagePicker().getImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 500,
        maxHeight: 700,
      );

      setState(() {
        _image = i.File(image.path);
      });
    }

    void _showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text("Photo Library"),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text("Camera"),
                      onTap: () {
                        _imgFromCamera();
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

    Widget _headerIamge(context) {
      return Container(
        height: 150.0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.blueGrey,
                    child: _image != null
                        ? CircleAvatar(
                      radius: 53.0,
                      child: ClipOval(
                        child: Image.file(_image, fit: BoxFit.fill, width: 200,
                          height: 300,),

                      ),)
                        : CircleAvatar(
                      minRadius: 53.0,
                      maxRadius: 53.0,
                      backgroundImage: new AssetImage('assets/images/as.png'),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(top: 80),
                    icon: Icon(
                      Icons.camera_alt, size: 30, color: Colors.black,),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    _doRegister() async {
      final form = formKey.currentState;
      if (form.validate() && _terms == true && _policy == true && _character != null) {
        form.save();
        if (_terms == true || _policy == true) {
          term = '1';
          policy = '1';
        }
        var data = {
          'name': _name,
          'email': _email,
          'password': _password,
          'password_confirmation': _cPassword,
          'gender': _character,
          'avatar': 's.png',
          'approve_policy': policy,
          'approve_terms': term,
        };
        var body = json.encode(data);
        await reg.Register(data).then((response) {
          if (response['status']) {
            Users user = response['data'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => NavScreen()
              ),
            );
          }
        }).catchError((error) => Flushbar(
          title: "Registration Failed",
          message: error.toString(),
          duration: Duration(seconds: 5),
        ).show(context));
      } else {
        Flushbar(
          title: "Invalid Form",
          message: "Please Complete the form properly",
          duration: Duration(seconds: 5),
        ).show(context);
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headerIamge(context),
                  SizedBox(height: 15.0),
                  label("Name"),
                  SizedBox(height: 5.0),
                  CustomTextFormField(
                    hint: "enter your name",
                    message: "please enter your name",
                    inputType: TextInputType.text,
                    variable: (value) => _name = value,
                    obscure: false,
                    icon: Icons.face,),
                  SizedBox(height: 15.0),
                  label("Email"),
                  SizedBox(height: 5.0),
                  CustomTextFormField(
                    hint: "enter your email",
                    message: "please enter your email",
                    inputType: TextInputType.emailAddress,
                    variable: (value) => _email = value,
                    obscure: false,
                    icon: Icons.mail,),
                  SizedBox(height: 15.0),
                  label("Password"),
                  SizedBox(height: 10.0),
                  CustomTextFormField(
                    hint: "enter your password",
                    message: "please enter your password",
                    inputType: TextInputType.visiblePassword,
                    variable: (value) => _password = value,
                    obscure: true,
                    icon: Icons.lock,),
                  SizedBox(height: 15.0),
                  label("re-Password"),
                  SizedBox(height: 10.0),
                  CustomTextFormField(
                    hint: "enter your re-password",
                    message: "please enter your re-password",
                    inputType: TextInputType.visiblePassword,
                    variable: (value) => _cPassword = value,
                    obscure: true,
                    icon: Icons.lock,),
                  SizedBox(height: 15.0),
                  label("Gender"),
                  SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                          width: 1.0),   // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Radio(
                            value: "male",
                            groupValue: _character,
                            onChanged: (value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                          new Text(
                            'male',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                          ),
                          new Radio(
                            value: "female",
                            groupValue: _character,
                            onChanged: (value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                          new Text(
                            'female',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                          ),
                          new Radio(
                            value: "other",
                            groupValue: _character,
                            onChanged: (value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                          new Text(
                            'other',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                        ]),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _terms,
                        onChanged: (bool value) {
                          setState(() {
                            _terms = value;
                          });
                        },
                      ),
                      Text("terms and condition......."),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _policy,
                        onChanged: (bool value) {
                          setState(() {
                            _policy = value;
                          });
                        },
                      ),
                      Text("policy......."),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  longButtons(title: "Register",
                    fun: _doRegister,
                    color: Colors.black45,
                    textcolor: Colors.red,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}

/*
**************************************************
 */

label(String title) => Text(title);

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    // hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

String validateEmail(String value) {
  String _msg;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    _msg = "Your username is required";
  }
  /*else if (!regex.hasMatch(value)) {
    _msg = "Please provide a valid emal address";
  }*/
  return _msg;
}


