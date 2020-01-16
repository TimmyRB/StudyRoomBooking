// Packages
import 'package:flutter/material.dart';

class BookPopup extends StatefulWidget {
  BookPopup({Key key}) : super(key: key);

  @override
  BookState createState() => BookState();
}

class BookState extends State<BookPopup> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
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
              child: SizedBox(
                width: 500,
                height: 50,
              )
            )
          )
        ],
      ),
    );
  }
}