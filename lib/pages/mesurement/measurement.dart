import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_health/bottomNavigation.dart';
import 'package:my_health/main.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/Other/Other.dart';
import 'package:my_health/pages/mesurement/BloodPressure/bloodPressure.dart';
import 'package:my_health/pages/mesurement/BodyFat/bodyFat.dart';
import 'package:my_health/pages/mesurement/Pulse/pulse.dart';

class Measurement extends StatefulWidget {
  static const String id = 'MeasurementPage';

  @override
  _MeasurementState createState() => _MeasurementState();
}

class _MeasurementState extends State<Measurement> {
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
                height: 150.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 75.0),
                  child: Text(
                    "Measurement",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 600,
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
                        SizedBox(
                          height: 60.0,
                        ),
                        PCard2(
                          mainLabel: "Blood Pressure",
                          icons: MdiIcons.heartPlus,
                          onTap: (){
                            Navigator.pushNamed(context, BloodPressurePage.id);
                          },
                        ),
                        SizedBox(height: 15.0,),
                        PCard2(
                          mainLabel: "Body Fat",
                          icons: Boxicons.bx_body,
                          onTap: (){
                            Navigator.pushNamed(context, BodyFatPage.id);
                          },
                        ),
                        SizedBox(height: 15.0,),
                        PCard2(
                          mainLabel: "Pulse",
                          icons: MdiIcons.heartPulse,
                          onTap: (){
                            Navigator.pushNamed(context, PulsePage.id);
                          },
                        ),

                        // MeasurementBadge(title: "Blood Pressure", color: mainColor,onPress: (){
                        //   Navigator.pushNamed(context, BloodPressurePage.id);
                        //
                        // },),
                        // MeasurementBadge(title: "Body Fat", color: mainColor,onPress: (){
                        //   Navigator.pushNamed(context, BodyFatPage.id);
                        // },),
                        // MeasurementBadge(title: "Pulse", color: mainColor,onPress: (){
                        //   Navigator.pushNamed(context, PulsePage.id);
                        // },),
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),

    );

  }
}

class MeasurementBadge extends StatelessWidget {
 MeasurementBadge({@required this.title,this.color,this.onPress});
 final String title;
 final Color color;
 final Function onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1.0),
                spreadRadius: 3,
                blurRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
