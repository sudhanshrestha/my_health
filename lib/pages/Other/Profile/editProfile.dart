import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_health/main.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/Other/Profile/profileDisplay.dart';

class EditProfile extends StatefulWidget {
  static const String id = 'EditProfile';
  DocumentSnapshot docToEdit;

  EditProfile({this.docToEdit});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController emrNumber = TextEditingController();
  var docRef = FirebaseFirestore.instance.collection("profile").doc(UserID);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              Stack(
                children: [
                  Container(
                    height: 170.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 75.0),
                      child: Text(
                        "Edit Profile",
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
                height: 720,
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: CircleAvatar(
                            backgroundImage: AssetImage("images/person.png"),
                            radius: 50),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('profile')
                                      .doc(UserID)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return new Text("Loading");
                                    }
                                    var userDocument = snapshot.data;
                                    name = TextEditingController(
                                        text: userDocument['name']);
                                    gender = TextEditingController(
                                        text: userDocument['gender']);
                                    dob=TextEditingController(
                                        text: userDocument['dob']);
                                    emrNumber=TextEditingController(
                                        text: userDocument['emrNumber']);
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: TextField(
                                            controller: name,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: mainColor),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              hintText: "Enter name",
                                              hintStyle: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: TextField(
                                            controller: gender,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: mainColor),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              hintText: "Enter name",
                                              hintStyle: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: TextField(
                                            controller: dob,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: mainColor),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              hintText: "Enter name",
                                              hintStyle: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: TextField(
                                            controller: emrNumber,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: mainColor),
                                              ),
                                              disabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              hintText: "Enter name",
                                              hintStyle: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              // TextField(
                              //   controller: name,
                              //   decoration: InputDecoration(
                              //     border: InputBorder.none,
                              //     hintText: "Enter title",
                              //     hintStyle: TextStyle(
                              //         fontSize: 20.0,
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.white),
                              //   ),
                              //   style: TextStyle(
                              //       fontSize: 20.0,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.white),
                              //
                              // ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Center(
                                child: Button_edt(
                                  buttonTitle: "Save",
                                  onPressed: () {

                                    docRef.update({
                                      'name': name.text,
                                      'gender': gender.text,
                                      'dob': dob.text,
                                      'emrNumber': emrNumber.text
                                    }).whenComplete(
                                        () => Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileDisplay()),
                                            ));

                                  },
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button_edt extends StatelessWidget {
  Button_edt({this.buttonTitle, this.onPressed});

  final String buttonTitle;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 350,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            buttonTitle,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
