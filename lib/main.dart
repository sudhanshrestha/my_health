import 'package:flutter/material.dart';
import 'package:my_health/pages/loadingPage.dart';

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
      home: LoadingPage(),
    );
  }
}
