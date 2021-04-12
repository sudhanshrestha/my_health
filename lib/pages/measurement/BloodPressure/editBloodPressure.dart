import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_health/pageAssets.dart';

class EditBloodPressure extends StatefulWidget {
  static const String id = 'EditBloodPressure';
  DocumentSnapshot docToEdit;

  EditBloodPressure({this.docToEdit});

  @override
  _EditBloodPressureState createState() => _EditBloodPressureState();
}

class _EditBloodPressureState extends State<EditBloodPressure> {
  TextEditingController sys = TextEditingController();
  TextEditingController dia = TextEditingController();
  TextEditingController bpNote = TextEditingController();
  String date;
  String time;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    date = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 1),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        selectedDate = picked;
        date = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
      });
  }

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<Null> _selectTime(BuildContext context) async {
    time = formatTimeOfDay(_selectedTime);
    final TimeOfDay timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timePicked != null)
      setState(() {
        _selectedTime = timePicked;
        time = formatTimeOfDay(_selectedTime);
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
    sys = TextEditingController(text: widget.docToEdit.data()['sys']);
    dia = TextEditingController(text: widget.docToEdit.data()['dia']);
    time = formatTimeOfDay(_selectedTime);
    date = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
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
                        "Add Blood Pressure",
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
                              "Blood Pressure (mmHg)",
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
                                IcoFontIcons.bloodTest,
                                color: mainColor,
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: TextFormField(
                                    controller: sys,
                                    keyboardType: TextInputType.number,
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter value' : null,
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
                                      hintText: "Sys(high)",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              Text(
                                "/",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: TextFormField(
                                    controller: dia,
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter value' : null,
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
                                      hintText: "Sys(high)",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              Text(
                                "mmHg",
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
                                      fontWeight: FontWeight.w600,
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
                                onPressed: () => _selectTime(context),
                                child: Text(
                                  formatTimeOfDay(_selectedTime),
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
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
                                MdiIcons.note,
                                color: mainColor,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: TextField(
                                    controller: bpNote,
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
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
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
                                    'sys': sys.text,
                                    'dia': dia.text,
                                    'date': date,
                                    'time': time,
                                    'note': bpNote.text,
                                  }).whenComplete(() => Navigator.pop(context));
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: SmallButton(
                              buttonTitle: "Delete",
                              onPressed: () {
                                widget.docToEdit.reference
                                    .delete()
                                    .whenComplete(() => Navigator.pop(context));
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
