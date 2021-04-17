import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/home/home.dart';
import 'package:my_health/pages/login/ForgotPassword.dart';
import 'package:my_health/pages/register/register.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  static const String id = 'loginPage';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 270.0,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Image.asset('images/loginHeart.png'),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Center(
                        child: Text(
                          'My Health',
                          style: TextStyle(
                              fontSize: 45.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Your Health, Our Priority',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[200]),
                        ),
                      ),
                    ],
                  ),
                  // TODO: Need to create a background image and add if possible.
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
                            padding:
                                const EdgeInsets.only(left: 15.0, top: 15.0),
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
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              SizedBox(width: 250,),
                              RichText(
                                textAlign: TextAlign.end,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Forgot Password?",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: mainColor,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, ForgotPassword.id);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Center(
                            child: PageButtons(
                              buttonTitle: "Login",
                              onPressed: () async {
                                setState(() {
                                  showSpinner = true;
                                });
                                if (_formKey.currentState.validate()) {
                                  try {
                                    final user = await _auth
                                        .signInWithEmailAndPassword(
                                            email: userEmail,
                                            password: userPassword)
                                        .catchError((err) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Error"),
                                              content: Text(err.message),
                                              actions: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: mainColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    });
                                    if (user != null) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      );
                                    } else {
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      AlertDialog(
                                        title: Text("Error"),
                                        content: Text(
                                            "Please enter the correct email and passowrd."),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: mainColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  } catch (e) {
                                    print(e);
                                    setState(() {
                                      showSpinner = false;
                                    });
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
      ),
    );
  }
}

class LoginTextFieldPass extends StatefulWidget {
  @override
  _LoginTextFieldPassState createState() => _LoginTextFieldPassState();
}

FocusNode focusNode1 = FocusNode();
bool _passwordVisible = false;
bool isPressed = false;

class _LoginTextFieldPassState extends State<LoginTextFieldPass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
      child: TextFormField(
        obscureText: !_passwordVisible,
        onChanged: (value) {
          userPassword = value;
        },
        validator: (val) => val.isEmpty ? 'Enter the password' : null,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onLongPress: () {
              setState(() {
                _passwordVisible = true;
                isPressed = true;
              });
            },
            onLongPressUp: () {
              setState(() {
                _passwordVisible = false;
                isPressed = false;
              });
            },
            child: (isPressed)
                ? Icon(MdiIcons.eye, color: Colors.black)
                : Icon(
                    MdiIcons.eyeOff,
                    color: Colors.black,
                  ),
          ),
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
          userEmail = value;
        },
        focusNode: focusNode,
        validator: (val) =>
            EmailValidator.validate(val) ? null : 'Enter correct email address',
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
