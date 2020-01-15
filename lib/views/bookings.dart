import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';

class BookingsPage extends StatefulWidget {
  BookingsPage({Key key}) : super(key: key);

  @override
  BookingsState createState() => BookingsState();
}

class BookingsState extends State<BookingsPage> {

  CalendarController _calendarController;
  final _random = new Random();

  @override
  void initState() {
    super.initState();
    _calendarController = new CalendarController();
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
            padding: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Hello,", style: Theme.of(context).textTheme.subtitle),
                    Text("Jacob!", style: Theme.of(context).textTheme.title)
                  ]
                ),
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage("https://api.adorable.io/avatars/256/${_random.nextInt(256)}.png"),
                      backgroundColor: Colors.transparent,
                    )
                  ]
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: TableCalendar(
              initialCalendarFormat: CalendarFormat.week,
              availableCalendarFormats: {CalendarFormat.week : 'Week'},
              calendarController: _calendarController,
              headerStyle: HeaderStyle(
                titleTextStyle: Theme.of(context).textTheme.headline,
                rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: Theme.of(context).textTheme.display3,
                weekendStyle: Theme.of(context).textTheme.display3
              ),
              calendarStyle: CalendarStyle(
                weekdayStyle: Theme.of(context).textTheme.display1,
                weekendStyle: Theme.of(context).textTheme.display1,
                outsideStyle: Theme.of(context).textTheme.display3,
                outsideWeekendStyle: Theme.of(context).textTheme.display3,
                unavailableStyle: Theme.of(context).textTheme.display3,
                todayColor: Theme.of(context).primaryColor,
                selectedColor: Theme.of(context).accentColor,
                selectedStyle: Theme.of(context).textTheme.display2
              ),
            ),
          ),
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