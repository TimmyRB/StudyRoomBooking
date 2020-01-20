import 'package:flutter/material.dart';

Widget LoginButton({final BuildContext context, final VoidCallback onPressed}) {
  ButtonTheme(
    buttonColor: Theme.of(context).primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    minWidth: double.infinity,
    height: 46.0,
    child: RaisedButton(
      onPressed: () async {
        onPressed();
      },
      child: Text("Sign in", style: Theme.of(context).textTheme.display1),
    ),
  );
}
