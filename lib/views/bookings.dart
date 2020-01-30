// Packages
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:StudyRoomBooking/firebase/user.dart';
import 'package:StudyRoomBooking/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Pages & Widgets
import 'package:StudyRoomBooking/widgets/notFound.dart';

class BookingsPage extends StatefulWidget {
  BookingsPage({Key key, this.userId, this.userDB, this.auth}) : super(key: key);

  final BaseUser userDB;
  final BaseAuth auth;
  final String userId;

  @override
  BookingsState createState() => BookingsState();
}

class BookingsState extends State<BookingsPage> {
  CalendarController _calendarController;
  String _name = "";
  String _photo = "https://ui-avatars.com/api/?name=No+User";

  @override
  void initState() {
    super.initState();
    _calendarController = new CalendarController();
    widget.userDB.getUserName(widget.userId).then((name) {
      setState(() {
        _name = name;
      });
    });

    Future(() async {
      await widget.auth.getCurrentUser().then((user) {
        setState(() {
          _photo = (user.photoUrl != null ? user.photoUrl : "https://ui-avatars.com/api/?name=No+User");
        });
      });
    });
  }

  @override
  void dispose() {
    _calendarController.dispose();
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
          Container(
            padding: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Hello,",
                          style: Theme.of(context).textTheme.subtitle),
                      Text(_name + "!", style: Theme.of(context).textTheme.title)
                    ]),
                Column(children: <Widget>[
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        _photo),
                    backgroundColor: Colors.transparent,
                  )
                ])
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: TableCalendar(
              startDay: DateTime.now(),
              endDay: DateTime.now().add(new Duration(days: 14)),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              initialCalendarFormat: CalendarFormat.week,
              availableCalendarFormats: {CalendarFormat.week: 'Week'},
              calendarController: _calendarController,
              headerStyle: HeaderStyle(
                titleTextStyle: Theme.of(context).textTheme.headline,
                rightChevronIcon:
                    Icon(Icons.chevron_right, color: Colors.white),
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: Theme.of(context).textTheme.display3,
                  weekendStyle: Theme.of(context).textTheme.display3),
              calendarStyle: CalendarStyle(
                  weekdayStyle: Theme.of(context).textTheme.display1,
                  weekendStyle: Theme.of(context).textTheme.display1,
                  outsideStyle: Theme.of(context).textTheme.display3,
                  outsideWeekendStyle: Theme.of(context).textTheme.display3,
                  unavailableStyle: Theme.of(context).textTheme.display3,
                  todayColor: Theme.of(context).primaryColor,
                  selectedColor: Theme.of(context).accentColor,
                  selectedStyle: Theme.of(context).textTheme.display2),
            ),
          ),
          Expanded(
              flex: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[BoxShadow(blurRadius: 6.0)],
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: NotFound(),
              ))
        ],
      ),
    );
  }
}
