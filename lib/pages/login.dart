// Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:StudyRoomBooking/firebase/auth.dart';

// Pages & Widgets

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.auth, this.loginCallback}) : super(key: key);

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  String _signinError = "";

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[BoxShadow(blurRadius: 6.0)],
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 30, left: 25, right: 25, bottom: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          // Top Widgets
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Welcome back",
                                style: Theme.of(context).textTheme.display4),
                            Text("sign in to continue",
                                style: Theme.of(context).textTheme.subhead),
                            Text(_signinError,
                                style: TextStyle(
                                    color: new Color(4293278022),
                                    fontSize: 18.0)),
                            Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFormField(
                                      controller: _emailController,
                                      autocorrect: false,
                                      obscureText: false,
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                          color: new Color(4290625220),
                                          fontSize: 18.0),
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.email),
                                          hasFloatingPlaceholder: false,
                                          isDense: true,
                                          filled: true,
                                          fillColor: Color(4294967295),
                                          labelText: "Email",
                                          labelStyle: TextStyle(
                                              color: new Color(4290625220),
                                              fontSize: 20.0),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              borderSide: BorderSide(
                                                color: Color(4294967295),
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(4278217215),
                                                  width: 1.5))),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    TextFormField(
                                      controller: _passController,
                                      autocorrect: false,
                                      obscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      style: TextStyle(
                                          color: new Color(4290625220),
                                          fontSize: 18.0),
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.vpn_key),
                                          hasFloatingPlaceholder: false,
                                          isDense: true,
                                          filled: true,
                                          fillColor: Color(4294967295),
                                          labelText: "Password",
                                          labelStyle: TextStyle(
                                              color: new Color(4290625220),
                                              fontSize: 20.0),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              borderSide: BorderSide(
                                                color: Color(4294967295),
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(4278217215),
                                                  width: 1.5))),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        FlatButton(
                                          padding: EdgeInsets.all(0),
                                          splashColor:
                                              Theme.of(context).canvasColor,
                                          focusColor:
                                              Theme.of(context).canvasColor,
                                          hoverColor:
                                              Theme.of(context).canvasColor,
                                          highlightColor:
                                              Theme.of(context).canvasColor,
                                          onPressed: () {},
                                          child: Text("Forgot Password",
                                              style: TextStyle(
                                                  color: new Color(4290625220),
                                                  fontSize: 16.0)),
                                        ),
                                        FlatButton(
                                          padding: EdgeInsets.all(0),
                                          splashColor:
                                              Theme.of(context).canvasColor,
                                          focusColor:
                                              Theme.of(context).canvasColor,
                                          hoverColor:
                                              Theme.of(context).canvasColor,
                                          highlightColor:
                                              Theme.of(context).canvasColor,
                                          onPressed: () {},
                                          child: Text("Create an account",
                                              style: TextStyle(
                                                  color: new Color(4278217215),
                                                  fontSize: 16.0)),
                                        ),
                                      ],
                                    ),
                                    ButtonTheme(
                                      buttonColor:
                                          Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      minWidth: double.infinity,
                                      height: 46.0,
                                      child: RaisedButton(
                                        onPressed: () async {
                                          try {
                                            String userId = await widget.auth.signIn(_emailController.text, _passController.text);
                                            print('Signed in user: $userId');

                                            if (userId.length > 0 && userId != null)
                                              widget.loginCallback();
                                          } catch (e) {
                                            setState(() {
                                              _signinError = _handleAuthErrors(e);
                                            });
                                          }
                                        },
                                        child: Text("Sign in",
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1),
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ],
                    ),
                  )))
        ],
      )),
    );
  }

  String _handleAuthErrors (var error) {
    String e = error.code.toLowerCase().trim();
    switch (e) {
      case "error":
        return "Email & Password cannot be empty";
        break;

      case "error_invalid_email":
        return "That email doesn't look right...";
        break;

      case "error_user_not_found":
        return "No user found with that email & password";
        break;

      case "error_wrong_password":
        return "No user found with that email & password";
        break;

      case "error_user_disabled":
        return "Account was disabled, please contact support";
        break;

      default:
        print("Unknown error: \"$e\"");
        return "Please try again later or contact support\nerror code: $e";
        break;
    }
  }
}
