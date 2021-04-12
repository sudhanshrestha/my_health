import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/Other/Track/trackMe.dart';

int minSelected;

class TrackTimer extends StatefulWidget {
  static const String id = 'TrackTimerPage';

  @override
  _TrackTimerState createState() => _TrackTimerState();
}

FocusNode focusNodeTimer = FocusNode();

class _TrackTimerState extends State<TrackTimer> {
  TextEditingController timerMinute = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Minute'),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 25.0, left: 20.0, right: 25.0, bottom: 20.0),
                  child: TextFormField(
                    focusNode: focusNodeTimer,
                    keyboardType: TextInputType.number,
                    controller: timerMinute,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) =>
                        val.isEmpty || int.parse(val) > 60 ? 'Invalid value' : null,
                    decoration: InputDecoration(
                      labelText: "Enter minute time to check your status",
                      labelStyle: TextStyle(
                          color:
                              focusNodeTimer.hasFocus ? mainColor : Colors.black),
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
                ),
                SizedBox(height: 50,),
                Center(
                  child: SmallButton(
                    buttonTitle: 'Ok',
                    onPressed: (){
                      if (_formKey.currentState.validate()) {
                        minSelected = int.parse(timerMinute.text);
                        print(minSelected);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TrackMe()),);
                      }

                    },
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
