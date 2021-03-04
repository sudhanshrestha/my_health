import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_health/pages/home/home.dart';
import 'package:my_health/pages/login/login.dart';



class LoadingPage extends StatefulWidget {
  static const String id = 'loadingPage';
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
     final user = FirebaseAuth.instance.currentUser;
    Timer(Duration(seconds: 3), () {
      if (user !=null){
        Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => new HomePage(),),
        );
      }
      else{
        Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => new Login(),),
        );
      }



    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Image(
        image: AssetImage('images/My Health.png'),
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
