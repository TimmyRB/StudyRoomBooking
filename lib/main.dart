import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:StudyRoomBooking/home.dart';

void main() => initializeDateFormatting().then((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Room Booking',
      theme: ThemeData(
        backgroundColor: new Color(4280164664),
        primaryColor: new Color(4278217215),
        accentColor: new Color(4294967295),
        canvasColor: new Color(4294507003),
        fontFamily: 'Calibri',
        textTheme: new TextTheme(
          headline: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
          display1: TextStyle(color: new Color(4294967295), fontSize: 16.0),
          display2: TextStyle(color: new Color(4280164664), fontSize: 16.0),
          display3: TextStyle(color: new Color(4283848810), fontSize: 16.0),
          title: TextStyle(color: new Color(4294967295), fontSize: 38.0, fontWeight: FontWeight.bold),
          subtitle: TextStyle(color: new Color(4283848810), fontSize: 26.0)
        )
      ),
      home: HomePage(title: 'Home Page'),
    );
  }
}