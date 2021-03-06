import 'package:uas/contoh_sederhana/book_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

class BookPage extends StatelessWidget {
  final TextEditingController bookTitleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  //final TextEditingController sinopsisController = TextEditingController();
  CollectionReference _book =
      FirebaseFirestore.instance.collection('book');

  void clearInputText() {
    bookTitleController.text = "";
    authorController.text = "";
    //sinopsisController.text = "";
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          title: Text('Library Apps'),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-5, 0),
                        blurRadius: 15,
                        spreadRadius: 3)
                  ]),
                  width: double.infinity,
                  height: 130,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              controller: bookTitleController,
                              decoration: InputDecoration(
                                  hintText: "Isi Judul Buku",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                            ),
                            TextField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              controller: authorController,
                              decoration: InputDecoration(
                                  hintText: "Isi Nama Author",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                            ),
                            // TextField(
                            //   style: TextStyle(
                            //       color: Colors.black,
                            //       fontWeight: FontWeight.w600,
                            //       fontSize: 16),
                            //   controller: sinopsisController,
                            //   decoration: InputDecoration(
                            //       hintText: "Isi Sinopsis",
                            //       hintStyle: TextStyle(
                            //           color: Colors.grey,
                            //           fontWeight: FontWeight.w600,
                            //           fontSize: 16)),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        height: 130,
                        width: 130,
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: Colors.blue.shade900,
                            child: Text(
                              'Add Data',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              // TODO 1 ADD DATA HERE
                              await _book.add({
                                "title": bookTitleController.text,
                                "author": authorController.text
                                //"sinopsis": sinopsisController.text
                              });
                              clearInputText();
                            }),
                      ),
                    ],
                  ),
                )),
            Expanded(
                          child: ListView(
                children: [
                  // TODO 2 VIEW, update , and delete DATA HERE
                  /// hanya get sekali saja jika menggunakan FutureBuilder
                  /*
                  FutureBuilder<QuerySnapshot>(
                    future: _book.get(),
                    builder: (buildContext, snapshot) {
                      return Column(
                        children: snapshot.data!.docs
                            .map((e) =>
                                ItemCard(e.data()['name'], e.data()['age']))
                            .toList(),
                      );
                    },
                  ),
                  */

                  // get secara realtime jikga menggunakan stream builder
                  StreamBuilder<QuerySnapshot>(
                    // contoh penggunaan srteam
                    // _book.orderBy('age', descending: true).snapshots()
                    // _book.where('age', isLessThan: 30).snapshots()
                    stream:
                        _book.orderBy('title', descending: true).snapshots(),
                    builder: (buildContext, snapshot) {
                      return Column(
                        children: snapshot.data.docs
                            .map((e) => BookCard(
                                  e.data()['title'],
                                  e.data()['auhtor'],
                                  //e.data()['sinopsis'],
                                  onUpdate: () {
                                    _book
                                        .doc(e.id)
                                        .update({"author": authorController.text});
                                  },
                                  onDelete: () {
                                    _book.doc(e.id).delete();
                                  },
                                ))
                            .toList(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 150,
                  )
                ],
              ),
            ),
          
          ],
        ));
  }
}
