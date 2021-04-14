import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_health/bottomNavigation.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/Other/Doctors/doctor.dart';
import 'package:my_health/pages/Other/Notes/notes.dart';
import 'package:my_health/pages/Other/Profile/profile.dart';
import 'package:my_health/pages/Other/Profile/profileDisplay.dart';
import 'package:my_health/pages/Other/Track/trackMe.dart';
import 'package:my_health/pages/Other/Track/trackTimer.dart';
import 'package:my_health/pages/Other/medicineHistory/medicineHistory.dart';
import 'package:my_health/pages/login/login.dart';

class OtherPage extends StatefulWidget {
  static const String id = 'OtherPage';
  @override
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseFirestore.instance.collection('profile').doc(UserID);
  final _auth = FirebaseAuth.instance;
  String gender;
  User loggedInUser;
  String genderDisplay;

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
                height: 220.0,
                child: Column(
                  children: [
                StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('profile')
                    .doc(UserID)
                    .snapshots(),
            builder: (context,snapshot){
              if(!snapshot.hasData){
                return Text("Loading");
              }
              var usrData = snapshot.data;
              gender = usrData['gender'];
              genderDisplay = gender;
              return  Column(
                children: [
                  SizedBox(height: 20.0,),
                  Center(child: CircleAvatar(backgroundImage: AssetImage("images/$genderDisplay.png") , radius: 60)),
                  SizedBox(height: 20.0,),
                  Text(
                    usrData["name"],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
          ),

                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
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
                        PCard2(
                          mainLabel: "Notes",
                          icons: MdiIcons.noteText,
                          onTap: (){
                            Navigator.pushNamed(context, NotePage.id);
                          },
                        ),
                        SizedBox(height: 15.0,),
                        PCard2(
                          mainLabel: "Doctors",
                          icons: IcoFontIcons.doctor,
                          onTap: (){
                            Navigator.pushNamed(context, DoctorPage.id);
                          },
                        ),
                        SizedBox(height: 15.0,),
                        PCard2(
                          mainLabel: "Profile",
                          icons: Icons.person,
                          onTap: (){
                            Navigator.pushNamed(context, ProfileDisplay.id);
                          },
                        ),
                        SizedBox(height: 15.0,),
                        PCard2(
                          mainLabel: "Track Me",
                          icons: Icons.location_on,
                          onTap: (){
                            Navigator.pushNamed(context, TrackTimer.id);

                          },
                        ),
                        SizedBox(height: 15.0,),
                        PCard2(
                          mainLabel: "Medicine History",
                          icons: Icons.location_on,
                          onTap: (){
                            Navigator.pushNamed(context, MedicineHistory.id);
                          },
                        ),
                        SizedBox(height: 15.0,),
                        PCard2(
                          mainLabel: "Log Out",
                          icons: Icons.person,
                          onTap: (){
                            auth.signOut();
                            UserID = "";
                            Navigator.pop(context,true);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()),);

                          },
                        ),

                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),

    );
  }
}


class PCard extends StatelessWidget {
  const PCard({this.mainLabel, this.sideLabel, this.icons, this.onTap});

  final String mainLabel;
  final String sideLabel;
  final IconData icons;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      //     () {
      //   Navigator.pushNamed(context, QRPage.id);
      // },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.11,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 10,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: mainColor.withOpacity(0.5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          icons,
                          size: 40.0,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mainLabel,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          sideLabel,
                          style: TextStyle(color: Colors.grey[600],fontSize: 13.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// second card

class PCard2 extends StatelessWidget {
  const PCard2({this.mainLabel, this.icons, this.onTap});

  final String mainLabel;
  final IconData icons;

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.11,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 10,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: mainColor.withOpacity(0.5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          icons,
                          size: 40.0,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        mainLabel,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}