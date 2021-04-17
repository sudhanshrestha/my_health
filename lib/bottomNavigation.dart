import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_health/pages/Other/Other.dart';
import 'package:my_health/pages/home/home.dart';
import 'package:my_health/pages/medicine/medicine.dart';
import 'package:my_health/pages/measurement/measurement.dart';
import 'package:random_color/random_color.dart';

int selectedIndex = 0;

//Custom
class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(38.0),
            topLeft: Radius.circular(38.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0.0, 0.75)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // NavBarItems(MdiIcons.home,Colors.purple,true,0,),
            // NavBarItems(MdiIcons.pill,Colors.indigo,false,1,),
            // NavBarItems(MdiIcons.heart,Colors.pink,false,2,),
            // NavBarItems(Icons.person,Colors.teal,false,3,),
            NavBarItem(
              iconName: MdiIcons.home,
              colorName: Colors.purple,
              isActive: true,
              index: 0,
              onPress: (){
                selectedIndex = 0;
                HapticFeedback.vibrate();
                Navigator.of(context).push(CustomPageRoute(HomePage()));
                // Navigator.push(context,
                //     new MaterialPageRoute(
                //     builder: (context) =>
                //     new HomePage())
                // );
              },
            ),
            NavBarItem(
              iconName: MdiIcons.pill,
              colorName: Colors.indigo,
              isActive: false,
              index: 1,

              onPress: (){
                selectedIndex = 1;
                HapticFeedback.vibrate();
                Navigator.of(context).push(CustomPageRoute(MedicinePage()));
                // Navigator.push(context, new MaterialPageRoute(
                //     builder: (context) =>
                //     new MedicinePage())
                // );
              },
            ),
            NavBarItem(
              iconName: MdiIcons.heart,
              colorName: Colors.pink,
              isActive: false,
              index: 2,

              onPress: (){
                selectedIndex = 2;
                HapticFeedback.vibrate();
                Navigator.of(context).push(CustomPageRoute(Measurement()));
                // Navigator.push(context, new MaterialPageRoute(
                //     builder: (context) =>
                //     new Measurement())
                // );
              },
            ),
            NavBarItem(
              iconName: Icons.person,
              colorName: Colors.teal,
              isActive: false,
              index: 3,
              onPress: (){
                selectedIndex = 3;
                HapticFeedback.vibrate();
                Navigator.of(context).push(CustomPageRoute(OtherPage()));
                // Navigator.push(context, new MaterialPageRoute(
                //     builder: (context) =>
                //     new OtherPage())
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//Navigation animation
class CustomPageRoute<T> extends PageRoute<T> {
  CustomPageRoute(this.child);
  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => null;

  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);
}


class NavBarItem extends StatefulWidget {
  NavBarItem(
      {this.iconName, this.colorName, this.isActive, this.index, this.onPress});

  final IconData iconName;
  final Color colorName;
  final bool isActive;
  final int index;
  final Function onPress;


  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          color: widget.index == selectedIndex
              ? widget.colorName.withOpacity(0.6)
              : Colors.white,
          borderRadius:BorderRadius.only(
            topLeft:  Radius.circular(30),
            topRight:  Radius.circular(30),
          ),
        ),
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 15),
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child:Icon(
            widget.iconName,
            color: widget.colorName,
          ),
        ),
      ),
    );
  }
}

// class BottomBar extends StatefulWidget {
//   Function onPressed;
//   bool bottomIcons;
//   String text;
//   IconData icons;
//
//   BottomBar(
//       {@required this.onPressed,
//       @required this.bottomIcons,
//       @required this.icons,
//       @required this.text});
//
//   @override
//   _BottomBarState createState() => _BottomBarState();
// }
//
// class _BottomBarState extends State<BottomBar> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: widget.onPressed,
//         child: widget.bottomIcons == true
//             ? Container(
//                 decoration: BoxDecoration(
//                   color: Colors.indigo.shade100.withOpacity(0.6),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 padding:
//                     EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
//                 child: Row(
//                   children: <Widget>[
//                     Icon(
//                       widget.icons,
//                       color: Colors.indigo,
//                     ),
//                     SizedBox(
//                       width: 8,
//                     ),
//                     Text(
//                       widget.text,
//                       style: TextStyle(
//                           color: Colors.indigo,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15),
//                     ),
//                   ],
//                 ),
//               )
//             : Icon(widget.icons)
//
//
//
//     );
//   }
// }
