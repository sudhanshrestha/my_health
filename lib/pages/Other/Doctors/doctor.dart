import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/Other/Doctors/addDoctor.dart';
import 'package:my_health/pages/Other/Doctors/doctorInfo.dart';

class DoctorPage extends StatefulWidget {
  static const String id = 'DoctorPage';
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {

  final ref = FirebaseFirestore.instance.collection('doctors').where('userID',isEqualTo: UserID);

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
                    height: 170.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 75.0),
                      child: Text(
                        "Doctors",
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
                width: double.infinity,
                height: 650,
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
                        SizedBox(height: 60.0,),
                        StreamBuilder<QuerySnapshot>(
                            stream: ref.snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              return ClipRect(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: snapshot.hasData ? snapshot.data.docs.
                                    length : 0,
                                    itemBuilder: (_, index) {

                                      return  GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (_) =>
                                                  DoctorInfo(docToView: snapshot.data
                                                      .docs[index])));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(right:20.0,left: 20.0,bottom: 10.0),
                                          child: Container(
                                            // margin: EdgeInsets.only(left:15.0,right: 15.0),
                                            // padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                                            height: 120.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(
                                                  16.0),
                                            ),
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
                                                    child: SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: CircleAvatar(
                                                                    backgroundImage: AssetImage("images/doctor.jpg"),
                                                                    radius: 32),
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
                                                                padding: const EdgeInsets.only(left: 2.0,top: 10),
                                                                child: Text(
                                                                    snapshot.data.docs[index].data()['Name'],
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
                                                                  snapshot.data.docs[index].data()['Speciality'],
                                                                  style: TextStyle(
                                                                      fontSize: 16.0, color: Colors.grey[700]),
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
                                            ),
                                            // child: Column(
                                            //   crossAxisAlignment: CrossAxisAlignment
                                            //       .start,
                                            //   children: [
                                            //     Text(
                                            //       snapshot.data.docs[index]
                                            //           .data()['Name'],
                                            //       style: TextStyle(
                                            //           fontSize: 20.0,
                                            //           fontWeight: FontWeight.bold),
                                            //     ),
                                            //     SizedBox(
                                            //       height: 5.0,
                                            //     ),
                                            //     Text(
                                            //       snapshot.data.docs[index]
                                            //           .data()['Speciality'],
                                            //       style: TextStyle(
                                            //         fontSize: 17.0,
                                            //       ),
                                            //       overflow: TextOverflow.ellipsis,
                                            //     ),
                                            //   ],
                                            // ),
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            }
                        ),


                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AddDoctorPage.id);

        },
        label: Text('Add Doctor'),
        icon: Icon(Icons.add),
        backgroundColor: mainColor,
      ),
    );
  }
}
