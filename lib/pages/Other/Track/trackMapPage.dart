// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:my_health/pageAssets.dart';
// import 'package:sms_maintained/contact.dart';
// import 'package:sms_maintained/generated/i18n.dart';
// import 'package:sms_maintained/globals.dart';
// import 'package:sms_maintained/sms.dart';
//
// class TracKMapPage extends StatefulWidget {
//   static const String id = 'TrackMapPage';
//
//   @override
//   _TracKMapPageState createState() => _TracKMapPageState();
// }
//
// class _TracKMapPageState extends State<TracKMapPage> {
//   Timer timerUser;
//   Timer updateMap;
//   bool onButtonPress = true;
//   bool stopTimer = false;
//   bool showButton = true;
//   String buttonText = "Track Me";
//   String data = "location data";
//   bool smsHelp = true;
//   String userLocation;
//   String emergencyNumber;
//   Text EmrNum;
//   double tempLat;
//   double tempLong;
//   double totalDistance = 0;
//   final ref = FirebaseFirestore.instance
//       .collection('profile')
//       .where('userID', isEqualTo: UserID);
//
//   getUserData() async {
//     final documents = await FirebaseFirestore.instance
//         .collection('profile')
//         .where('userID', isEqualTo: UserID)
//         .get();
//     final userObject = documents.docs.first.data()['emrNumber'];
//     emergencyNumber = userObject;
//     print(userObject);
//   }
//
//   //Initial Position when tracking
//   Position firstLocation;
//
//   //Position after 5 min
//   Position secondLocation;
//
//   Completer<GoogleMapController> _controllerGoogleMap = Completer();
//   GoogleMapController newGoogleMapController;
//
//   Position currentPosition;
//   var geoLocator = Geolocator();
//
//   locationSMS() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.lowest);
//     debugPrint('location: ${position.latitude}');
//     final coordinates = new Coordinates(position.latitude, position.longitude);
//     var addresses =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     var first = addresses.first;
//     print("${first.featureName} : ${first.addressLine}");
//     userLocation = "${first.featureName} : ${first.addressLine}";
//   }
//
//   void locatePosition() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.lowest);
//     currentPosition = position;
//
//     LatLng latlonPosition = LatLng(position.latitude, position.longitude);
//
//     CameraPosition cameraPosition =
//         new CameraPosition(target: latlonPosition, zoom: 18);
//     newGoogleMapController
//         .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//   }
//
//   void initialPosition() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.lowest);
//     firstLocation = position;
//   }
//
//   // void finalPostiton() async {
//   //   Position position = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.best);
//   //   secondLocation = position;
//   // }
//
//   checkLocationStat() {
//     print("Checking location");
//     print("Distance Travelled $totalDistance");
//     // print("Initial Pos: $firstLocation");
//     // print("Second Pos: $tempLat $tempLong");
//     if (totalDistance<15) {
//       setState(() {
//         data = "No change in position ";
//         print("Second Location: $secondLocation");
//         totalDistance = 0;
//       });
//       Future<AlertDialog> action = showDialog(
//           context: context,
//           barrierDismissible: true,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               title: Text("Status Check"),
//               content: Text("Are you ok ?"),
//               actions: <Widget>[
//                 ElevatedButton(
//                     child: Text("YES"),
//                     style: ElevatedButton.styleFrom(
//                       primary: mainColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.of(context, rootNavigator: true).pop();
//                     }),
//                 ElevatedButton(
//                     child: Text("NO"),
//                     style: ElevatedButton.styleFrom(
//                       primary: mainColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.of(context, rootNavigator: true).pop();
//                       //Sending SMS if pressed no
//                       SmsSender sender = SmsSender();
//                       String address = emergencyNumber;
//                       SmsMessage message =
//                           SmsMessage(address, 'I need you help! $userLocation');
//                       message.onStateChanged.listen((state) {
//                         if (state == SmsMessageState.Sent) {
//                           print("SMS is sent!");
//                           print("Number : $address");
//                         } else if (state == SmsMessageState.Delivered) {
//                           print("SMS is delivered!");
//                         }
//                       });
//                       sender.sendSms(message);
//                     }),
//               ],
//             );
//           });
//     }
//     // return print("No change in position first: $firstLocation sec: $secondLocation");
//
//     if(totalDistance > 15) {
//       setState(() {
//         data = "change in postiion";
//         totalDistance = 0;
//       });
//
//       return print(
//           "change in position distance $totalDistance");
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     getUserData();
//     locatePosition();
//     _calculateDistance();
//   }
//   Position _currentPosition;
//   Position _previousPosition;
//   StreamSubscription<Position> _positionStream;
//
//
//   List<Position> locations = List<Position>();
//
//   Future _calculateDistance() async {
//     _positionStream = Geolocator.getPositionStream(
//         distanceFilter: 10, desiredAccuracy: LocationAccuracy.high)
//         .listen((Position position) async {
//       if ((await Geolocator.isLocationServiceEnabled())) {
//         Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//             .then((Position position) {
//           setState(() {
//             _currentPosition = position;
//             locations.add(_currentPosition);
//
//             if (locations.length > 1) {
//               _previousPosition = locations.elementAt(locations.length - 2);
//
//               var _distanceBetweenLastTwoLocations = Geolocator.distanceBetween(
//                 _previousPosition.latitude,
//                 _previousPosition.longitude,
//                 _currentPosition.latitude,
//                 _currentPosition.longitude,
//               );
//               totalDistance += _distanceBetweenLastTwoLocations;
//               print('Total Distance: $totalDistance');
//             }
//           });
//         }).catchError((err) {
//           print(err);
//         });
//       } else {
//         print("GPS is off.");
//         showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 content: const Text('Make sure your GPS is on in Settings !'),
//                 actions: <Widget>[
//                   FlatButton(
//                       child: Text('OK'),
//                       onPressed: () {
//                         Navigator.of(context, rootNavigator: true).pop();
//                       })
//                 ],
//               );
//             });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     timerUser.cancel();
//     updateMap.cancel();
//     _positionStream.cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Track Me"),
//         centerTitle: true,
//         backgroundColor: mainColor,
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             GoogleMap(
//               padding: EdgeInsets.only(bottom: 100.0),
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(28.3974, 84.1258),
//               ),
//               mapType: MapType.normal,
//               myLocationButtonEnabled: true,
//               myLocationEnabled: true,
//               zoomGesturesEnabled: true,
//               zoomControlsEnabled: false,
//               onMapCreated: (GoogleMapController controller) {
//                 _controllerGoogleMap.complete(controller);
//                 newGoogleMapController = controller;
//                 updateMap = Timer.periodic(Duration(seconds: 5), (timer) {
//                   locatePosition();
//                 });
//               },
//             ),
//             Positioned(
//               bottom: 0.0,
//               right: 0.0,
//               left: 0.0,
//               child: Column(
//                 children: [
//                   Container(
//                     child: Text(
//                       data != null ? data : "Location value",
//                       style: TextStyle(fontSize: 20.0, color: Colors.red),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: 10, right: 10, bottom: 15.0),
//                     child: Column(
//                       children: [
//                         showButton
//                             ? PageButtons(
//                                 buttonTitle: "Track Me",
//                                 onPressed: () {
//                                   setState(() {
//                                     showButton = false;
//                                   });
//                                   //checking position every time period set
//                                   timerUser = Timer.periodic(
//                                       Duration(seconds: 10), (timer) {
//                                     print("Start tracking");
//                                     initialPosition();
//                                     // finalPostiton();
//                                     checkLocationStat();
//                                     setState(() {
//                                       tempLat = firstLocation.latitude;
//                                       tempLong = firstLocation.longitude;
//                                     });
//                                   });
//                                 },
//                               )
//                             : PageButtons(
//                                 buttonTitle: "Stop",
//                                 onPressed: () {
//                                   print("Tracking Stopped");
//                                   timerUser.cancel();
//                                   setState(() {
//                                     showButton = true;
//                                   });
//                                 },
//                               )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
