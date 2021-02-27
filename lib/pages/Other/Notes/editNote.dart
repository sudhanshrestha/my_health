import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_health/pageAssets.dart';

class EditNote extends StatefulWidget {
  static const String id = 'EditNote';

  DocumentSnapshot docToEdit;
  EditNote({this.docToEdit});
  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController  description = TextEditingController();

  @override
  void initState() {
    title = TextEditingController(text: widget.docToEdit.data()['title']);
    description = TextEditingController(text: widget.docToEdit.data()['description']);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

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
                        child: Button_edt(
                          buttonTitle: "Save",
                          onPressed: () {

                            widget.docToEdit.reference.update({
                              'title': title.text,
                              'description': description.text,
                            }).whenComplete(() => Navigator.pop(context));

                            // _firestore.collection('notes').add({
                            //   'title': title.text,
                            //   'description': description.text,
                            // }).whenComplete(() => Navigator.pop(context));

                          },
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Center(
                        child: Button_edt(
                          buttonTitle: "Delete",
                          onPressed: () {

                            widget.docToEdit.reference.delete().whenComplete(() => Navigator.pop(context));


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


class Button_edt extends StatelessWidget {
  Button_edt({this.buttonTitle, this.onPressed});

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