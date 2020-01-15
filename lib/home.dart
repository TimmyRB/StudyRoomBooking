import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/services.dart';

// Views
import 'package:StudyRoomBooking/views/bookings.dart';
import 'package:StudyRoomBooking/views/qr.dart';
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
    BookingsPage(),
    QRPage(),
    SettingsPage()
  ];

  final List<FloatingActionButton> _buttons = [
    FloatingActionButton(
      onPressed: (){},
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: new Color(4278217215),
    ),
    FloatingActionButton(
      onPressed: null,
      disabledElevation: 0,
      backgroundColor: Colors.transparent,
    ),
    FloatingActionButton(
      onPressed: null,
      disabledElevation: 0,
      backgroundColor: Colors.transparent,
    ),
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

      floatingActionButton: _buttons[_currentIndex], 

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