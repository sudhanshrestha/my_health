import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:random_color/random_color.dart';

String UserID;

Color mainColor = Color(0xff6c5dd4);
RandomColor randomColor = RandomColor();

Color randomColour = randomColor.randomColor(
    colorSaturation: ColorSaturation.highSaturation
);




class PageButtons extends StatelessWidget {
  PageButtons({this.buttonTitle, this.onPressed, this.iconName});

  final String buttonTitle;
  final Function onPressed;
  final IconData iconName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 370,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 115.0, right: 100.0),
                  child: Text(
                    buttonTitle,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'OpenSans'),
                  ),
                ),
              ),
              Icon(
                iconName,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SmallButton extends StatelessWidget {
  SmallButton({this.buttonTitle, this.onPressed});

  final String buttonTitle;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 350,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            buttonTitle,
            style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'OpenSans'),
          ),
        ),
      ),
    );
  }
}
