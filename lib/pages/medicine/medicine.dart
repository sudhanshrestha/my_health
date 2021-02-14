import 'package:flutter/material.dart';
import 'package:my_health/bottomNavigation.dart';

class MedicinePage extends StatefulWidget {
  static const String id = 'MedicinePage';
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(child: Column(children: [Text("MEdinine")],),),),
      bottomNavigationBar: BottomNavigation(),

    );
  }
}
