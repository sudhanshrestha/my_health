import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health/pageAssets.dart';


class AddNote extends StatefulWidget {
  static const String id = 'AddNote';



  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController  description = TextEditingController();
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
                    height: 140.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 75.0),
                      child: Text(
                        "Add note",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45.0,
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
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        controller: title,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter title",
                          hintStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),

                      ),
                      SizedBox(
                        height: 350.0,
                        child: TextField(
                          controller: description,
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter description",
                            hintStyle:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          style: TextStyle(fontSize: 18.0, color: Colors.white),

                        ),
                      ),
                      Center(
                        child: AddButton(
                          buttonTitle: "Add Note",
                          onPressed: () {
                            DateTime now = DateTime.now();
                            var dateStamp =
                            DateFormat('yyyy-MM-dd – h:mm a')
                                .format(now);
                            print(dateStamp);
                            _firestore.collection('notes').add({
                              'userID':UserID,
                              'title': title.text,
                              'description': description.text,
                              'DateTime': dateStamp,
                            });
                            Navigator.pop(context);

                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  AddButton({this.buttonTitle, this.onPressed});

  final String buttonTitle;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 350,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            buttonTitle,
            style: TextStyle(
                color: mainColor,
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
