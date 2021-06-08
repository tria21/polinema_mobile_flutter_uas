import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas/database/book.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('books');

class Kategori {
  static String userUid;

  static Future<void> addItem({
     String namaKategori,
     String description,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('categorys').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "namaKategori": namaKategori,
      "description": description,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Category added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    String namaKategori,
     String description,
     String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('categorys').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "namaKategori": namaKategori,
      "description": description,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Category updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference booksCategoryCollection =
        _mainCollection.doc(userUid).collection('categorys');

    return booksCategoryCollection.snapshots();
  }

  static Future<void> deleteItem({
     String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('categorys').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Category deleted from the database'))
        .catchError((e) => print(e));
  }
}