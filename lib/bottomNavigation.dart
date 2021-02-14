import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_health/pages/home/home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_health/pages/medicine/medicine.dart';




//Custom
class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

enum BottomIcons { Home, Medicine, Measurement, Profile }

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    BottomIcons bottomIcons = BottomIcons.Home;
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.only(left: 24, right: 24, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomBar(
                onPressed: () {
                  setState(() {
                    bottomIcons = BottomIcons.Home;
                  });
                },
                bottomIcons: bottomIcons == BottomIcons.Home ? true : false,
                icons: MdiIcons.home,
                text: "Home"
            ),
            BottomBar(
                onPressed: () {
                  setState(() {
                    bottomIcons = BottomIcons.Medicine;
                  });
                },
                bottomIcons:
                bottomIcons == BottomIcons.Medicine ? true : false,
                icons: MdiIcons.pill,
                text: "Medicine"),
          ],
        ),
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  Function onPressed;
  bool bottomIcons;
  String text;
  IconData icons;

  BottomBar(
      {@required this.onPressed,
      @required this.bottomIcons,
      @required this.icons,
      @required this.text});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onPressed,
        child: widget.bottomIcons == true
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      widget.icons,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.text,
                      style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              )
            : Icon(widget.icons));
  }
}
