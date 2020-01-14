import 'package:flutter/material.dart';

class BookingsPage extends StatefulWidget {
  BookingsPage({Key key}) : super(key: key);

  @override
  BookingsState createState() => BookingsState();
}

class BookingsState extends State<BookingsPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('👻 Bookings Page will go here...', style: Theme.of(context).textTheme.headline)
        ],
      ),
    );
  }
}