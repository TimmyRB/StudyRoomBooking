// Packages
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:StudyRoomBooking/firebase/auth.dart';

// Pages
import 'package:StudyRoomBooking/pages/home.dart';
import 'package:StudyRoomBooking/pages/login.dart';

void main() => initializeDateFormatting().then((_) => runApp(Main()));

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Room Booking',
      theme: ThemeData(
          backgroundColor: new Color(4280164664),
          primaryColor: new Color(4278217215),
          accentColor: new Color(4294967295),
          canvasColor: new Color(4293849073),
          fontFamily: 'Calibri',
          textTheme: new TextTheme(
              headline: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              display1: TextStyle(color: new Color(4294967295), fontSize: 16.0),
              display2: TextStyle(color: new Color(4280164664), fontSize: 16.0),
              display3: TextStyle(color: new Color(4283848810), fontSize: 16.0),
              title: TextStyle(
                  color: new Color(4294967295),
                  fontSize: 38.0,
                  fontWeight: FontWeight.bold),
              subtitle: TextStyle(color: new Color(4283848810), fontSize: 26.0),
              display4: TextStyle(
                  color: new Color(4280164664),
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold),
              subhead:
                  TextStyle(color: new Color(4290625220), fontSize: 33.0))),
      home: new Root(auth: new Auth()),
    );
  }
}

class Root extends StatefulWidget {
  Root({Key key, this.auth}) : super(key: key);

  final BaseAuth auth;

  @override
  RootState createState() => RootState();
}

class RootState extends State<Root> {
  
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  @override
  dispose() {
    super.dispose();
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() async {
    await widget.auth.signOut();
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomePage(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
