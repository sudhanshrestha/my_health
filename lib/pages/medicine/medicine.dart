import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_health/bottomNavigation.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/home/home.dart';
import 'package:my_health/pages/medicine/addMedicine.dart';
import 'package:my_health/pages/medicine/editMedicine.dart';

class MedicinePage extends StatefulWidget {
  static const String id = 'MedicinePage';

  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  final ref = FirebaseFirestore.instance
      .collection('Medicine')
      .where('userID', isEqualTo: UserID);

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
                height: 150.0,
                child: Padding(
                  padding: const EdgeInsets.only(left:15.0,top: 75.0),
                  child: Text(
                    "Medicine",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top:20.0),
                height: MediaQuery.of(context).size.height * 0.79,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: mainColor.withOpacity(1.0),
                      spreadRadius: 10,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50.0,),
                      StreamBuilder<QuerySnapshot>(
                          stream: ref.snapshots(),
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
                                                builder: (_) => EditMedicine(
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
                      // MedicineBadge(
                      //   medicineName: "Glemipiride",
                      //   medicineAmount: "2 pills",
                      //   medicineDosage: "5 mg",
                      //   medicineTime: "8:00 AM - 9:00 AM",
                      //   medicineIcon: FontAwesomeIcons.pills,
                      //   randomColor: randomColour,
                      //   medicineTaken: true,
                      // ),
                      SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AddMedicine.id);
        },
        label: Text('Add medicine'),
        icon: Icon(Icons.add),
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
        // this.medicineDosage,
        this.medicineTime,
        this.medicineIcon,
        this.randomColor,this.medicineTaken});

  final String medicineName;
  final String medicineAmount;
  // final String medicineDosage;
  final String medicineTime;
  final IconData medicineIcon;
  final Color randomColor;
  final bool medicineTaken;
  Color iconColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
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

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}