import 'package:flutter/material.dart';

Widget AuthButton({final BuildContext context, final VoidCallback onPressed, final String label}) {
  return ButtonTheme(
    buttonColor: Theme.of(context).primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    minWidth: double.infinity,
    height: 46.0,
    child: RaisedButton(
      onPressed: () async {
        onPressed();
      },
      child: Text(label, style: Theme.of(context).textTheme.display1),
    ),
  );
}

Widget BookOptionButton({final BuildContext context, final VoidCallback onPressed, final String label, final IconData icon, final Color iconColor, final rightWidget}) {

  return ButtonTheme(
    buttonColor: Color(4294967295),
    disabledColor: Color(4294967295),
    padding: EdgeInsets.only(left: 15, right: 5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    minWidth: double.infinity,
    height: 46.0,
    child: RaisedButton(
      elevation: 0.0,
      highlightElevation: 0.0,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 20, color: (iconColor != null ? iconColor : Colors.black)),
              SizedBox(width: 10),
              Text(label, style: TextStyle(color: new Color(4280164664), fontSize: 17.0, fontFamily: 'Calibri'))
            ],
          ),
          rightWidget
        ],
      )
    ),
  );
}