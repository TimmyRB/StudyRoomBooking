import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: new Image.asset('images/cat.png',
                  height: 85.0, width: 150.0, fit: BoxFit.fitWidth),
            ),
            Text("nothing to see here",
                softWrap: true, style: Theme.of(context).textTheme.display2)
          ],
        )
      ],
    );
  }
}
