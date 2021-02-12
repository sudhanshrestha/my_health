import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:my_health/pageAssets.dart';

class HomePage extends StatefulWidget {
  static const String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 220.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(38.0),
                        bottomLeft: Radius.circular(38.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0.0, 0.75)),
                      ],
                    ),
                    child: TopCalender(controller: _controller),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class TopCalender extends StatelessWidget {
  const TopCalender({
    Key key,
    @required CalendarController controller,
  }) : _controller = controller, super(key: key);

  final CalendarController _controller;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, top: 25.0),
                child: Text(
                  "My reminders",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
                child: TableCalendar(
                  initialCalendarFormat: CalendarFormat.week,
                  calendarStyle: CalendarStyle(
                    todayColor: Colors.green,
                    selectedColor: mainColor,
                    todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    )
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                  ),
                  onDaySelected: (day, events, holidays) => print(day.toString()),
                  calendarController: _controller,
                ),
              ),
            ]),
      ],
    );
  }
}
