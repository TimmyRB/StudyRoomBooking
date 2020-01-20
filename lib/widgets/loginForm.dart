import 'package:flutter/material.dart';

Widget Field(TextEditingController _controller, String _label,
    TextInputType _keyboardType, Icon _prefixIcon, bool _autoCorrect, bool _obsureText) {
  return TextFormField(
    controller: _controller,
    autocorrect: _autoCorrect,
    obscureText: _obsureText,
    keyboardType: _keyboardType,
    style: TextStyle(color: new Color(4290625220), fontSize: 18.0),
    decoration: InputDecoration(
        prefixIcon: _prefixIcon,
        hasFloatingPlaceholder: false,
        isDense: true,
        filled: true,
        fillColor: Color(4294967295),
        labelText: _label,
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
