// Packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:StudyRoomBooking/widgets/fields.dart';
import 'package:StudyRoomBooking/widgets/buttons.dart';

class BookPopup extends StatefulWidget {
  BookPopup({Key key}) : super(key: key);

  @override
  BookPopupState createState() => BookPopupState();
}

class BookPopupState extends State<BookPopup> {
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
                            infoLabel: 'Doesn\'t Matter'),
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
                        // BookOptionButton(
                        //     context: context,
                        //     label: 'Tag colour',
                        //     icon: Icons.crop_square,
                        //     infoLabel: '',
                        //     iconColor: Colors.red),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25),
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
                              Icon(Icons.book, color: Colors.white, size: 20),
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
