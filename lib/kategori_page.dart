import 'package:uas/kategori_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

class KategoriPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  CollectionReference _pengguna =
      FirebaseFirestore.instance.collection('pengguna');

  void clearInputText() {
    titleController.text = "";
    descriptionController.text = "";
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
                              controller: titleController,
                              decoration: InputDecoration(
                                  hintText: "Isi Nama Kategori",
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
                              controller: descriptionController,
                              decoration: InputDecoration(
                                  hintText: "Isi Deskripsi Kategori",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                              keyboardType: TextInputType.number,
                            ),
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
                              await _pengguna.add({
                                "name": titleController.text,
                                "age": double.tryParse(descriptionController.text)
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
                    future: _pengguna.get(),
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
                    // _pengguna.orderBy('age', descending: true).snapshots()
                    // _pengguna.where('age', isLessThan: 30).snapshots()
                    stream:
                        _pengguna.orderBy('age', descending: true).snapshots(),
                    builder: (buildContext, snapshot) {
                      return Column(
                        children: snapshot.data.docs
                            .map((e) => KategoriCard(
                                  e.data()['title'],
                                  e.data()['description'],
                                  onUpdate: () {
                                    _pengguna
                                        .doc(e.id)
                                        .update({"description": descriptionController.text});
                                  },
                                  onDelete: () {
                                    _pengguna.doc(e.id).delete();
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
