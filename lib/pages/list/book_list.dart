 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas/database/book.dart';
import 'package:uas/pages/book/edit_screen.dart';

class BookList extends StatelessWidget {
  final kPrimaryColor = Colors.black;
  final kPrimaryLightColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
      stream: Book.readContent(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 5.0),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var noteInfo = snapshot.data.docs[index].data();
                String docID = snapshot.data.docs[index].id;
                String category = noteInfo['category'];
                String title = noteInfo['title'];
                String author = noteInfo['author'];
                String sinopsis = noteInfo['sinopsis'];

                return Card(
                  color: kPrimaryLightColor,
                  elevation: 3.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Icon(
                        Icons.note,
                        color: kPrimaryLightColor,
                      ),
                    ),
                    title: Row(children: [
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Text(
                          category,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            sinopsis,
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            author,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    trailing: GestureDetector(
                        //widget untuk mendeteksi sentuhan
                        child: Icon(Icons.delete),
                        onTap: ()  {
                          showDialog(context: context, builder:(context) => AlertDialog(
                            title : Text("Delete"),
                            content: Text("Are you sure to delete this note? "),
                            actions: <Widget>[
                              FlatButton(onPressed: () {
                                Navigator.pop(context);
                              }, child: Text("Cancel")),
                              FlatButton(onPressed: () async{
                                await Book.deleteContent(docId: docID);
                                Navigator.pop(context);
                              }, child: Text("Yes"))
                            ],
                          ));
                          
                        },
                      ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditBookScreen(
                              currentCategory: category,
                              currentTitle: title,
                              currentAuthor: author,
                              currentSinopsis: sinopsis,
                              documentId: docID,
                            ))),
                  ),
                );
              });
        }
      },
    ));
  }
}