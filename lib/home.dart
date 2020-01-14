import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

// Views
import 'package:StudyRoomBooking/views/book.dart';
import 'package:StudyRoomBooking/views/bookings.dart';
import 'package:StudyRoomBooking/views/settings.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {

  int _currentIndex = 0;
  final List<Widget> _views = [
    BookPage(),
    BookingsPage(),
    SettingsPage()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: _views[_currentIndex]
        ),
      ), 

      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: _currentIndex,
        onTap: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 7,
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(backgroundColor: Colors.blue, icon: Icon(Icons.calendar_today, color: Colors.black,), activeIcon: Icon(Icons.calendar_today, color: Colors.blue,), title: Text("Book")),
            BubbleBottomBarItem(backgroundColor: Colors.deepPurple, icon: Icon(Icons.calendar_view_day, color: Colors.black,), activeIcon: Icon(Icons.calendar_view_day, color: Colors.deepPurple,), title: Text("Bookings")),
            BubbleBottomBarItem(backgroundColor: Colors.red, icon: Icon(Icons.settings, color: Colors.black,), activeIcon: Icon(Icons.settings, color: Colors.red,), title: Text("Settings"))
        ],
      ),
    );
  }
}