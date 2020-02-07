import 'package:flutter/material.dart';

Widget Booking(
    {final String title,
    final DateTime start,
    final DateTime end,
    final String roomName,
    final int chairs,
    final int screens}) {
  return Card(
    color: Colors.white,
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[Text(title)],
        ),
        Row(children: <Widget>[
          Text(start.hour.toString() +
              ':' +
              start.minute.toString() +
              ' - ' +
              end.hour.toString() +
              ':' +
              end.minute.toString() +
              ' | ' +
              roomName)
        ]),
        Row(
          children: <Widget>[
            Text(chairs.toString()),
            Icon(Icons.event_seat),
            Text(screens.toString()),
            Icon(Icons.tv)
          ],
        )
      ],
    ),
  );
}
