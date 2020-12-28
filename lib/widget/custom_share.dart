
import 'package:flutter/material.dart';
import 'package:share/share.dart';


String text = 'Hey this is ROOMIE Http://roomie.com ';
String subject = 'follow me';
var toggledOn = false;

Function custom_share(context){
final RenderBox box = context.findRenderObject();
Share.share(text,
subject: subject,
sharePositionOrigin:
box.localToGlobal(Offset.zero) &
box.size);
}