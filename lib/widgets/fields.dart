import 'package:flutter/material.dart';

Widget Field(
    {final String label,
    final TextEditingController controller,
    final TextInputType keyboardType,
    final Icon prefixIcon,
    final bool autoCorrect,
    final bool obscureText}) {
  return TextFormField(
    controller: controller,
    autocorrect: autoCorrect,
    obscureText: obscureText,
    keyboardType: keyboardType,
    style: TextStyle(color: new Color(4290625220), fontSize: 18.0),
    decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hasFloatingPlaceholder: false,
        isDense: true,
        filled: true,
        fillColor: Color(4294967295),
        labelText: label,
        labelStyle: TextStyle(color: new Color(4290625220), fontSize: 20.0),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: Color(4294967295),
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(4278217215), width: 1.5))),
  );
}

Widget TitleField(
    {final String label,
    final TextEditingController controller,
    final TextInputType keyboardType,
    final Icon prefixIcon,
    final bool autoCorrect,
    final bool obscureText}) {
  return TextFormField(
    maxLength: 30,
    controller: controller,
    autocorrect: autoCorrect,
    obscureText: obscureText,
    keyboardType: keyboardType,
    style: TextStyle(color: new Color(4280164664), fontSize: 20.0, fontFamily: 'Calibri', fontWeight: FontWeight.bold),
    decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hasFloatingPlaceholder: false,
        isDense: false,
        labelText: label,
        labelStyle: TextStyle(color: new Color(4280164664), fontSize: 20.0, fontFamily: 'Calibri', fontWeight: FontWeight.bold),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(4293322733)
          )
        )
        ),
  );
}
