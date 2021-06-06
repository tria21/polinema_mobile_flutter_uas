import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('books');

class Book {
   static String userUid;
  static Future<void> addContent({
     String category,
     String title,
     String author,
     String sinopsis,
     
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('contents').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "category": category,
      "title": title,
      "author": author,
      "sinopsis": sinopsis,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("New book added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateContent({
    String category,
     String title,
     String author,
     String sinopsis,
     String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('contents').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
       "category": category,
      "title": title,
      "author": author,
      "sinopsis": sinopsis,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Book updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readContent() {
    CollectionReference notesContentCollection =
        _mainCollection.doc(userUid).collection('contents');

    return notesContentCollection.snapshots();
  }

  static Future<void> deleteContent({
     String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('contents').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Book deleted from the database'))
        .catchError((e) => print(e));
  }
}