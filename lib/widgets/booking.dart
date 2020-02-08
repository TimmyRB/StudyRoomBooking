import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget Booking(
    {final String title,
    final DateTime start,
    final DateTime end,
    final String roomName,
    final int chairs,
    final int screens,
    final int partySize}) {
  return Card(
      elevation: 0.0,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(title,
                    softWrap: true,
                    style: TextStyle(
                        color: new Color(4280164664),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold))
              ],
            ),
            Row(children: <Widget>[
              Text(
                  DateFormat.Hm().format(start) + " - " + DateFormat.Hm().format(end) + " | " + roomName,
                  style:
                      TextStyle(color: new Color(4290625220), fontSize: 16.0))
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(chairs.toString(),
                    style: TextStyle(
                        color: new Color(4290625220), fontSize: 16.0)),
                Icon(Icons.event_seat, color: new Color(4290625220), size: 18),
                Text(' • ' + screens.toString(),
                    style: TextStyle(
                        color: new Color(4290625220), fontSize: 16.0)),
                Icon(Icons.tv, color: new Color(4290625220), size: 18),
                Text(' • ' + partySize.toString(),
                    style: TextStyle(
                        color: new Color(4290625220), fontSize: 16.0)),
                Icon(Icons.people, color: new Color(4290625220), size: 18)
              ],
            )
          ],
        ),
      ));
}
