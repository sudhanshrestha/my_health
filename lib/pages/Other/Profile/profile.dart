import 'package:flutter/material.dart';
import 'package:my_health/pageAssets.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'ProfilePage';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                        "Prfoile",
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
                        Center(child: CircleAvatar(backgroundImage: AssetImage("images/p.jpg"), radius: 50)),
                        SizedBox(height: 30.0,),
                        ProfileNameTextField(),
                        SizedBox(height: 20.0,),
                        ProfileUserNameTextField(),
                        SizedBox(height: 20.0,),
                        ProfilePasswordTextField(),
                        SizedBox(height: 20.0,),
                        Center(child: DOBPicker()),
                        SizedBox(height: 20.0,),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0,bottom: 50.0),
                          child: Center(
                            child: SmallButton(
                              buttonTitle: "Save changes",
                              onPressed: () {
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
              borderRadius:
              BorderRadius.all(Radius.circular(10))),
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
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.grey[800]),
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
      child: TextField(
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
      child: TextField(
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

//TextField for PasswordCredential
class ProfilePasswordTextField extends StatefulWidget {
  @override
  _ProfilePasswordTextFieldState createState() =>
      _ProfilePasswordTextFieldState();
}

class _ProfilePasswordTextFieldState extends State<ProfilePasswordTextField> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  FocusNode focusNodePassword = FocusNode();

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
      child: TextField(
        focusNode: focusNodePassword,
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(
              color: focusNodePassword.hasFocus ? mainColor : Colors.black),
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

