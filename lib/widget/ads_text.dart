import 'package:flutter/material.dart';

class AdsText extends StatelessWidget {


  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color colors;

  const AdsText({
    Key key,
    @required this.fontSize,
    @required this.text,
    @required this.fontWeight,
    @required this.colors,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: colors,
          fontSize: fontSize,
          fontWeight: fontWeight
      ),
    );
  }
}
