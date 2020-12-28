import 'dart:io' as i;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:share/share.dart';

class CustomImagePicker extends StatefulWidget {
  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  i.File _image;
  FileImage _img;
  i.File imageFile;


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

  //****************************************
  @override
  Widget build(BuildContext context) {
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
}

