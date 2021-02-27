import 'package:cloud_firestore/cloud_firestore.dart';

class NoteDataBaseServices {
  //defining collection refrence
   CollectionReference noteCollection = FirebaseFirestore.instance.collection('note');



}