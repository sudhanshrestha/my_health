import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_health/bottomNavigation.dart';
import 'package:my_health/pages/Other/Doctors/addDoctor.dart';
import 'package:my_health/pages/Other/Doctors/doctor.dart';
import 'package:my_health/pages/Other/Doctors/doctorInfo.dart';
import 'package:my_health/pages/Other/Notes/addNotes.dart';
import 'package:my_health/pages/Other/Notes/editNote.dart';
import 'package:my_health/pages/Other/Notes/notes.dart';
import 'package:my_health/pages/Other/Other.dart';
import 'package:my_health/pages/Other/Profile/editProfile.dart';
import 'package:my_health/pages/Other/Profile/profile.dart';
import 'package:my_health/pages/Other/Profile/profileDisplay.dart';
import 'package:my_health/pages/Other/Track/trackMe.dart';
import 'package:my_health/pages/Other/Track/trackTimer.dart';
import 'package:my_health/pages/Other/medicineHistory/medicineHistory.dart';
import 'package:my_health/pages/home/home.dart';
import 'package:my_health/pages/home/medicineTaken.dart';
import 'package:my_health/pages/loadingPage.dart';
import 'package:my_health/pages/login/login.dart';
import 'package:my_health/pages/medicine/addMedicine.dart';
import 'package:my_health/pages/medicine/editMedicine.dart';
import 'package:my_health/pages/medicine/medicine.dart';
import 'package:my_health/pages/measurement/BloodPressure/addBloodPressure.dart';
import 'package:my_health/pages/measurement/BloodPressure/bloodPressure.dart';
import 'package:my_health/pages/measurement/BloodPressure/editBloodPressure.dart';
import 'package:my_health/pages/measurement/BodyFat/addBodyFat.dart';
import 'package:my_health/pages/measurement/BodyFat/bodyFat.dart';
import 'package:my_health/pages/measurement/BodyFat/editBodyFat.dart';
import 'package:my_health/pages/measurement/Pulse/addPulse.dart';
import 'package:my_health/pages/measurement/Pulse/editPulse.dart';
import 'package:my_health/pages/measurement/Pulse/pulse.dart';
import 'package:my_health/pages/measurement/measurement.dart';
import 'package:my_health/pages/register/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyHealth());
}

class MyHealth extends StatefulWidget {
  @override
  _MyHealthState createState() => _MyHealthState();
}

class _MyHealthState extends State<MyHealth> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Poppins"),
      home: LoadingPage(),
      initialRoute: LoadingPage.id,
      routes: {
        LoadingPage.id: (context) => LoadingPage(),
        Login.id: (context) => Login(),
        Register.id: (context) => Register(),
        HomePage.id: (context) => HomePage(),
        MedicinePage.id: (context) => MedicinePage(),
        AddMedicine.id: (context) => AddMedicine(),
        Measurement.id: (context) => Measurement(),
        BloodPressurePage.id: (context) => BloodPressurePage(),
        AddBloodPressure.id: (context) => AddBloodPressure(),
        BodyFatPage.id: (context) => BodyFatPage(),
        AddBodyFatPage.id: (context) => AddBodyFatPage(),
        PulsePage.id: (context) => PulsePage(),
        AddPulsePage.id: (context) => AddPulsePage(),
        OtherPage.id: (context) => OtherPage(),
        ProfilePage.id: (context) => ProfilePage(),
        ProfileDisplay.id: (context) => ProfileDisplay(),
        EditProfile.id: (context) => EditProfile(),
        NotePage.id: (context) => NotePage(),
        AddNote.id: (context) => AddNote(),
        EditNote.id: (context) => EditNote(),
        DoctorPage.id: (context) => DoctorPage(),
        AddDoctorPage.id: (context) => AddDoctorPage(),
        DoctorInfo.id: (context) => DoctorInfo(),
        EditPulse.id: (context) => EditPulse(),
        EditBodyFat.id: (context) => EditBodyFat(),
        EditBloodPressure.id: (context) => EditBloodPressure(),
        EditMedicine.id: (context) => EditMedicine(),
        MedicineTaken.id: (context) => MedicineTaken(),
        TrackMe.id: (context) => TrackMe(),
        TrackTimer.id: (context) => TrackTimer(),
        MedicineHistory.id: (context) => MedicineHistory(),
      },
    );
  }
}
