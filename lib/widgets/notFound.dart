import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("🔎",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: new Color(4283848810),
                fontSize: 28.0,
                fontWeight: FontWeight.bold)),
        Text("   Couldn't find any bookings,\n   try creating one!",
            softWrap: true,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: new Color(4283848810),
                fontSize: 18.0,
                fontWeight: FontWeight.bold))
      ],
    );
  }
}
