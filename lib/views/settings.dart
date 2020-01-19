// Packages
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.userId, this.logoutCallback}) : super(key: key);

  final VoidCallback logoutCallback;
  final String userId;

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('👻 Settings Page will go here...',
              style: Theme.of(context).textTheme.headline),
          RaisedButton(
            child: Text("Logout"),
            onPressed: () {
              widget.logoutCallback();
            },
          )
        ],
      ),
    );
  }
}
