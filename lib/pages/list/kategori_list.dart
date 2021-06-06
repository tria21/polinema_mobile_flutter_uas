import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uas/database/kategori.dart';
import 'package:uas/pages/screen_category/edit_screen.dart';

class CategoryList extends StatelessWidget {
  final kPrimaryColor = Colors.black;
  final kPrimaryLightColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
      stream: Kategori.readItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 5.0),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var categoryInfo = snapshot.data.docs[index].data();
                String docID = snapshot.data.docs[index].id;
                String title = categoryInfo['namaKategori'];
                String description = categoryInfo['description'];

                return Card(
                  color: kPrimaryLightColor,
                  elevation: 3.0,
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: kPrimaryColor,
                        child: Icon(
                          Icons.category,
                          color: kPrimaryLightColor,
                        ),
                      ),
                      title: Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, //horizontal
                        mainAxisAlignment: MainAxisAlignment.start, //vertical
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              description,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
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
                            content: Text("Are you sure to delete this category ? "),
                            actions: <Widget>[
                              FlatButton(onPressed: () {
                                Navigator.pop(context);
                              }, child: Text("Cancel")),
                              FlatButton(onPressed: () async{
                                await Kategori.deleteItem(docId: docID);
                                Navigator.pop(context);
                              }, child: Text("Yes"))
                            ],
                          ));
                          
                        },
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditScreen(
                              currentName: title,
                              currentDesc: description,
                              documentId: docID,
                            ),
                          ))),
                );
              });
        }
      },
    ));
  }
}