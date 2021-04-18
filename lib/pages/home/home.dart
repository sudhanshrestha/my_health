import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_health/bottomNavigation.dart';
import 'package:my_health/notification/notification_plugin.dart';
import 'package:my_health/pages/Other/Profile/profile.dart';
import 'package:my_health/pages/home/medicineTaken.dart';
import 'package:my_health/pages/medicine/addMedicine.dart';
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

  Medicine(this.docID, this.name, this.dose, this.medicineType,
      this.medicineStock, this.time);
}

class HomePage extends StatefulWidget {
  static const String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin fltrNotifcation;
  final _auth = FirebaseAuth.instance;
  final ref = FirebaseFirestore.instance.collection('profile').doc(UserID);

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
    } catch (e) {
      print(e);
    }
  }

  bool medicineStat;
  String firebaseBooleans;

  bool medicineStatus;
  CalendarController _controller;
  final NotificationPlugin notificationPlugin = NotificationPlugin();

  String displayDate = new DateFormat("MMMM d").format(DateTime.now());

  iconMedicine (String medicine){
    if(medicine == 'Pill'){
      return FontAwesomeIcons.pills;
    }
    if(medicine == 'Inhaler'){
      return MdiIcons.spray;
    }
    if(medicine == 'Solution'){
      return MdiIcons.bottleTonicPlus;
    }
    if(medicine == 'Injection'){
      return IcoFontIcons.injectionSyringe;
    }
    if(medicine == 'Powder'){
      return IcoFontIcons.medicalSign;
    }
    if(medicine == 'Drops'){
      return EvaIcons.droplet;
    }

  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 200.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: mainColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 25.0),
                      child: Row(
                        children: [
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('profile')
                                .doc(UserID)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Loading",style:TextStyle(
                                    fontSize: 28.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),);
                              }
                              var usrData = snapshot.data;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    "Hi ${usrData["name"]},",
                                    style: TextStyle(
                                        fontSize: 28.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Today, ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            displayDate.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // child: TopCalender(controller: _controller),
              ),
              Container(
                height: 700,
                padding: EdgeInsets.only(top: 20.0),
                margin: const EdgeInsets.only(bottom: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: mainColor.withOpacity(0.8),
                      offset: Offset(-1.0, -7.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 20.0),
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
                                .where('userID', isEqualTo: UserID)
                                .snapshots(),
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
                                      /*
                                      * In item medicine card creation
                                      * Check the date of data base with current date and
                                      * Update the necessary values needed to be updated daily
                                      * */
                                      List<String> boolVal = [];
                                      String boolValues = snapshot
                                          .data.docs[index]
                                          .data()['BooleanValues'];
                                      boolVal = boolValues.split(',');
                                      int booleanLength = boolVal.length;
                                      List<String> newboolVal = [];
                                      DateTime now = DateTime.now();
                                      var todayDate = DateFormat('yyyy-MM-dd')
                                          .format(now);
                                      String docDate = snapshot
                                          .data.docs[index]
                                          .data()['DateStamp'];
                                      //if docDate is not equals to current date
                                      if (docDate != todayDate) {
                                        print('Daily changes made');
                                        for (int i = 0;
                                            i < booleanLength;
                                            i++) {
                                          newboolVal.add('false');
                                        }
                                        snapshot.data.docs[index].reference
                                            .update({
                                          'DateStamp': todayDate,
                                          'BooleanValues': (newboolVal
                                                  .toString()
                                                  .replaceAll("]", ""))
                                              .replaceAll("[", ""),
                                          'MedicineTaken': 'false',
                                        });
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          // only navigates if the value  false
                                          if (snapshot.data.docs[index]
                                                  .data()['MedicineTaken'] !=
                                              'true') {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        MedicineTaken(
                                                            docToEdit:
                                                                snapshot.data
                                                                        .docs[
                                                                    index])));
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: MedicineBadge(
                                                medicineName: snapshot
                                                    .data.docs[index]
                                                    .data()['Name'],
                                                medicineAmount: snapshot
                                                        .data.docs[index]
                                                        .data()['Dose'] +
                                                    " " +
                                                    snapshot.data.docs[index]
                                                        .data()['MedicineType'],
                                                medicineTime: snapshot
                                                    .data.docs[index]
                                                    .data()['ReminderTime']
                                                    .toString(),
                                                medicineIcon: iconMedicine(snapshot.data.docs[index]
                                                    .data()['MedicineType'].toString()),
                                                randomColor: randomColour,
                                                medicineTaken: medicineStat =
                                                    snapshot.data.docs[index]
                                                                .data()[
                                                            'MedicineTaken'] ==
                                                        'true',
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              );
                            }),
                        SizedBox(height: 150,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showNotification();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddMedicine()),
          );
        },
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        backgroundColor: mainColor,
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
      this.randomColor,
      this.medicineTaken});

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
      padding: const EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
      child: Container(
        width: 390,
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
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
                  SizedBox(width: 50,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: medicineTaken == true
                              ? Colors.green[100]
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            IcoFontIcons.tickMark,
                            color: medicineTaken == true
                                ? Colors.green
                                : Colors.grey,
                          ),
                          onPressed: null,
                        ),
                      ),
                    ],
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
                      todayColor: Colors.indigoAccent,
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
