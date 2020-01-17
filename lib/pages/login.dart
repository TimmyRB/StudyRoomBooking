// Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Pages & Widgets


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column (
          children: <Widget>[
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.9,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow> [
                    BoxShadow(
                      blurRadius: 6.0
                    )
                  ],
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                ),
                child: Container (
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Welcome back", style: Theme.of(context).textTheme.display4),
                          Text("sign in to continue", style: Theme.of(context).textTheme.subhead),
                          Form (
                            key: _formKey,
                            child: Column (
                              children: <Widget>[
                                TextFormField(

                                )
                              ],
                            )
                          )
                        ],
                      ),
                    ],
                  ),
                )
              )
            )
          ],
        )
      ),
    );
  }
}