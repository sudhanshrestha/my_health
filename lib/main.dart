import 'package:flutter/material.dart';
import 'package:my_health/pages/loadingPage.dart';
import 'package:my_health/pages/login.dart';

void main() {
  runApp(MyHealth());
}

class MyHealth extends StatefulWidget {
  @override
  _MyHealthState createState() => _MyHealthState();
}

class _MyHealthState extends State<MyHealth> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "OpenSans"
      ),
      home: LoadingPage(),
      initialRoute: LoadingPage.id,
      routes: {
        LoadingPage.id : (context) => LoadingPage(),
        Login.id : (context) => Login(),
      },
    );
  }
}
