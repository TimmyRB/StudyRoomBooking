// Packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:StudyRoomBooking/firebase/book.dart';

import 'package:StudyRoomBooking/widgets/fields.dart';
import 'package:StudyRoomBooking/widgets/buttons.dart';

class BookPopup extends StatefulWidget {
  BookPopup({Key key, this.booker, this.userId}) : super(key: key);

  final BaseBooker booker;
  final String userId;

  @override
  BookPopupState createState() => BookPopupState();
}

class BookPopupState extends State<BookPopup> {
  TextEditingController _titleController = new TextEditingController();
  double _sliderVal;
  MaterialColor _tag = Colors.red;
  Map<String, MaterialColor> tags = {
    'red': Colors.red,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'blue': Colors.blue
  };

  TimeOfDay roundUp(TimeOfDay tod, int roundTo) {
    if (tod.minute % roundTo == 0) return tod;

    while (tod.minute % roundTo != 0) {
      tod = TimeOfDay(hour: tod.hour, minute: tod.minute + 1);
    }

    return tod;
  }

  List<TimeOfDay> _times = [];
  TimeOfDay _currTime;

  @override
  void initState() {
    super.initState();

    TimeOfDay rounded = roundUp(TimeOfDay.now(), 30);
    _currTime = rounded;
    int h = rounded.hour;
    int m = rounded.minute;

    _times = [];

    while (!(h == 24 && m == 0)) {
      _times.add(TimeOfDay(hour: h, minute: m));

      if (m == 30) {
        h++;
        m = 0;
      } else {
        m = 30;
      }
    }

    _sliderVal = 0.5;

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
                        CloseButton(),
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
                            rightWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(DateFormat.MMMEd().format(DateTime.now()),
                                    style: TextStyle(
                                        color: new Color(4280164664),
                                        fontSize: 16.0,
                                        fontFamily: 'Calibri',
                                        fontWeight: FontWeight.bold)),
                                Icon(Icons.chevron_right)
                              ],
                            )),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * _space),
                        BookOptionButton(
                            context: context,
                            label: 'Time',
                            icon: Icons.access_time,
                            rightWidget: DropdownButton(
                              value: _currTime,
                              items: _times.map((TimeOfDay tod) {
                                return new DropdownMenuItem<TimeOfDay>(
                                  value: tod,
                                  child: Text(DateFormat.Hm().format(new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, tod.hour, tod.minute)), style: TextStyle(color: new Color(4280164664), fontSize: 17.0, fontFamily: 'Calibri', fontWeight: FontWeight.bold))
                                );
                              }).toList(), 
                              onChanged: (newTOD) {
                                setState(() {
                                  _currTime = newTOD;
                                });
                              },
                              )),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * _space),
                        BookOptionButton(
                            context: context,
                            label: 'Duration',
                            icon: Icons.alarm,
                            rightWidget: Slider.adaptive(
                              value: _sliderVal,
                              label: _sliderVal.toString() + " hrs",
                              max: 5,
                              min: 0.5,
                              divisions: 9,
                              onChanged: (newVal) {
                                setState(() {
                                  _sliderVal = newVal;
                                });
                              },
                            )),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * _space),
                        BookOptionButton(
                            context: context,
                            label: 'Room',
                            icon: Icons.room,
                            rightWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('Any',
                                    style: TextStyle(
                                        color: new Color(4280164664),
                                        fontSize: 16.0,
                                        fontFamily: 'Calibri',
                                        fontWeight: FontWeight.bold)),
                                Icon(Icons.chevron_right)
                              ],
                            )),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * _space),
                        BookOptionButton(
                            context: context,
                            label: 'Attendees',
                            icon: Icons.people,
                            rightWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('1',
                                    style: TextStyle(
                                        color: new Color(4280164664),
                                        fontSize: 16.0,
                                        fontFamily: 'Calibri',
                                        fontWeight: FontWeight.bold)),
                                Icon(Icons.chevron_right)
                              ],
                            )),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * _space),
                        BookOptionButton(
                            context: context,
                            label: 'Tag Colour',
                            icon: Icons.crop_square,
                            iconColor: _tag,
                            rightWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Radio(
                                    value: tags['red'],
                                    groupValue: _tag,
                                    activeColor: tags['red'],
                                    onChanged: (MaterialColor c) {
                                      setState(() {
                                        _tag = c;
                                      });
                                    },
                                  ),
                                  Radio(
                                    value: tags['green'],
                                    groupValue: _tag,
                                    activeColor: tags['green'],
                                    onChanged: (MaterialColor c) {
                                      setState(() {
                                        _tag = c;
                                      });
                                    },
                                  ),
                                  Radio(
                                    value: tags['yellow'],
                                    groupValue: _tag,
                                    activeColor: tags['yellow'],
                                    onChanged: (MaterialColor c) {
                                      setState(() {
                                        _tag = c;
                                      });
                                    },
                                  ),
                                  Radio(
                                    value: tags['blue'],
                                    groupValue: _tag,
                                    activeColor: tags['blue'],
                                    onChanged: (MaterialColor c) {
                                      setState(() {
                                        _tag = c;
                                      });
                                    },
                                  )
                                ])),
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
                              Icon(Icons.check_circle,
                                  color: Colors.white, size: 20),
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
                          onPressed: () {
                            int hours = _sliderVal.floor();
                            double tmpMins = (_sliderVal - hours) * 60;
                            int mins = 0;

                            if (tmpMins != 0) mins = 30;

                            widget.booker.createBooking(
                                widget.userId,
                                "MwciM0sVWoiUEr8k3xe1",
                                _titleController.text,
                                new DateTime.now().millisecondsSinceEpoch,
                                new DateTime.now()
                                    .add(new Duration(
                                        hours: hours, minutes: mins))
                                    .millisecondsSinceEpoch,
                                [widget.userId],
                                color: _tag);

                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
