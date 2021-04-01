

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/home/home.dart';
import 'package:my_health/pages/register/register.dart';


String _name;
String _dob;
String _gender;
String _emrNum;
class ProfilePage extends StatefulWidget {
  static const String id = 'ProfilePage';



  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storeProfile = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
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

  // final imagePicker = ImagePicker();
  // File imageFile;
  //
  // Future getImage() async {
  //   var image = await imagePicker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     imageFile = File(image.path);
  //   });
  // }
  @override
  void initState() {

    getCurrentUser();

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
                    height: 150.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 75.0),
                      child: Text(
                        "Profile",
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
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 60.0,
                        ),
                        // Center(
                        //   child: GestureDetector(
                        //       onTap: () => getImage(),
                        //       child: (imageFile == null)
                        //           ? Container(
                        //         height: 150,
                        //         width: 150,
                        //         child: Icon(
                        //             MdiIcons.cameraPlus,
                        //             size: 40
                        //         ),
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(25),
                        //             color: Colors.white
                        //         ),
                        //       )
                        //           : Container(
                        //         height: 180,
                        //         width: 130,
                        //         decoration: BoxDecoration(
                        //             image: DecorationImage(
                        //                 fit: BoxFit.cover,
                        //                 image: FileImage(imageFile)
                        //             )
                        //         ),
                        //       ),
                        //   ),
                        // ),
                        // Center(
                        //   child: MaterialButton(
                        //     onPressed: getImage,
                        //     child: CircleAvatar(
                        //       backgroundColor: Colors.transparent,
                        //       radius: 60.0,
                        //       child: CircleAvatar(
                        //         radius: 40.0,
                        //         backgroundImage: (imageFile != null)
                        //             ? Image.file(imageFile)
                        //             : AssetImage("images/p.jpg"),
                        //         backgroundColor: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Center(
                        //     child: CircleAvatar(
                        //         backgroundImage: AssetImage("images/p.jpg"),
                        //         radius: 50)),
                        SizedBox(
                          height: 30.0,
                        ),
                        ProfileNameTextField(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(child: DOBPicker()),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left:18.0,right: 18.0),
                            child: Container(
                              padding: const EdgeInsets.only(left:15.0,right: 10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.7,
                                    color: Colors.grey[700],
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: DropDown(
                                showUnderline: false,
                                isExpanded: true,
                                items: ["Male", "Female", "Other"],
                                hint: Text("Select Gender",style: TextStyle(fontSize: 17.0,color: Colors.grey[800]),),
                                onChanged: (value){
                                  _gender = value.toString();
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        EmergencyNumberTF(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 50.0),
                          child: Center(
                            child: SmallButton(
                              buttonTitle: "Save",
                              onPressed: () {
                                if(_formKey.currentState.validate()){
                                  if(_name == null || _gender == null || _dob == null){
                                    print("empty");
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text("Please enter the details properly."),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: mainColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text("Ok"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  }
                                  else{
                                    print(" not empyty");
                                    print(_name);
                                    print(_gender);
                                    print(_dob);
                                    print(_emrNum);

                                    storeProfile.collection('profile').doc(UserID).set({
                                      'userID':UserID,
                                      'name' : _name,
                                      'gender': _gender,
                                      'dob': _dob,
                                      'emrNumber':_emrNum,
                                    });
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
                                  }
                                }
                                // storeProfile.collection('notes').add({
                                //   'userID':UserID,
                                //   'name': title.text,
                                //   'description': description.text,
                                // });
                              },
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

DateTime dateTime;

// ignore: must_be_immutable
class DOBPicker extends StatefulWidget {
  @override
  _DOBPickerState createState() => _DOBPickerState();
}

class _DOBPickerState extends State<DOBPicker> {
  @override
  Widget build(BuildContext context) {
    String birthDateInString;
    DateTime birthDate;
    bool isDateSelected = false;
    return Container(
      child: InkWell(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime(2077),
          ).then((date) {
            setState(() {
              dateTime = date;
              _dob = '${dateTime.year}-${dateTime.month}-${dateTime.day}'.toString();
            });
          });
        },
        child: Container(
          width: 380.0,
          height: 58.0,
          decoration: BoxDecoration(
              border: Border.all(
                width: 0.7,
                color: Colors.grey[700],
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 18.0, top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    dateTime == null
                        ? "Select Date of Birth"
                        : "Date of Birth: ${dateTime.year}-${dateTime.month}-${dateTime.day}",
                    style: TextStyle(fontSize: 17.0, color: Colors.grey[800]),
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//TextField for Name
class ProfileNameTextField extends StatefulWidget {
  @override
  _ProfileNameTextFieldState createState() => _ProfileNameTextFieldState();
}

class _ProfileNameTextFieldState extends State<ProfileNameTextField> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  FocusNode focusNodeName = FocusNode();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextFormField(
        validator: (val) => val.isEmpty ? 'Enter the name' : null,
        onChanged: (value) {
          _name = value.toString();
        },
        focusNode: focusNodeName,
        decoration: InputDecoration(
          labelText: "Name",
          labelStyle: TextStyle(
              color: focusNodeName.hasFocus ? mainColor : Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

//TextField for UserName
class ProfileUserNameTextField extends StatefulWidget {
  @override
  _ProfileUserNameTextFieldState createState() =>
      _ProfileUserNameTextFieldState();
}

class _ProfileUserNameTextFieldState extends State<ProfileUserNameTextField> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  FocusNode focusNodeUserName = FocusNode();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextFormField(
        focusNode: focusNodeUserName,
        decoration: InputDecoration(
          labelText: "UserName",
          labelStyle: TextStyle(
              color: focusNodeUserName.hasFocus ? mainColor : Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}



class EmergencyNumberTF extends StatefulWidget {

  @override
  _EmergencyNumberTFState createState() => _EmergencyNumberTFState();
}

class _EmergencyNumberTFState extends State<EmergencyNumberTF> {
  final myController = TextEditingController();
  FocusNode focusNodeUserName = FocusNode();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        validator: (val) => val.length < 10
            ? 'Enter correct Number'
            : null,
        focusNode: focusNodeUserName,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          _emrNum = value;
        },
        decoration: InputDecoration(
          labelText: "Emergency Number",
          labelStyle: TextStyle(
              color: focusNodeUserName.hasFocus ? mainColor : Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
