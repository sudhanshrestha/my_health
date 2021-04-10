import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_health/notification/notification_plugin.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/home/home.dart';

bool medicineTaken = false;
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


  @override
  void initState() {
    super.initState();
    medicineName = widget.docToEdit.data()['Name'];
    medicineDose = widget.docToEdit.data()['Dose'];
    medicineType = widget.docToEdit.data()['MedicineType'];
    medicineStock = widget.docToEdit.data()['Stock'];
    intakeDose = widget.docToEdit.data()['Dose'];
    medicineTaken=false;
  }
  final NotificationPlugin _notificationPlugin = NotificationPlugin();
  createNotification() async {
    var timeID = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    int id = int.parse(timeID.toString());
    final title = medicineName;
    final description = "Your medicine stock is low!";
    final now = DateTime.now();
    //final time = DateTime(now.year, now.month, now.day + 1);
    final time = DateTime(now.year, now.month, now.day, now.hour,now.minute + 2);
    await _notificationPlugin.schedule(time, id,title, description);
  }



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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    //when medicine is taken
                                    medicineTaken = true;
                                    int newStock =0;
                                    int dose = int.parse(medicineDose);
                                    newStock = int.parse(medicineStock) - dose;
                                    print(newStock);
                                    if(newStock<=5){
                                      createNotification();
                                    }
                                    widget.docToEdit.reference.update({
                                      'userID':UserID,
                                      'Name': medicineName,
                                      'MedicineType': medicineType,
                                      'Stock': newStock.toString(),
                                      'Dose': intakeDose,
                                    }).whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),));
                                  },
                                ),
                                SizedBox(
                                  width: 60.0,
                                ),
                                TinyButton(
                                  buttonTitle: 'Skip',
                                  onPressed: () {
                                    medicineTaken = false;
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
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
