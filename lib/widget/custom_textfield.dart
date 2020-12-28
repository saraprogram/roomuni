import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final int maxLine;
  final String hint;
  final String label;
  final String message;
  final TextInputType inputType;
  final Function variable;

  const CustomTextField({
    Key key,
    @required this.maxLine,
    @required this.hint,
    @required this.label,
    @required this.message,
    @required this.inputType,
    @required this.variable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      TextFormField(
        onSaved: variable,
        maxLines: maxLine,
        autofocus: false,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //labelText: "Enter Email",
          hintText: hint,
          labelText: label,
          fillColor: Colors.white70,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide(width: 1,color: Colors.cyan),
          ),
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(),

          ),
          //fillColor: Colors.green
        ),
        validator: (val) {
          if (val.length == 0) {
            return message;
          } else {
            return null;
          }
        },
        keyboardType: inputType,
        style: new TextStyle(
          fontFamily: "Poppins",
          fontSize: 14,

        ),
      ),
    );
  }
}
