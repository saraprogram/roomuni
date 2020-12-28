import 'dart:async';
import 'dart:convert';
import 'dart:io' as i;


import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:roomie/config/palette.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/getimage_provider.dart';
import 'package:roomie/provider/getuser_provider.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/widget/widgets.dart';
import 'package:dio/dio.dart';


class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage> with SingleTickerProviderStateMixin {

  var serverReceiverPath = "http://localhost:8000/api/v1/upload";

  i.File _image;
  FileImage _img;
  i.File imageFile;
  bool _status = true;
  bool pressed = false;
  final FocusNode myFocusNode = FocusNode();
  Users userLoad = Users();
  List<String> attachments = [];
  TextField txt = TextField(controller: TextEditingController()..text = '',);
  final _namecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _mobilecontroller = TextEditingController();
  final _avatarcontroller = TextEditingController();
  final _gendercontroller = TextEditingController();
  //final _avatarcontroller = TextEditingController();
  String image_url;

  int _id;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _gendercontroller.dispose();
    _avatarcontroller.dispose();

    myFocusNode.dispose();
    super.dispose();
  }

  getPref() async {
    Users fMain = await UserPreferences().getUser();
    String url = await UserPreferences().getimage();

    setState(() {
      userLoad = fMain;
      image_url = url;
      _id = fMain.userId;
      _namecontroller.text = fMain.name;
      _emailcontroller.text = fMain.email;
      _avatarcontroller.text = fMain.avatar;
      _gendercontroller.text = fMain.gender;
    });
  }



  Widget _headerIamge(context) {
    return Container(
      height: 150.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top:10),
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
                          child: Image.file(_image , fit: BoxFit.fill,                        width: 200,
                            height: 300,),

                        ),)
                      : CircleAvatar(
                        minRadius: 53.0,
                        maxRadius: 53.0,
                        //backgroundImage: new AssetImage('assets/images/as.png'),
                      backgroundImage:
                    NetworkImage("$image_url"),
                    backgroundColor: Colors.transparent,
                      ),

                ),
                pressed == true
                ? IconButton(
                  padding: EdgeInsets.only(top:80),
                  icon: Icon(Icons.camera_alt,size: 30,color: Colors.black,),
                )
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );

  }

  _imgFromCamera() async {
    PickedFile image = await ImagePicker().getImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 200.0, maxHeight: 300.0
    );

    setState(() {

      _image = i.File(image.path);
      print("image------------------$_image");


    });

    // open a byteStream
    var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
    // get file length
    var length = await _image.length();

    // string to uri
    var uri = Uri.parse("enter here upload URL");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request
    request.fields["user_id"] = "text";

    // multipart that takes file.. here this "image_file" is a key of the API request
    var multipartFile = new http.MultipartFile('image_file', stream, length, filename: basename(_image.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });

    }).catchError((e) {
      print(e);
    });
  }

  _imgFromGallery() async {
    PickedFile image = await  ImagePicker().getImage(
      source: ImageSource.gallery, imageQuality: 50 , maxWidth: 500,
      maxHeight: 700,
    );

    setState(() {
      _image = i.File(image.path);
      print("image------------------$_image");

    });

  }

  _cropImage(filePath) async {
    i.File croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: 400,
      maxHeight: 400,
    );
    if (croppedImage != null) {
      imageFile = croppedImage;
      setState(() {
        _image =imageFile;
      });
    }
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


  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          pressed = true;
          _status = false;
        });
      },
    );
  }


  Future<String> uploadImage(filename) async {
    String token = await UserPreferences().getToken();
    var headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"};
    var request = http.MultipartRequest('POST', Uri.parse(serverReceiverPath))
      ..fields['headers'] = headers.toString()
      ..fields['id'] = _id.toString()
      ..files.add(await http.MultipartFile.fromPath('avatar', filename));
    print('req------------------------$request');
    print( Uri.parse(serverReceiverPath));
    print(filename);
    print('req------------------------${request.files}');

    var res = await request.send();
    print('res--------------------------${res.reasonPhrase}');
    return res.reasonPhrase;
  }




  @override
  Widget build(BuildContext context) {

    LogoutProvider log = Provider.of<LogoutProvider>(context);
    UpdateUserProvider update = Provider.of<UpdateUserProvider>(context);
    GetUserProvider getuser = Provider.of<GetUserProvider>(context);
   // GetImageProvider getimage = Provider.of<GetImageProvider>(context);


    dogetUser() async {
      await getuser.Getuser().then((response) async {
        if (response['status'] == 'success') {
          var user_set = Users.fromJson(response['data']);
          Provider.of<UserProvider>(context, listen: false).setUser(user_set);
          Provider.of<GetUserProvider>(context, listen: false).Getuser();

          return response;
        }
      }).catchError((error) => Flushbar(
        title: "Failed Update",
        message: error.toString(),
        duration: Duration(seconds: 5),
      ).show(context));
    }


    doUpdate() async {
      var data = {
        'id' : userLoad.userId,
        'name':  _namecontroller.text,
        'email': _emailcontroller.text,
        'avatar': _image.toString(),
        'gender': _gendercontroller.text,

      };
      var body = json.encode(data);
      await update.updateUser(body).then((response) async {
        if (response['status'] == 'success') {
          print("varede if shodddd");

          dogetUser();
          print("end");
        }
      }).catchError((error) => Flushbar(
        title: "Failed Update",
        message: error.toString(),
        duration: Duration(seconds: 5),
      ).show(context));
    }





/*
    doGetimage() async {
      var data = {
        'id' : userLoad.userId,

      };
      var body = json.encode(data);
      await getimage.getImage(body).then((response) async {
        return response;
      }).catchError((error) => Flushbar(
        title: "Failed Update",
        message: error.toString(),
        duration: Duration(seconds: 5),
      ).show(context));
    }

*/
    Widget _getActionButtons() {
      return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Container(
                    child: new RaisedButton(
                      child: new Text("Save"),
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: () {
                        pressed = false;
                        setState(() {
                          _status = true;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
doUpdate();
uploadImage(_image.path);
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    )),
              ),
              flex: 2,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Container(
                    child: new RaisedButton(
                      child: new Text("Cancel"),
                      textColor: Colors.white,
                      color: Colors.red,
                      onPressed: () {
                        pressed = false;
                        _image = null;
                        setState(() {
                          _status = true;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    )),
              ),
              flex: 2,
            ),
          ],
        ),
      );
    }


    return new Scaffold(
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
                  _headerIamge(context),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "Personal Information:",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : new Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        "Name",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      controller: _namecontroller  ,
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Name",
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,

                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        "Email ID",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      controller: _emailcontroller  ,
                                      decoration: const InputDecoration(
                                          hintText: "Enter Email ID"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        "Gender",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      controller: _gendercontroller,
                                      decoration: const InputDecoration(
                                          hintText: "Enter Gender"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

}

