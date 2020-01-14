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
        backgroundColor: new Color.fromRGBO(40, 46, 121, 1.0),
        primaryColor: new Color.fromRGBO(247, 199, 247, 1.0),
        accentColor: new Color.fromRGBO(239, 239, 239, 1.0),
        buttonColor: new Color.fromRGBO(162, 217, 242, 1.0),
        fontFamily: 'Calibri',
        textTheme: new TextTheme(
          headline: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
          display1: TextStyle(color: Colors.white, fontSize: 18.0),
          display2: TextStyle(color: new Color.fromRGBO(63, 67, 141, 1.0), fontSize: 18.0),
          display3: TextStyle(color: new Color.fromRGBO(162, 217, 242, 1.0), fontSize: 16.0),
        )
      ),
      home: HomePage(title: 'Home Page'),
    );
  }
}