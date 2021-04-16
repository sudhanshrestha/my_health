import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_health/pageAssets.dart';

class EditPulse extends StatefulWidget {
  static const String id = 'EditPulsePage';
  DocumentSnapshot docToEdit;

  EditPulse({this.docToEdit});

  @override
  _EditPulseState createState() => _EditPulseState();
}

class _EditPulseState extends State<EditPulse> {
  TextEditingController pulse = TextEditingController();
  TextEditingController pulseNote = TextEditingController();
  String date;
  String time;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _selectedTime = newTime;
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(date),
        firstDate: DateTime(2019, 1),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        selectedDate = picked;
        date =  '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
      });
  }

  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay timePicked = await showTimePicker(
      context: context,
      initialTime: stringToTimeOfDay(time),
    );
    if (timePicked != null)
      setState(() {
        _selectedTime = timePicked;
        time= formatTimeOfDay(_selectedTime);
      });

  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  @override
  void initState() {
    pulse = TextEditingController(text: widget.docToEdit.data()['pulse']);
    pulseNote = TextEditingController(text: widget.docToEdit.data()['note']);
    time= formatTimeOfDay(_selectedTime);
    date =  '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
    super.initState();
  }

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
              Stack(
                children: [
                  Container(
                    height: 175.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 75.0),
                      child: Text(
                        "Edit Pulse",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 38.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      iconSize: 30.0,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              Container(
                width: double.infinity,
                height: 700,
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 60.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "Pulse (bpm)",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                FontAwesomeIcons.heartbeat,
                                color: mainColor,
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: TextFormField(
                                    controller: pulse,
                                    validator: (val) =>
                                    val.isEmpty || int.parse(val) > 250 || int.parse(val) < 55
                                        ? 'Invalid value'
                                        : null,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          5.0, 10.0, 5.0, 10.0),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: mainColor),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: mainColor),
                                      ),
                                      hintText: "Pulse",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              Text(
                                "bpm",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                MdiIcons.clock,
                                color: mainColor,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  elevation: 0,
                                ),
                                onPressed: () => _selectDate(context),
                                child: Text(
                                  '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  elevation: 0,
                                ),
                                onPressed: () => Navigator.of(context).push(
                                  showPicker(
                                      value: _selectedTime,
                                      onChange: onTimeChanged,
                                      blurredBackground: true,
                                      iosStylePicker: true
                                  ),
                                ),
                                    // _selectTime(context),
                                child: Text(
                                  formatTimeOfDay(_selectedTime),
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),

                          // FlatButton(
                          //     onPressed: () {
                          //       DatePicker.showDateTimePicker(context,
                          //           showTitleActions: true,
                          //           minTime: DateTime(1980, 1, 1),
                          //           maxTime: DateTime(2099, 12, 30), onChanged: (date) {
                          //             print('change $date');
                          //           }, onConfirm: (date) {
                          //             print('confirm $date');
                          //           }, currentTime: DateTime.now(), locale: LocaleType.en);
                          //     },
                          //     child: Text(
                          //       'Pick Date',
                          //       style: TextStyle(color: Colors.blue),
                          //     )),

                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                MdiIcons.note,
                                color: mainColor,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: TextField(
                                    controller: pulseNote,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: mainColor),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: mainColor),
                                      ),
                                      hintText: "Notes ",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Colors.black),
                                    ),
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: SmallButton(
                              buttonTitle: "Save",
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  widget.docToEdit.reference.update({
                                    'pulse': pulse.text,
                                    'date': date,
                                    'time': formatTimeOfDay(_selectedTime),
                                    'note': pulseNote.text,
                                  });
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 20,),
                          Center(
                            child: SmallButton(
                              buttonTitle: "Delete",
                              onPressed: () {
                                widget.docToEdit.reference.delete();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
