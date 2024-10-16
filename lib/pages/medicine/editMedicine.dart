import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:my_health/bottomNavigation.dart';
import 'package:my_health/notification/notification_plugin.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/medicine/addMedicine.dart';

int itemCount=0;
int index = 0;
class EditMedicine extends StatefulWidget {

  DocumentSnapshot docToEdit;
  EditMedicine({this.docToEdit});

  static const String id = 'EditMedicinePage';
  @override
  _EditMedicineState createState() => _EditMedicineState();
}

class _EditMedicineState extends State<EditMedicine> {

  TextEditingController medicineName = TextEditingController();
  // TextEditingController medicineStock = TextEditingController();
  TextEditingController intakeDose = TextEditingController();
  String medicineStock;
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
  int notificationID;
  DateTime reminderTime;
  final NotificationPlugin _notificationPlugin = NotificationPlugin();
  String notiID;
  List<String> nID;
  void initState() {
    itemCount =0;
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_medicineType);
    _selectedItem = _dropdownMenuItems[0].value;
    timeAdded.clear();
    medicineName = TextEditingController(text: widget.docToEdit.data()['Name']);
    // medicineStock = TextEditingController(text: widget.docToEdit.data()['Stock']);
    intakeDose = TextEditingController(text: widget.docToEdit.data()['Dose']);
    medicineStock = widget.docToEdit.data()['Stock'];
    notiID = widget.docToEdit.data()['NotificationID'];
    nID = notiID.split(',');
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
                          /*
                          * Medicine Stock being taken out after re designing the medicne and adding the user history
                          * */
                          SizedBox(height: 5.0,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "Medicine Stock : $medicineStock ",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500,color: Colors.grey[700]),
                            ),
                          ),


                          SizedBox(
                            height: 25.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "Reminder Time :",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 250.0,
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
                                  //change this to change the number of timers
                                  if(timeAdded.length<6){
                                    Navigator.of(context).push(
                                      showPicker(
                                        context: context,
                                        value: _time,
                                        onChange: onTimeChanged,
                                        minuteInterval: MinuteInterval.ONE,
                                        blurredBackground: true,
                                        disableHour: false,
                                        disableMinute: false,
                                        minMinute: 0,
                                        iosStylePicker: true,
                                        maxMinute: 59,
                                        // Optional onChange to receive value as DateTime
                                        onChangeDateTime: (DateTime dateTime) {
                                          timeAdded.add(_time.format(context));
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
                            const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Center(
                              child: SmallButton(
                                buttonTitle: "Save Medicine",
                                onPressed: () {
                                  if (_formKey.currentState.validate() && timeAdded.length>0) {
                                    for (var i = 0; i<nID.length; i++){
                                      int x =0;
                                      print("notification id canceled:");
                                      print(nID[i]);
                                      x = int.parse(nID[i]);
                                      _notificationPlugin.cancelNotification(x);
                                    }


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
                                    widget.docToEdit.reference.update({
                                      'userID':UserID,
                                      'Name': medicineName.text,
                                      'MedicineType': _medicineType.elementAt(itemCount).name.toString(),
                                      // 'Stock': medicineStock.text,
                                      'Dose': intakeDose.text,
                                      'ReminderTime': (timeAdded.toString().replaceAll("]","")).replaceAll("[","").replaceAll(' ', ''),
                                      'NotificationID' : (notifiID.toString().replaceAll("]","")).replaceAll("[","").replaceAll(' ', ''),
                                      'DateStamp': dateStamp,
                                      'BooleanValues': (boolVal.toString().replaceAll("]","")).replaceAll("[","").replaceAll(' ', ''),

                                    });
                                    Navigator.pop(context);
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
                                  for (var i = 0; i<nID.length; i++){
                                    int x =0;
                                    print("notification id canceled:");
                                    print(nID[i]);
                                    x = int.parse(nID[i]);
                                    _notificationPlugin.cancelNotification(x);
                                  }
                                  widget.docToEdit.reference.delete();
                                  Navigator.pop(context);
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