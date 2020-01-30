// Packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:StudyRoomBooking/widgets/fields.dart';
import 'package:StudyRoomBooking/widgets/buttons.dart';

class BookPopup extends StatefulWidget {
  BookPopup({Key key}) : super(key: key);

  @override
  BookPopupState createState() => BookPopupState();
}

class BookPopupState extends State<BookPopup> {
  TextEditingController _titleController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    _getName().then((name) {
      setState(() {
        _titleController.text = (name != null ? name + "'s Booking" : "");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String n = prefs.getString('name');
    return n;
  }

  @override
  Widget build(BuildContext context) {
    final double _space = 0.010;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
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
                    padding: EdgeInsets.only(right: 25, left: 25, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        CloseButton(

                        ),
                        TitleField(
                          controller: _titleController,
                          label: 'Booking Title',
                          obscureText: false,
                          autoCorrect: true,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        BookOptionButton(
                            context: context,
                            label: 'Date',
                            icon: Icons.calendar_today,
                            infoLabel: DateFormat('MMM dd, yyyy')
                                .format(DateTime.now())),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * _space),
                        BookOptionButton(
                            context: context,
                            label: 'Time',
                            icon: Icons.access_time,
                            infoLabel: 'ASAP'),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * _space),
                        BookOptionButton(
                            context: context,
                            label: 'Duration',
                            icon: Icons.access_alarm,
                            infoLabel: 'Doesn\'t Matter'),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * _space),
                        BookOptionButton(
                            context: context,
                            label: 'Room',
                            icon: Icons.room,
                            infoLabel: 'Any'),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * _space),
                        BookOptionButton(
                            context: context,
                            label: 'Attendees',
                            icon: Icons.people,
                            infoLabel: '1'),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * _space),
                        BookOptionButton(
                            context: context,
                            label: 'Tag colour',
                            icon: Icons.crop_square,
                            infoLabel: '',
                            iconColor: Colors.red),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.20),
                      ],
                    ),
                  ))),
          SizedBox(
              height: 85,
              width: double.infinity,
              child: DecoratedBox(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.check_circle, color: Colors.white, size: 20),
                              SizedBox(width: 10),
                              Text('Confirm Booking',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Calibri',
                                    fontSize: 17,
                                  ))
                            ]),
                        FloatingActionButton(
                          child: Icon(Icons.chevron_right),
                          onPressed: () {},
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
