import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';
import 'package:my_health/bottomNavigation.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/medicine/addMedicine.dart';

int itemCount=0;
int index = 0;
class EditMedicine extends StatefulWidget {

  DocumentSnapshot docToEdit;
  EditMedicine({this.docToEdit});

  static const String id = 'MedicinePage';
  @override
  _EditMedicineState createState() => _EditMedicineState();
}

class _EditMedicineState extends State<EditMedicine> {

  TextEditingController medicineName = TextEditingController();
  TextEditingController medicineStock = TextEditingController();
  TextEditingController intakeDose = TextEditingController();
  final List<ListItem> _medicineType = [
    ListItem(1, "Pill"),
    ListItem(2, "Solution"),
    ListItem(3, "Injection"),
    ListItem(4, "Powder"),
    ListItem(6, "Drops"),
    ListItem(7, "Inhaler"),
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  List<String> timeAdded = [];

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_medicineType);
    _selectedItem = _dropdownMenuItems[0].value;
    timeAdded.clear();
    medicineName = TextEditingController(text: widget.docToEdit.data()['Name']);
    medicineStock = TextEditingController(text: widget.docToEdit.data()['Stock']);
    intakeDose = TextEditingController(text: widget.docToEdit.data()['Dose']);
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    FocusNode focusNodeMedicineName = FocusNode();
    FocusNode focusNodeStock = FocusNode();
    FocusNode focusNodeDose = FocusNode();
    final _firestore = FirebaseFirestore.instance;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        "Edit Medication",
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
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
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
                  child: Form(
                    key:_formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 60.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "Medication:",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding:
                            EdgeInsets.only(top: 25.0, left: 20.0, right: 25.0, bottom: 20.0),
                            child: TextFormField(
                              focusNode: focusNodeMedicineName,
                              controller: medicineName,
                              validator: (val) => val.isEmpty ? 'Invalid value' : null,
                              decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(
                                    color: focusNodeMedicineName.hasFocus ? mainColor : Colors.black),
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
                          SizedBox(
                            height: 5.0,
                          ),
                          Center(
                            child: Container(
                              width: 370.0,
                              height: 58.0,
                              padding: EdgeInsets.fromLTRB(11, 1, 20, 1),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.7,
                                    color: Colors.grey[700],
                                  )),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey[800],
                                    ),
                                    hint: Text("Select Type"),
                                    value: _selectedItem,
                                    items: _dropdownMenuItems,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedItem = value;
                                        itemCount =_medicineType.indexOf(value);
                                        print(itemCount);
                                        medType = _medicineType.elementAt(itemCount).name;
                                      });
                                    }),
                              ),
                            ),
                          ),
                          Container(
                            padding:
                            EdgeInsets.only(top: 25.0, left: 20.0, right: 25.0, ),
                            child: TextFormField(
                              focusNode: focusNodeStock,
                              controller: medicineStock,
                              keyboardType: TextInputType.number,
                              validator: (val) => val.isEmpty? 'Invalid value' : null,
                              decoration: InputDecoration(
                                labelText: "Stock",
                                labelStyle: TextStyle(
                                    color: focusNodeStock.hasFocus ? mainColor : Colors.black),
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
                          Container(
                            padding:
                            EdgeInsets.only(top: 25.0, left: 20.0, right: 25.0, bottom: 20.0),
                            child: TextFormField(
                              focusNode: focusNodeDose,
                              keyboardType: TextInputType.number,
                              controller: intakeDose,
                              validator: (val) => val.isEmpty  ? 'Invalid value' : null,
                              decoration: InputDecoration(
                                labelText: "Intake Dose",
                                labelStyle: TextStyle(
                                    color: focusNodeDose.hasFocus ? mainColor : Colors.black),
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
                          SizedBox(
                            height: 25.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "Reminder Time:",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 150.0,
                                child: timeAdded == null
                                    ? Center(child: Text('No Time Added'))
                                    : ListView.builder(
                                  itemCount: timeAdded.length,
                                  itemBuilder: (context, index) =>
                                      Dismissible(
                                        key: Key(timeAdded[index].toString()),
                                        onDismissed: (direction) {
                                          setState(() {
                                            timeAdded.removeAt(index);
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          child: Card(
                                            elevation: 1,
                                            child: ListTile(
                                              title: Text(timeAdded[index]
                                                  .toString()),
                                            ),
                                          ),
                                        ),
                                      ),
                                ),
                              ),

                              // Text(
                              //   _time.format(context),
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(fontSize: 22.0),
                              // ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      context: context,
                                      value: _time,
                                      onChange: onTimeChanged,
                                      minuteInterval: MinuteInterval.FIVE,
                                      disableHour: false,
                                      disableMinute: false,
                                      minMinute: 7,
                                      maxMinute: 56,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        timeAdded.add(_time.format(context));
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  "Select Time",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                            ],
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Center(
                              child: SmallButton(
                                buttonTitle: "Edit Medicine",
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    widget.docToEdit.reference.update({
                                      'userID':UserID,
                                      'Name': medicineName.text,
                                      'MedicineType': _medicineType.elementAt(itemCount).name.toString(),
                                      'Stock': medicineStock.text,
                                      'Dose': intakeDose.text,
                                      'ReminderTime': timeAdded,
                                    }).whenComplete(() => Navigator.pop(context));
                                  }
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 20.0, bottom: 50.0),
                            child: Center(
                              child: SmallButton(
                                buttonTitle: "Delete Medicine",
                                onPressed: () {
                                  widget.docToEdit.reference
                                      .delete()
                                      .whenComplete(() => Navigator.pop(context));
                                },
                              ),
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
      bottomNavigationBar: BottomNavigation(),
    );
  }
}