import 'dart:io' as i;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:share/share.dart';



class CustomImagePicker1 extends StatefulWidget {
  @override
  _CustomImagePicker1State createState() => _CustomImagePicker1State();
}

class _CustomImagePicker1State extends State<CustomImagePicker1> {
  i.File _image;
  FileImage _img;
  i.File imageFile;
  bool toggle = false;


  _imgFromCamera() async {
    PickedFile image = await ImagePicker().getImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 200.0, maxHeight: 300.0
    );

    setState(() {
      _image = i.File(image.path);
    });
  }

  _imgFromGallery() async {
    PickedFile image = await  ImagePicker().getImage(
        source: ImageSource.gallery, imageQuality: 50 , maxWidth: 500,
      maxHeight: 700,
    );

    setState(() {
      _image = i.File(image.path);
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


  //?**********

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
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
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


  //****************************************
  @override
  Widget build(BuildContext context) {

    String text = 'Hey this is ROOMIE Http://roomie.com ';
    String subject = 'follow me';
    var toggledOn = false;


    var pressed ;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xffFDCF09),
                child: _image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    _image,
                    width: 200,
                    height: 300,
                    fit: BoxFit.fill,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:100),
            child: RaisedButton(
              child:  Text('Share'),
              onPressed: ()
              {
                final RenderBox box = context.findRenderObject();
                Share.share(text,
                    subject: subject,
                    sharePositionOrigin:
                    box.localToGlobal(Offset.zero) &
                    box.size);
              },
            ),
          ),
          IconButton(
            icon: toggle ? Icon(Icons.adjust, size: 40, color: toggledOn ? Colors.green : Colors.blue)
            :Icon(Icons.access_alarm, size: 40, color: toggledOn ? Colors.green : Colors.blue),
            onPressed: () {
              setState(() {
                toggle = !toggle;
              });
            },
          )
        ],
      ),
    );
  }


//**********************************




  //**************************************
}

