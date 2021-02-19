import 'dart:collection';

import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';
import 'package:my_health/bottomNavigation.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/register/register.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';


int index = 0;

class AddMedicine extends StatefulWidget {
  static const String id = 'AddMedicinePage';

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final List<ListItem> _medicineType = [
    ListItem(1, "Pill"),
    ListItem(2, "Solution"),
    ListItem(3, "Injection"),
    ListItem(4, "Powder"),
    ListItem(6, "Drops"),
    ListItem(7, "Inhaler"),
    ListItem(8, "Others"),
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

  // void addItemToList(){
  //   setState(() {
  //
  //   });
  // }
  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    "Add Medicine",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
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
                        MedicineNameTextFieldAddMed(),
                        SizedBox(
                          height: 5.0,
                        ),
                        Center(
                          child: Container(
                            width: 370.0,
                            height: 58.0,
                            padding: EdgeInsets.fromLTRB(50, 1, 20, 1),
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
                                    });
                                  }),
                            ),
                          ),
                        ),
                        StrengthTextFieldAddMed(),
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
                              height:150.0,
                              child: timeAdded == null
                                  ? Center(child: Text('No Time Added'))
                                  : Expanded(
                                child: ListView.builder(
                                  itemCount: timeAdded.length,
                                  itemBuilder: (context, index) =>
                                      Dismissible(
                                        key: Key(timeAdded[index].toString()),
                                        onDismissed: (direction) {
                                          setState(() {
                                            timeAdded.removeAt(index);
                                          });
                                        },
                                        child: Card(
                                    child: ListTile(
                                        title: Text(timeAdded[index].toString()),
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
                          padding: const EdgeInsets.only(top: 20.0,bottom: 50.0),
                          child: Center(
                            child: SmallButton(
                              buttonTitle: "Add Medicine",
                              onPressed: () {
                                print(timeAdded);
                              },
                            ),
                          ),
                        ),
                      ]),
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

//list for gender picker
class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class MedicineNameTextFieldAddMed extends StatefulWidget {
  @override
  _MedicineNameTextFieldAddMedState createState() =>
      _MedicineNameTextFieldAddMedState();
}

FocusNode focusNodeMedicineName = FocusNode();

class _MedicineNameTextFieldAddMedState
    extends State<MedicineNameTextFieldAddMed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 25.0, left: 20.0, right: 25.0, bottom: 20.0),
      child: TextField(
        focusNode: focusNodeMedicineName,
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
    );
  }
}

class StrengthTextFieldAddMed extends StatefulWidget {
  @override
  _StrengthTextFieldAddMedState createState() =>
      _StrengthTextFieldAddMedState();
}

FocusNode focusNodeStrength = FocusNode();

class _StrengthTextFieldAddMedState extends State<StrengthTextFieldAddMed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 25.0, left: 20.0, right: 25.0, bottom: 20.0),
      child: TextField(
        focusNode: focusNodeStrength,
        decoration: InputDecoration(
          labelText: "Strength",
          labelStyle: TextStyle(
              color: focusNodeStrength.hasFocus ? mainColor : Colors.black),
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
    );
  }
}

// class SelectedTime extends StatefulWidget {
//   @override
//   _SelectedTimeState createState() => _SelectedTimeState();
// }
//
// class _SelectedTimeState extends State<SelectedTime> {
//   @override
//   Widget build(BuildContext context) {
//     return timeAdded == null
//         ? Center(child: Text('No Time Added'))
//         : Expanded(
//             child: ListView.builder(
//               itemCount: timeAdded.length,
//               itemBuilder: (context, index) => Card(
//                 child: ListTile(
//                   title: Text(timeAdded[index].toString()),
//                 ),
//               ),
//             ),
//           );
//   }
// }
