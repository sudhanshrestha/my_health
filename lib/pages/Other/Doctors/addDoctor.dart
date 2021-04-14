import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_health/pageAssets.dart';

class AddDoctorPage extends StatefulWidget {
  static const String id = 'AddDoctorPage';

  @override
  _AddDoctorPageState createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  TextEditingController docName = TextEditingController();
  TextEditingController docSpeciality = TextEditingController();
  TextEditingController docNumber = TextEditingController();
  TextEditingController docEmail = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

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
                        "Add Doctor",
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: CircleAvatar(
                            backgroundImage: AssetImage("images/Doctor.png"),
                            backgroundColor: mainColor,
                            radius: 50),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 20.0),
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      controller: docName,
                                      validator: (val) => val.isEmpty ? 'Enter the name' : null,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: mainColor),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        hintText: "Enter name",
                                        hintStyle: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey[700]),
                                      ),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 20.0),
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      controller: docSpeciality,
                                      validator: (val) => val.isEmpty ? 'Enter the speciality' : null,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: mainColor),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        hintText: "Medical speciality",
                                        hintStyle: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey[700]),
                                      ),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 20.0),
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      controller: docNumber,
                                      validator: (val) => val.length != 10 ? 'Enter the number properly' : null,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: mainColor),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        hintText: "Enter number",
                                        hintStyle: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey[700]),
                                      ),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 20.0),
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      controller: docEmail,
                                      validator: (val) => EmailValidator.validate(val) ? null : 'Enter correct email address',
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: mainColor),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        hintText: "Enter email",
                                        hintStyle: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey[700]),
                                      ),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50.0,
                                ),
                                Center(
                                  child: SmallButton(
                                    buttonTitle: "Save",
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _firestore.collection('doctors').add({
                                          'userID':UserID,
                                          'Name': docName.text,
                                          'Speciality': docSpeciality.text,
                                          'Number': docNumber.text,
                                          'Email': docEmail.text,
                                        }).whenComplete(() => Navigator.pop(context));
                                      }
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
