// Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Pages & Widgets


class PageName extends StatefulWidget {
  PageName({Key key}) : super(key: key);

  @override
  PageState createState() => PageState();
}

class PageState extends State<PageName> {

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

      ),
    );
  }
}