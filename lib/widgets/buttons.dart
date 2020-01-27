import 'package:flutter/material.dart';

Widget AuthButton({final BuildContext context, final VoidCallback onPressed, final String label}) {
  return ButtonTheme(
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
      child: Text(label, style: Theme.of(context).textTheme.display1),
    ),
  );
}
