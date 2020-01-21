import 'package:flutter/material.dart';

Widget ForgotCreate(
    {final BuildContext context,
    final VoidCallback forgotCallback,
    final VoidCallback createCallback}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      FlatButton(
        padding: EdgeInsets.all(0),
        splashColor: Theme.of(context).canvasColor,
        focusColor: Theme.of(context).canvasColor,
        hoverColor: Theme.of(context).canvasColor,
        highlightColor: Theme.of(context).canvasColor,
        onPressed: () {
          forgotCallback();
        },
        child: Text("Forgot Password",
            style: TextStyle(color: new Color(4290625220), fontSize: 16.0)),
      ),
      FlatButton(
        padding: EdgeInsets.all(0),
        splashColor: Theme.of(context).canvasColor,
        focusColor: Theme.of(context).canvasColor,
        hoverColor: Theme.of(context).canvasColor,
        highlightColor: Theme.of(context).canvasColor,
        onPressed: () {
          createCallback();
        },
        child: Text("Create an account",
            style: TextStyle(color: new Color(4278217215), fontSize: 16.0)),
      ),
    ],
  );
}
