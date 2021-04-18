import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_health/pageAssets.dart';

class MedicineHistory extends StatefulWidget {
  static const String id = 'MedicineHistoryPage';

  @override
  _MedicineHistoryState createState() => _MedicineHistoryState();
}

final ref = FirebaseFirestore.instance.collection('MedicineConsume').where('userID', isEqualTo: UserID);

class _MedicineHistoryState extends State<MedicineHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 170.0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 75.0),
                      child: Text(
                        "Medicine History",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Container(
                height: 700,
                padding: EdgeInsets.only(top: 20.0),
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
                    ]),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60.0,
                      ),
                      StreamBuilder(
                          stream: ref.snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            return ClipRect(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: snapshot.hasData
                                      ? snapshot.data.docs.length
                                      : 0,
                                  itemBuilder: (_, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          right: 20.0,
                                          left: 20.0,
                                          bottom: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(0.0, 1.0),
                                                blurRadius: 6.0,
                                              ),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: mainColor.withOpacity(0.5),
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
                                                                top: 35.0,
                                                                left: 15.0,
                                                                right: 15.0,
                                                                bottom: 35.0),
                                                            child: Icon(
                                                              FontAwesomeIcons.pills,
                                                              size: 40.0,
                                                              color: mainColor,
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
                                                            snapshot.data.docs[index].data()['Name'],
                                                            style: TextStyle(
                                                                fontSize: 22.0,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 2.0),
                                                          child: Text(
                                                            snapshot.data.docs[index].data()['ConsumeAmount']+ " "+
                                                              snapshot.data.docs[index].data()['MedicineType'],
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.grey[700]),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            Text(
                                                              'Date/Time: '+snapshot.data.docs[index].data()['DateTime'],
                                                              style: TextStyle(
                                                                  fontSize: 12.0,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: Colors.grey[700]),
                                                            ),
                                                          ],
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
                                    );
                                  }),
                            );
                          }),
                      SizedBox(height: 150,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
