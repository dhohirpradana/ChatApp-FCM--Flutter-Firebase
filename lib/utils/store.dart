import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('chat');
final userUid = FirebaseAuth.instance.currentUser!.uid;

class Store {
  static Future<void> createChat({
    required String sender,
    required String receiver,
    required String msg,
  }) async {
    var now = DateTime.now().millisecondsSinceEpoch;
    DocumentReference documentReferencer = _mainCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "sender": sender,
      "receiver": receiver,
      "msg": msg,
      "time": now,
      "is_read": 1
    };

    await documentReferencer.set(data);
    // .whenComplete(() => print("Pesan terkirim"))
    // .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readChat() {
    Query chatsCollection =
        _firestore.collection('chat').orderBy('time', descending: false);
    return chatsCollection.snapshots();
  }

  // static Future<void> updateChat({
  //   required String title,
  //   required String description,
  //   required String docId,
  // }) async {
  //   DocumentReference documentReferencer =
  //       _mainCollection.doc(userUid).collection('items').doc(docId);

  //   Map<String, dynamic> data = <String, dynamic>{
  //     "title": title,
  //     "description": description,
  //   };

  //   await documentReferencer
  //       .update(data)
  //       .whenComplete(() => print("Note item updated in the database"))
  //       .catchError((e) => print(e));
  // }

  static Future<void> deleteChat({
    required String docId,
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc(docId);

    await documentReferencer.delete();
    // .whenComplete(() => print('Chat dihapus'))
    // .catchError((e) => print(e));
  }
}
