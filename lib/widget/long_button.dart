import 'package:flutter/material.dart';

class longButtons extends StatelessWidget {

  final String title;
  final Function fun;
  final Color color;
  final Color textcolor;

  const longButtons({
    Key key,
    @required this.title,
    @required this.fun,
    @required this.color,
    @required this.textcolor,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: fun,
      textColor: textcolor,
      color: color,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
      height: 45,
      minWidth: 600,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );

  }



  label(String title) => Text(title);

  InputDecoration buildInputDecoration(String hintText, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
      // hintText: hintText,
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}


