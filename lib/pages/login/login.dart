import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/home/home.dart';
import 'package:my_health/pages/register/register.dart';


class Login extends StatefulWidget {
  static const String id = 'loginPage';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
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
              Container(
                height: 190.0,
                width: double.infinity,
                // TODO: Need to create a background image and add if possible.
                child: Center(
                    child: Text(
                      "BACKGROUND-IMAGE",
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.68,
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Login Title Label*/
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      LoginTextFieldUsr(),
                      SizedBox(height: 10.0,),
                      LoginTextFieldPass(),
                      SizedBox(height: 25.0,),
                      Center(
                        child: PageButtons(buttonTitle: "Login", onPressed: () {
                          Navigator.pushNamed(context, HomePage.id);
                        },),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: "Register Now",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: mainColor,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, Register.id);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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

class LoginTextFieldPass extends StatefulWidget {

  @override
  _LoginTextFieldPassState createState() => _LoginTextFieldPassState();
}

FocusNode focusNode1 = FocusNode();

class _LoginTextFieldPassState extends State<LoginTextFieldPass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(
              color: focusNode1.hasFocus ? mainColor : Colors.black),
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

class LoginTextFieldUsr extends StatefulWidget {
  @override
  _LoginTextFieldUsrState createState() => _LoginTextFieldUsrState();
}

FocusNode focusNode = FocusNode();

class _LoginTextFieldUsrState extends State<LoginTextFieldUsr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
      child: TextField(
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: "Username",
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mainColor : Colors.black),
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
