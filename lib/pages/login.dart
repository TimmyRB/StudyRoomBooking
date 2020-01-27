// Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:StudyRoomBooking/firebase/auth.dart';
import 'package:StudyRoomBooking/firebase/user.dart';

// Pages & Widgets
import 'package:StudyRoomBooking/pages/signup.dart';
import 'package:StudyRoomBooking/widgets/fields.dart';
import 'package:StudyRoomBooking/widgets/buttons.dart';
import 'package:StudyRoomBooking/widgets/forgotCreate.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.auth, this.loginCallback, this.signupCallback, this.userDB}) : super(key: key);

  final BaseAuth auth;
  final BaseUser userDB;
  final VoidCallback loginCallback;
  final VoidCallback signupCallback;

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
                                    ForgotCreate(
                                        context: context,
                                        forgotCallback: () {},
                                        createCallback: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignupPage(
                                                      auth: widget.auth,
                                                      signupCallback: widget.signupCallback,
                                                      userDB: widget.userDB,
                                                    )),
                                          );
                                        }),
                                    AuthButton(
                                        context: context,
                                        label: "Sign in",
                                        onPressed: () async {
                                          try {
                                            String userId = await widget.auth
                                                .signIn(_emailController.text,
                                                    _passController.text);
                                            print('Signed in user: $userId');

                                            if (userId.length > 0 &&
                                                userId != null)
                                              widget.loginCallback();
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
