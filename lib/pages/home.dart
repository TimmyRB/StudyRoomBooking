// Packages
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:StudyRoomBooking/firebase/auth.dart';
import 'package:StudyRoomBooking/firebase/user.dart';
import 'package:StudyRoomBooking/firebase/book.dart';

// Pages & Widgets
import 'package:StudyRoomBooking/views/bookings.dart';
import 'package:StudyRoomBooking/views/qr.dart';
import 'package:StudyRoomBooking/views/settings.dart';
import 'package:StudyRoomBooking/popups/bookPopup.dart';

class HomePage extends StatefulWidget {
  HomePage(
      {Key key,
      this.auth,
      this.userId,
      this.logoutCallback,
      this.userDB,
      this.booker})
      : super(key: key);

  final BaseAuth auth;
  final BaseUser userDB;
  final BaseBooker booker;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _views = [];
  GlobalKey _scaffold = new GlobalKey<ScaffoldState>();

  List<FloatingActionButton> _buttons = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _views = [
      BookingsPage(
          userId: widget.userId,
          userDB: widget.userDB,
          auth: widget.auth,
          booker: widget.booker),
      QRPage(),
      SettingsPage(userId: widget.userId, logoutCallback: widget.logoutCallback)
    ];

    _buttons = [
      FloatingActionButton(
        onPressed: () {
          Future.delayed(Duration.zero, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BookPopup(booker: widget.booker, userId: widget.userId)),
            );
          });
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: new Color(4278217215),
      ),
      null,
      null
    ];
  }

  @override
  dispose() {
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
    widget.auth.isEmailVerified().then((v) {
      if (!v) {
        print("Email not Verified");
      }
    });
    return Scaffold(
      key: _scaffold,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(child: _views[_currentIndex]),
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
          BubbleBottomBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(
                Icons.calendar_today,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.calendar_today,
                color: Colors.blue,
              ),
              title: Text("Bookings")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.photo_camera,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.photo_camera,
                color: Colors.deepPurple,
              ),
              title: Text("QR Scannner")),
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: Colors.red,
              ),
              title: Text("Settings"))
        ],
      ),
    );
  }
}
