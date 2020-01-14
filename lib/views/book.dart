import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BookPage extends StatefulWidget {
  BookPage({Key key}) : super(key: key);

  @override
  BookState createState() => BookState();
}

class BookState extends State<BookPage> {

  CalendarController _calendarController;

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
            child: TableCalendar(
              availableCalendarFormats: {CalendarFormat.month : 'Month'},
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
                outsideStyle: Theme.of(context).textTheme.display2,
                outsideWeekendStyle: Theme.of(context).textTheme.display2,
                unavailableStyle: Theme.of(context).textTheme.display2,
                todayColor: Theme.of(context).buttonColor,
                selectedColor: Theme.of(context).primaryColor
              ),
            )
          )
        ],
      ),
    );
  }
}