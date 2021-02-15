import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_health/bottomNavigation.dart';
import 'package:random_color/random_color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:my_health/pageAssets.dart';
import 'dart:math';

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
                    ),
                    child: TopCalender(controller: _controller),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6.0),
                  //Same as `blurRadius` i guess
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(

                      topLeft: Radius.circular(50.0),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0,top: 20.0),
                                child: Text(
                                  "Today activities",
                                  style: TextStyle(
                                      fontSize: 24.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              MedicineBadge(
                                medicineName: "Glemipiride",
                                medicineAmount: "2 pills",
                                medicineDosage: "5 mg",
                                medicineTime: "8:00 AM - 9:00 AM",
                                medicineIcon: FontAwesomeIcons.pills,
                                randomColor: randomColour,
                                medicineTaken: true,
                              ),
                              MedicineBadge(
                                medicineName: "Glemipiride",
                                medicineAmount: "1 Injection",
                                medicineDosage: "10 ml",
                                medicineTime: "8:00 PM - 9:00 PM",
                                medicineIcon: FontAwesomeIcons.syringe,
                                randomColor: randomColour,
                                medicineTaken: false,
                              ),
                              MedicineBadge(
                                medicineName: "Glemipiride",
                                medicineAmount: "1 Injection",
                                medicineDosage: "10 ml",
                                medicineTime: "8:00 PM - 9:00 PM",
                                medicineIcon: FontAwesomeIcons.syringe,
                                randomColor: randomColour,
                                medicineTaken: false,
                              ),
                              MedicineBadge(
                                medicineName: "Glemipiride",
                                medicineAmount: "1 Injection",
                                medicineDosage: "10 ml",
                                medicineTime: "8:00 PM - 9:00 PM",
                                medicineIcon: FontAwesomeIcons.syringe,
                                randomColor: randomColour,
                                medicineTaken: false,
                              ),
                              MedicineBadge(
                                medicineName: "Glemipiride",
                                medicineAmount: "1 Injection",
                                medicineDosage: "10 ml",
                                medicineTime: "8:00 PM - 9:00 PM",
                                medicineIcon: FontAwesomeIcons.syringe,
                                randomColor: randomColour,
                                medicineTaken: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
        shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))
        ),
        backgroundColor: Colors.indigo,
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

// ignore: must_be_immutable
class MedicineBadge extends StatelessWidget {
  MedicineBadge(
      {this.medicineName,
      this.medicineAmount,
      this.medicineDosage,
      this.medicineTime,
      this.medicineIcon,
      this.randomColor,this.medicineTaken});

  final String medicineName;
  final String medicineAmount;
  final String medicineDosage;
  final String medicineTime;
  final IconData medicineIcon;
  final Color randomColor;
  final bool medicineTaken;
  Color iconColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(medicineName);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          margin: const EdgeInsets.only(bottom: 6.0),
          //Same as `blurRadius` i guess
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 10,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 35.0, left: 15.0, right: 15.0, bottom: 35.0),
                          child: Icon(
                            medicineIcon,
                            size: 40.0,
                            color: iconColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Text(
                          medicineName,
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Text(
                          " $medicineAmount ($medicineDosage)",
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[700]),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(MdiIcons.clock),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            medicineTime,
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 55.0,),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6.0),
                    //Same as `blurRadius` i guess
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: medicineTaken == true ? Colors.green[100] : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(IcoFontIcons.tickMark,color: medicineTaken == true ? Colors.green : Colors.grey,),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
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
  })  : _controller = controller,
        super(key: key);

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
                padding: const EdgeInsets.only(left: 15.0, top: 25.0),
                child: Text(
                  "My reminders",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TableCalendar(
                  initialCalendarFormat: CalendarFormat.week,
                  calendarStyle: CalendarStyle(
                      todayColor: Colors.green,
                      selectedColor: mainColor,
                      todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      )),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                  ),
                  onDaySelected: (day, events, holidays) =>
                      print(day.toString()),
                  calendarController: _controller,
                ),
              ),
            ]),
      ],
    );
  }
}
