import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_health/bottomNavigation.dart';
import 'package:my_health/notification/notification_plugin.dart';
import 'package:my_health/pages/Other/Profile/profile.dart';
import 'package:my_health/pages/home/medicineTaken.dart';
import 'package:random_color/random_color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:my_health/pageAssets.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Medicine {
  String docID;
  String name;
  String dose;
  String medicineType;
  String medicineStock;
  String time;

  Medicine(this.docID,this.name,this.dose,this.medicineType,this.medicineStock,this.time);
}
class HomePage extends StatefulWidget {
  static const String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin fltrNotifcation;
  final _auth = FirebaseAuth.instance;
  // final ref = ;
  User loggedInUser;
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        UserID = loggedInUser.uid;
        print(loggedInUser.email);
        print(UserID);
      }
    }
    catch(e){
      print(e);
    }
  }
  CalendarController _controller;
  final NotificationPlugin notificationPlugin = NotificationPlugin();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _controller = CalendarController();


  }
  // showNotification() async {
  //   var androidDetails = AndroidNotificationDetails("channelId", "channelName", "channelDescription",
  //       importance: Importance.max);
  //   var IOSDetails = new IOSNotificationDetails();
  //   var generalNotificationDetails = NotificationDetails(android: androidDetails,iOS: IOSDetails);
  //   //shedualling notification daily
  //   await fltrNotifcation.showDailyAtTime(0, "My Health", "Medicine Reminder",RepeatInterval.daily, generalNotificationDetails);
  // }

  Future notifcationSelected(String payLoad) async{}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                height: 50.0,
              ),
              Container(
                //remove this if error
                margin: const EdgeInsets.only(bottom: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      offset: Offset(-1.0, -7.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
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
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Medicine')
                                      .where('userID', isEqualTo: UserID).snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    return ClipRect(
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: snapshot.hasData
                                              ? snapshot.data.docs.length
                                              : 0,
                                          itemBuilder: (_, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) => MedicineTaken(
                                                            docToEdit: snapshot
                                                                .data.docs[index])));
                                              },
                                              child: MedicineBadge(
                                                medicineName: snapshot.data.docs[index]
                                                    .data()['Name'],
                                                medicineAmount: snapshot.data.docs[index]
                                                    .data()['Dose'] +" "+ snapshot.data.docs[index]
                                                    .data()['MedicineType'],
                                                medicineTime: snapshot.data.docs[index]
                                                    .data()['ReminderTime'].toString(),
                                                medicineIcon: FontAwesomeIcons.pills,
                                                randomColor: randomColour,
                                                medicineTaken: true,
                                              ),
                                            );
                                          }),
                                    );
                                  }),

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
        onPressed: (){
          // showNotification();
            notificationPlugin.cancelAllNotifications();
            print('all notification cancelled');

        },
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
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,right: 10.0, left: 10.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 6.0),
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
                        " $medicineAmount",
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
                SizedBox(width: 70.0,),
                Container(
                  margin: const EdgeInsets.only(bottom: 6.0),
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
                    onPressed: null,

                  ),
                ),
              ],
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
