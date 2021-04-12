import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_health/notification/notification_plugin.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/home/home.dart';

bool medicineTaken;

class MedicineTaken extends StatefulWidget {
  DocumentSnapshot docToEdit;

  MedicineTaken({this.docToEdit});

  static const String id = 'medicineTakePage';

  @override
  _MedicineTakenState createState() => _MedicineTakenState();
}

class _MedicineTakenState extends State<MedicineTaken> {
  String medicineName;
  String medicineDose;
  String medicineType;
  String medicineStock;
  String intakeDose;
  String docID;
  String boolValues;
  List<String> boolVal;

  @override
  void initState() {
    super.initState();
    docID = widget.docToEdit.id;
    medicineName = widget.docToEdit.data()['Name'];
    medicineDose = widget.docToEdit.data()['Dose'];
    medicineType = widget.docToEdit.data()['MedicineType'];
    medicineStock = widget.docToEdit.data()['Stock'];
    intakeDose = widget.docToEdit.data()['Dose'];
    boolValues = widget.docToEdit.data()['BooleanValues'];
    boolVal = boolValues.split(',');
  }

  final NotificationPlugin _notificationPlugin = NotificationPlugin();

  //Create notification to reminder the user to refill
  createNotification() async {
    var timeID = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    int id = int.parse(timeID.toString());
    final title = medicineName;
    final description = "Your medicine stock is low!";
    final now = DateTime.now();
    //use this to make set reminder after 10 hr
    //final time = DateTime(now.year, now.month, now.day,now.hour + 10);
    //for after a day
    //final time = DateTime(now.year, now.month, now.day + 1);

    // Currently the reminder is set to 2 min after the medicine is taken
    final time =
        DateTime(now.year, now.month, now.day, now.hour, now.minute + 2);
    await _notificationPlugin.schedule(time, id, title, description);
  }

  createRefillNotification() async {
    var timeID = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    int id = int.parse(timeID.toString());
    final title = medicineName;
    final description = "Your medicine stock is finished, Please Refill the stock !";
    final now = DateTime.now();
    //use this to make set reminder after 10 hr
    //final time = DateTime(now.year, now.month, now.day,now.hour + 10);
    //for after a day
    //final time = DateTime(now.year, now.month, now.day + 1);

    // Currently the reminder is set to 2 min after the medicine is taken
    final time =
    DateTime(now.year, now.month, now.day, now.hour, now.minute,now.second + 2);
    await _notificationPlugin.schedule(time, id, title, description);
  }

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    iconSize: 40.0,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
            SizedBox(
              height: 150,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0,
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: mainColor.withOpacity(0.5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 10,
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 35.0,
                                          left: 15.0,
                                          right: 15.0,
                                          bottom: 35.0),
                                      child: Icon(
                                        FontAwesomeIcons.pills,
                                        size: 40.0,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Text(
                                      medicineName,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Text(
                                      "$medicineDose $medicineType",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[700]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "Remaining Stock : $medicineStock",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[700]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TinyButton(
                                  buttonTitle: 'Take',
                                  onPressed: () {

                                    /*
                                    * On medicine intake to save intake history stored in a seperate table
                                    * Some specific information related to taken medicine is stored
                                    *
                                    * */
                                    DateTime now = DateTime.now();
                                    var dateStamp =
                                        DateFormat('yyyy-MM-dd – h:mm a')
                                            .format(now);
                                    print(dateStamp);

                                    _firestore
                                        .collection('MedicineConsume')
                                        .add({
                                      'userID': UserID,
                                      'Name': medicineName,
                                      'MedicineType': medicineType,
                                      'ConsumeAmount': intakeDose,
                                      'DateTime': dateStamp,
                                      'FK_docID': docID,
                                    });

                                    /*
                                    * After storing the consumption history
                                    * Changing the boolean values once as a medicine is taken only once if mulitple reminders
                                    * */
                                    int count = 1;
                                    for (var i = 0; i < boolVal.length; i++) {
                                      if (count == 1) {
                                        boolVal.removeAt(0);
                                        boolVal.add('true');
                                        count = count + 1;
                                      }
                                    }

                                    /*
                                    * Checking the boolean value to send the boolean to indicake medicine taken status
                                    * */
                                    int totalTrue = 0;
                                    int totalItems = boolVal.length;
                                    print(totalItems);
                                    int length = totalItems;
                                    for (var i = 0; i < length; i++) {
                                      print('Values in list :');
                                      print(boolVal[i]);
                                      print('loop started');
                                      // ' true' is added as firebase list is entered with space
                                      if (boolVal[i] == 'true' ||
                                          boolVal[i] == ' true') {
                                        print("Boolean Value");
                                        print(boolVal[i]);
                                        totalTrue = totalTrue + 1;
                                      }
                                    }
                                    print('Total item : $totalItems');
                                    print('Total true : $totalTrue');
                                    if (totalTrue == totalItems) {
                                      widget.docToEdit.reference.update({
                                        'MedicineTaken': 'true',
                                      });
                                    } else {
                                      widget.docToEdit.reference.update({
                                        'MedicineTaken': 'false',
                                      });
                                    }

                                    //Checking medicine stock to send reminder
                                    // medicineTaken = true;
                                    /*
                                    * Updating the stock in the medicine and the boolean values
                                    * */

                                    int newStock = 0;
                                    int dose = int.parse(medicineDose);
                                    newStock = int.parse(medicineStock) - dose;

                                    if (newStock ==0 || newStock < 0) {
                                      createRefillNotification();
                                      widget.docToEdit.reference
                                          .delete()
                                          .whenComplete(() => Navigator.pop(context));
                                    }

                                    print(newStock);
                                    if (newStock <= 5) {
                                      createNotification();
                                    }
                                    widget.docToEdit.reference.update({
                                      'userID': UserID,
                                      'Name': medicineName,
                                      'MedicineType': medicineType,
                                      'Stock': newStock.toString(),
                                      'Dose': intakeDose,
                                      'BooleanValues': (boolVal
                                              .toString()
                                              .replaceAll("]", ""))
                                          .replaceAll("[", ""),
                                    }).whenComplete(() =>
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()),
                                        ));
                                  },
                                ),
                                SizedBox(
                                  width: 60.0,
                                ),
                                TinyButton(
                                  buttonTitle: 'Skip',
                                  onPressed: () {
                                    // medicineTaken = false;
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TinyButton extends StatelessWidget {
  TinyButton({this.buttonTitle, this.onPressed});

  final String buttonTitle;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 100,
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
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'OpenSans'),
          ),
        ),
      ),
    );
  }
}
