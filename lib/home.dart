import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/services.dart';

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
    SettingsPage(),
    SettingsPage()
  ];

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: SafeArea(
        child: _views[_currentIndex]
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
      ), 

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Theme.of(context).canvasColor,
        opacity: .15,
        currentIndex: _currentIndex,
        onTap: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(backgroundColor: Colors.blue, icon: Icon(Icons.calendar_today, color: Colors.black,), activeIcon: Icon(Icons.calendar_today, color: Colors.blue,), title: Text("Bookings")),
            BubbleBottomBarItem(backgroundColor: Colors.deepPurple, icon: Icon(Icons.photo_camera, color: Colors.black,), activeIcon: Icon(Icons.photo_camera, color: Colors.deepPurple,), title: Text("QR Scannner")),
            BubbleBottomBarItem(backgroundColor: Colors.red, icon: Icon(Icons.settings, color: Colors.black,), activeIcon: Icon(Icons.settings, color: Colors.red,), title: Text("Settings"))
        ],
      ),
    );
  }
}