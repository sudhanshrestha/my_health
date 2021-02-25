import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/home/home.dart';
import 'package:my_health/pages/register/register.dart';

String email;
String password;

class Login extends StatefulWidget {
  static const String id = 'loginPage';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

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
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                )),
              ),
              Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
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
                        LoginTextFieldEmail(),
                        SizedBox(
                          height: 10.0,
                        ),
                        LoginTextFieldPass(),
                        SizedBox(
                          height: 25.0,
                        ),
                        Center(
                          child: PageButtons(
                            buttonTitle: "Login",
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                try {
                                  final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                                  if (user != null) {
                                    Navigator.pushNamed(context, HomePage.id);
                                  }
                                }
                                catch (e) {
                                  print(e);
                                }
                              }
                            },
                          ),
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
      child: TextFormField(
        onChanged: (value) {
          password = value;
        },
        validator: (val) => val.isEmpty ? 'Enter the password' : null,
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle:
              TextStyle(color: focusNode1.hasFocus ? mainColor : Colors.black),
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

class LoginTextFieldEmail extends StatefulWidget {
  @override
  _LoginTextFieldEmailState createState() => _LoginTextFieldEmailState();
}

FocusNode focusNode = FocusNode();

class _LoginTextFieldEmailState extends State<LoginTextFieldEmail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
      child: TextFormField(
        onChanged: (value) {
          email = value;
        },
        focusNode: focusNode,
        validator: (val) => val.isEmpty ? 'Enter an email' : null,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "E-mail",
          labelStyle:
              TextStyle(color: focusNode.hasFocus ? mainColor : Colors.black),
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