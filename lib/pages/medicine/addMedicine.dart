import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:my_health/bottomNavigation.dart';
import 'package:my_health/notification/notifcation_data.dart';
import '../../notification/notification_plugin.dart';
import 'package:my_health/pageAssets.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
int itemCount=0;
int index = 0;

String medType;
class AddMedicine extends StatefulWidget {
  static const String id = 'AddMedicinePage';


  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  TextEditingController medicineName = TextEditingController();
  TextEditingController medicineStock = TextEditingController();
  TextEditingController intakeDose = TextEditingController();
  int notificationID;
  DateTime reminderTime;
  final List<ListItem> _medicineType = [
    ListItem(1, "Pill"),
    ListItem(2, "Solution"),
    ListItem(3, "Injection"),
    ListItem(4, "Powder"),
    ListItem(6, "Drops"),
    ListItem(7, "Inhaler"),
  ];

  //notification plugin
  final NotificationPlugin _notificationPlugin = NotificationPlugin();
  Future <List<PendingNotificationRequest>> notificationFuture;

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  List<String> timeAdded = [];
  bool timeChecker = true;
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_medicineType);
    _selectedItem = _dropdownMenuItems[0].value;
    timeAdded.clear();
    //notification initilizer
    notificationFuture = _notificationPlugin.getScheduledNotifications();
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

  /*
  * Created a list for notification ID storage and
  * A list to store the boolean [false] to verify medicine intake
  * */
  List<String> notifiID = [];
  List<String> boolVal = [];
   createNotification() async {
    final title = medicineName.text;
    final description = "It is time to take your medication!";
    final time = Time(reminderTime.hour, reminderTime.minute, 0);
    var timeID = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    int id = int.parse(timeID.toString());
    notificationID = id;
    notifiID.add(notificationID.toString());
    boolVal.add('false');
    print('ID generated: $id , NotificationID:$notificationID');
    print('Time for notifi:');
    print(Time(reminderTime.hour, reminderTime.minute));
    await _notificationPlugin.showDailyAtTime(time, id, title, description);
  }
  //TODO: put golbal key out of build in every page.
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    FocusNode focusNodeMedicineName = FocusNode();
    FocusNode focusNodeStock = FocusNode();
    FocusNode focusNodeDose = FocusNode();
    final _firestore = FirebaseFirestore.instance;
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
                        "Add Medication",
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
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              validator: (val) => val.isEmpty || int.parse(val)>100 ? 'Invalid value' : null,
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
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              validator: (val) => val.isEmpty || int.parse(val)>10 ? 'Invalid value' : null,
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
                                height: 200.0,
                                child: timeAdded.length == 0
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
                                  //change this to change the number of timers
                                  if(timeAdded.length<6)
                                    {
                                      Navigator.of(context).push(
                                        showPicker(
                                          context: context,
                                          value: _time,
                                          onChange: onTimeChanged,
                                          blurredBackground: true,
                                          minuteInterval: MinuteInterval.ONE,
                                          disableHour: false,
                                          disableMinute: false,
                                          minMinute: 0,
                                          iosStylePicker: true,
                                          maxMinute: 59,
                                          // Optional onChange to receive value as DateTime
                                          onChangeDateTime: (DateTime dateTime) {
                                            timeChecker =true;
                                            String tempTime = _time.format(context);
                                            for(int i=0; i<timeAdded.length; i++){
                                              if(timeAdded[i] == tempTime){
                                                timeChecker = false;
                                                break;
                                              }
                                            }
                                            if(timeChecker == true)
                                              {
                                                timeAdded.add(_time.format(context));
                                              }

                                          },
                                        ),
                                      );
                                    }

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
                                const EdgeInsets.only(top: 20.0, bottom: 50.0),
                            child: Center(
                              child: SmallButton(
                                buttonTitle: "Add Medicine",
                                onPressed: () {
                                  // print(medicineName.text);
                                  // print(_medicineType.elementAt(itemCount).name);
                                  // print(medicineStock.text);
                                  // print(intakeDose.text);
                                  // print(timeAdded);
                                  // String date =  (timeAdded.toString().replaceAll("]","")).replaceAll("[","");
                                  // DateTime date1= DateFormat.jm().parse(date);
                                  // reminderTime = date1;

                                  //creating loop for each reminder
                                  if (_formKey.currentState.validate() && timeAdded.length>0) {
                                    notifiID.clear();
                                    boolVal.clear();
                                    for(var i =0; i<timeAdded.length; i++){
                                      print(timeAdded[i]);
                                      String date =  timeAdded[i];
                                      DateTime date1= DateFormat.jm().parse(date);
                                      reminderTime = date1;
                                      createNotification();
                                    }
                                    DateTime now = DateTime.now();
                                    var dateStamp = DateFormat('yyyy-MM-dd').format(now);

                                    _firestore.collection('Medicine').add({
                                      'userID':UserID,
                                      'Name': medicineName.text,
                                      'MedicineType': _medicineType.elementAt(itemCount).name.toString(),
                                      'Stock': medicineStock.text,
                                      'Dose': intakeDose.text,
                                      'ReminderTime': (timeAdded.toString().replaceAll("]","")).replaceAll("[","").replaceAll(' ', ''),
                                      'NotificationID' : (notifiID.toString().replaceAll("]","")).replaceAll("[","").replaceAll(' ', ''),
                                      'DateStamp': dateStamp,
                                      'BooleanValues': (boolVal.toString().replaceAll("]","")).replaceAll("[","").replaceAll(' ', ''),
                                      'MedicineTaken': 'false',
                                    }).whenComplete(() => Navigator.pop(context));
                                  }

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

//list for gender picker
class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}


