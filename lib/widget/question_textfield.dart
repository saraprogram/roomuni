import 'package:flutter/material.dart';

class CustomRegTextField extends StatelessWidget {

  final int maxLine;
  final String hint;
  final String message;
  final TextInputType inputType;
  final bool autofocus;
  final bool obscure;
  final Icon icons;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;


  const CustomRegTextField({
    Key key,
    @required this.maxLine,
    @required this.hint,
    @required this.message,
    @required this.inputType,
    @required this.autofocus,
    @required this.obscure,
    @required this.icons,
    @required this.onSaved,
    @required this.validator,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      TextFormField(
        autofocus: autofocus,
        maxLines: maxLine,
        obscureText: obscure,
        decoration: new InputDecoration(
          //labelText: "Enter Email",
          hintText: hint,
          fillColor: Colors.white70,
          icon: icons,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(),
          ),
          //fillColor: Colors.green
        ),
        //validator: (value) => value.isEmpty ? message : null,
        validator: validator,
        onSaved: (value) => onSaved ,
        keyboardType: inputType,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}

