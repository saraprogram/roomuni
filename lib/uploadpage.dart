import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key key, this.url}) : super(key: key);
  final String url;

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File file;
  var serverReceiverPath = "http://localhost:8000/api/v1/upload";

  Future<String> uploadImage(filename) async {
    var request = http.MultipartRequest('POST', Uri.parse(serverReceiverPath));
    print('req------------------------$request');
    print( Uri.parse(serverReceiverPath));
    request.files.add(await http.MultipartFile.fromPath('avatar', filename));
    print(filename);
    print('req------------------------${request.files}');

    var res = await request.send();
    print('res--------------------------${res.reasonPhrase}');
    return res.reasonPhrase;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter File Upload Example',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            file != null
                ? Container(
              height: 160.0,
              width: 160.0,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: ExactAssetImage(file.path),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.red, width: 5.0),
                borderRadius:
                BorderRadius.all(const Radius.circular(20.0)),
              ),
            )
                : SizedBox(
              width: 0.0,
            ),
            SizedBox(
              height: 100.0,
            ),
            file != null
                ? RaisedButton(
              child: Text("Upload Image"),
              onPressed: () async {
                var res = await uploadImage(file.path);
                setState(() {
                  print(res);
                });
              },
            )
                : SizedBox(
              width: 50.0,
            ),
            file == null
                ? RaisedButton(
              child: Text("Open Gallery"),
              onPressed: () async {
                file = await ImagePicker.pickImage(
                    source: ImageSource.gallery);
                setState(() {});
              },
            )
                : SizedBox(
              width: 0.0,
            )
          ],
        ),
      ),
    );
  }
}