import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_health/pageAssets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_maintained/sms.dart';
import 'package:vibrate/vibrate.dart';

class TrackMe extends StatefulWidget {
  static const String id = 'TrackMePage';

  @override
  _TrackMeState createState() => _TrackMeState();
}

class _TrackMeState extends State<TrackMe> {
  CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(28.3974, 84.1258), zoom: 18);
  GoogleMapController newGoogleMapController;

  final Iterable<Duration> pauses = [
    const Duration(milliseconds: 500),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 500),
  ];
  //To track the users position
  geo.Position currentPositon;

  //Timers for map and check location
  Timer updateMap; // timer to update map location
  Timer timerUser; // timer to check user positon change or not

  //boolean to toggle button
  bool showButton = true;

  //get user emergency phone number form firebase
  final ref = FirebaseFirestore.instance
      .collection('profile')
      .where('userID', isEqualTo: UserID);
  String emergencyNumber;

  getUserData() async {
    final documents = await FirebaseFirestore.instance
        .collection('profile')
        .where('userID', isEqualTo: UserID)
        .get();
    final userObject = documents.docs.first.data()['emrNumber'];
    emergencyNumber = userObject;
    print(userObject);
  }

  //Method to pull the location data
  void locatePosition() async {
    geo.Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
    currentPositon = position;
    LatLng latlongPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latlongPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  //Calculate the distance travelled by user
  geo.Position _currentPosition;
  geo.Position _previousPosition;
  StreamSubscription<geo.Position> _positionStream;
  double totalDistance = 0;
  List<geo.Position> locations = [];

  Future calculateDistance() async {
    _positionStream = geo.Geolocator.getPositionStream(
            distanceFilter: 10, desiredAccuracy: geo.LocationAccuracy.high)
        .listen((geo.Position position) async {
      if ((await geo.Geolocator.isLocationServiceEnabled())) {
        geo.Geolocator.getCurrentPosition(
                desiredAccuracy: geo.LocationAccuracy.high)
            .then((geo.Position position) {
          setState(() {
            _currentPosition = position;
            locations.add(_currentPosition);

            if (locations.length > 1) {
              _previousPosition = locations.elementAt(locations.length - 2);

              var _distanceBetweenLastTwoLocations =
                  geo.Geolocator.distanceBetween(
                _previousPosition.latitude,
                _previousPosition.longitude,
                _currentPosition.latitude,
                _currentPosition.longitude,
              );
              totalDistance += _distanceBetweenLastTwoLocations;
              print('Total Distance: $totalDistance');
            }
          });
        }).catchError((err) {
          print(err);
        });
      } else {
        print("GPS is off.");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text('Make sure your GPS is on in Settings !'),
                actions: <Widget>[
                  ElevatedButton(
                      child: Text('OK'),
                      style: ElevatedButton.styleFrom(
                        primary: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      })
                ],
              );
            });
      }
    });
  }

  //get user location
  String userLocation;

  locationSMS() async {
    geo.Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print('getting user location : ');
    print("${first.featureName} : ${first.addressLine}");
    userLocation = "${first.featureName} : ${first.addressLine}";
  }

  // checking user location
  checkLocationStatus() async {
    if (await geo.Geolocator.isLocationServiceEnabled()) {
      // location service is enabled, and location permission is granted
      print('---------------- Checking user location ----------------------');
      print("Distance travelled by user : $totalDistance");
      if (totalDistance < 1) {
        print("XXXXXXXXXXXXXXX NO CHANGE IN LOCATION XXXXXXXXXXXXXXXXXXXXXX");
        setState(() {
          totalDistance = 0;
        });
        locationSMS();
        if (await Vibrate.canVibrate) {
          Vibrate.vibrateWithPauses(pauses);
        }
        Future<AlertDialog> action = showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),

                ),
                title: Text("Status Check"),
                content: Text("Are you ok ?"),
                actions: <Widget>[
                  ElevatedButton(
                      child: Text("YES"),
                      style: ElevatedButton.styleFrom(
                        primary: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      }),
                  ElevatedButton(
                      child: Text("NO"),
                      style: ElevatedButton.styleFrom(
                        primary: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        //Sending SMS if pressed no
                        SmsSender sender = SmsSender();
                        String address = emergencyNumber;
                        SmsMessage message = SmsMessage(
                            address, 'I need you help! $userLocation');
                        message.onStateChanged.listen((state) {
                          if (state == SmsMessageState.Sent) {
                            print("SMS is sent!");
                            print("Number : $address");
                          } else if (state == SmsMessageState.Delivered) {
                            print("SMS is delivered!");
                          }
                        });
                        sender.sendSms(message);
                      }),
                ],
              );
            });
      }
      // return print("No change in position first: $firstLocation sec: $secondLocation");

      if (totalDistance > 1) {
        print("XXXXXXXXXXXXXXX LOCATION CHANGED XXXXXXXXXXXXXXXXXXXXXX");
        setState(() {
          totalDistance = 0;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    locatePosition();
    calculateDistance();
  }
  @override
  void dispose() {
    timerUser.cancel();
    updateMap.cancel();
    _positionStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Me'),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: initialCameraPosition,
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                newGoogleMapController = controller;
                updateMap = Timer.periodic(Duration(seconds: 5), (timer) {
                  locatePosition();
                });
              },
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Column(
                      children: [
                        showButton
                            ? PageButtons(
                                buttonTitle: "Track Me",
                                onPressed: () {
                                  //on button press change boolean to toggle STOP button
                                  setState(() {
                                    showButton = false;
                                  });
                                  //Checking user position with timer to display aleart
                                  timerUser = Timer.periodic(
                                      Duration(seconds: 10), (timer) {
                                    print(
                                        "------------------ User Tracking Started ------------------");
                                    checkLocationStatus();
                                    print(
                                        "-----------------------------------------------------------");
                                  });
                                },
                              )
                            : PageButtons(
                                buttonTitle: "Stop",
                                onPressed: () {
                                  print(
                                      "XXXXXXXXXXXXX TRACKING ENDED XXXXXXXXXXXXXXXXXXXX");
                                  timerUser.cancel();
                                  updateMap.cancel();
                                  setState(() {
                                    showButton = true;
                                    totalDistance = 0;
                                  });
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
