// Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:StudyRoomBooking/firebase/auth.dart';

// Pages & Widgets
import 'package:StudyRoomBooking/pages/login.dart';
import 'package:StudyRoomBooking/widgets/loginForm.dart';
import 'package:StudyRoomBooking/widgets/buttons.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key, this.auth, this.signupCallback}) : super(key: key);

  final BaseAuth auth;
  final VoidCallback signupCallback;

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<SignupPage> {
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
                        top: 7, left: 25, right: 25, bottom: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          // Top Widgets
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 0,
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                splashColor: Theme.of(context).canvasColor,
                                focusColor: Theme.of(context).canvasColor,
                                hoverColor: Theme.of(context).canvasColor,
                                highlightColor: Theme.of(context).canvasColor,
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  );
                                },
                                child: Text("< Sign in",
                                    style: TextStyle(
                                        color: new Color(4278217215),
                                        fontSize: 16.0)),
                              ),
                            ),
                            Text("Welcome",
                                style: Theme.of(context).textTheme.display4),
                            Text("create your account",
                                style: TextStyle(
                                    color: new Color(4290625220),
                                    fontSize: 27.0)),
                            Text(_signinError,
                                style: TextStyle(
                                    color: new Color(4293278022),
                                    fontSize: 16.0)),
                            Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Field(
                                              label: "Name",
                                              prefixIcon: Icon(Icons.person),
                                              keyboardType: TextInputType.text,
                                              autoCorrect: true,
                                              obscureText: false),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.015,
                                        ),
                                        Expanded(
                                          child: Field(
                                              label: "Surname",
                                              prefixIcon: Icon(Icons.people),
                                              keyboardType: TextInputType.text,
                                              autoCorrect: true,
                                              obscureText: false),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Field(
                                      label: "Email",
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      prefixIcon: Icon(Icons.email),
                                      autoCorrect: false,
                                      obscureText: false,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Field(
                                      label: "Password",
                                      controller: _passController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      prefixIcon: Icon(Icons.vpn_key),
                                      autoCorrect: false,
                                      obscureText: true,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    AuthButton(
                                        context: context,
                                        label: "Sign up",
                                        onPressed: () async {
                                          try {
                                            String userId = await widget.auth
                                                .signUp(_emailController.text,
                                                    _passController.text);
                                            print('Signed up user: $userId');

                                            if (userId.length > 0 &&
                                                userId != null) {
                                              widget.auth
                                                  .sendEmailVerification();
                                              widget.signupCallback();
                                              Navigator.pop(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()),
                                              );
                                            }
                                          } catch (e) {
                                            setState(() {
                                              _signinError =
                                                  _handleAuthErrors(e);
                                            });
                                          }
                                        })
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

  String _handleAuthErrors(var error) {
    String e = error.code.toLowerCase().trim();
    switch (e) {
      case "error":
        return "Email & Password cannot be empty";
        break;

      case "error_invalid_email":
        return "That email doesn't look right...";
        break;

      case "error_email_already_in_use":
        return "Email address is already in use";
        break;

      case "error_wrong_password":
        return "No user found with that email & password";
        break;

      case "error_weak_password":
        return "Password is too weak";
        break;

      default:
        print("Unknown error: \"$e\"");
        return "Please try again later or contact support\nerror code: $e";
        break;
    }
  }
}
