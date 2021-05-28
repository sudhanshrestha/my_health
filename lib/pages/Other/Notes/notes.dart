import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_health/pageAssets.dart';
import 'package:my_health/pages/Other/Notes/addNotes.dart';
import 'package:my_health/pages/Other/Notes/editNote.dart';

class NotePage extends StatefulWidget {
  static const String id = 'NotesPage';

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final ref = FirebaseFirestore.instance
      .collection('notes')
      .where('userID', isEqualTo: UserID);

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
                        "Notes",
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
                physics: ScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50.0,
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: ref.snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            return ClipRect(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: snapshot.hasData
                                      ? snapshot.data.docs.length
                                      : 0,
                                  itemBuilder: (_, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => EditNote(
                                                    docToEdit: snapshot
                                                        .data.docs[index])));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(15.0),
                                        padding: EdgeInsets.all(15.0),
                                        //removed this because causing rendex flex in text overflow
                                        // height: 150.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data.docs[index]
                                                  .data()['title'],
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              snapshot.data.docs[index]
                                                  .data()['description'],
                                              style: TextStyle(
                                                fontSize: 17.0,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 20,),
                                            Row(
                                              children: [
                                                SizedBox(width: 170.0,),
                                                Text(
                                                  snapshot.data.docs[index]
                                                      .data()['DateTime'],
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.grey
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }),
                    ]),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AddNote.id);
        },
        label: Text('Add notes'),
        icon: Icon(Icons.add),
        backgroundColor: mainColor,
      ),
    );
  }
}


// class NotesCard extends StatelessWidget {
//   final Note note;
//
//   NotesCard(this.note);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(15.0),
//       padding: EdgeInsets.all(15.0),
//       height: 150.0,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             note.title,
//             style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 5.0,
//           ),
//           Text(
//             note.description,
//             style: TextStyle(
//               fontSize: 17.0,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
