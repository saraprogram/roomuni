import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final String hint;
  final String message;
  final TextInputType inputType;
  final Function variable;
  final IconData icon;
  final bool obscure;

  const CustomTextFormField({
    Key key,
    @required this.hint,
    @required this.message,
    @required this.inputType,
    @required this.variable,
    @required this.icon,
    @required this.obscure,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      TextFormField(
        autofocus: false,
        obscureText: obscure,
        onSaved: variable,
        decoration: new InputDecoration(
          prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          //labelText: "Enter Email",
          hintText: hint,
          //labelText: label,
          fillColor: Colors.white70,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 1,color: Colors.cyan),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
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




