import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/measurement/BloodPressure/addBloodPressure.dart';
import 'package:my_health/pages/measurement/BloodPressure/editBloodPressure.dart';

class BloodPressurePage extends StatefulWidget {
  static const String id = 'BloodPressurePage';

  @override
  _BloodPressurePageState createState() => _BloodPressurePageState();
}

class _BloodPressurePageState extends State<BloodPressurePage> {
  final ref = FirebaseFirestore.instance
      .collection('Measurement_BloodPressure')
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
              Stack(
                children: [
                  Container(
                    height: 175.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 75.0),
                      child: Text(
                        "Blood Pressure",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      iconSize: 30.0,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0),
                height: 700,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 60.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "Blood Pressure (mmHg)",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
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
                                                  builder: (_) => EditBloodPressure(
                                                      docToEdit: snapshot
                                                          .data.docs[index])));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Card(
                                            elevation: 4,
                                            child: Container(
                                              margin: EdgeInsets.all(15.0),
                                              padding: EdgeInsets.all(15.0),
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        snapshot.data.docs[index]
                                                            .data()['sys'],
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                      Text(
                                                        " / ",
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                      Text(
                                                        snapshot.data.docs[index]
                                                            .data()['dia'],
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                      SizedBox(width: 50,),
                                                      Text(
                                                        snapshot.data.docs[index]
                                                            .data()['date'],
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                            FontWeight.normal),
                                                      ),
                                                      Text(
                                                        " , ",
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                            FontWeight.normal),
                                                      ),
                                                      Text(
                                                        snapshot.data.docs[index]
                                                            .data()['time'],
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                            FontWeight.normal),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text(
                                                    snapshot.data.docs[index]
                                                        .data()['note'],
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                        FontWeight.normal),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            }),
                        SizedBox(height: 400,),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AddBloodPressure.id);
        },
        label: Text('Add measurement'),
        icon: Icon(Icons.add),
        backgroundColor: mainColor,
      ),
    );
  }
}
