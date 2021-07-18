import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/utils/store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('user');

class Auth {
  static Future<void> createUser({
    required User user,
    required String onesignal,
  }) async {
    var now = DateTime.now().millisecondsSinceEpoch;
    DocumentReference documentReferencer = _mainCollection.doc(userUid);

    Map<String, dynamic> data = <String, dynamic>{
      "name": user.displayName,
      "email": user.email,
      "photo": user.photoURL,
      "time": now,
      "onesignal": onesignal,
      "state": 1
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("User ditambah"))
        .catchError((e) => print(e));
  }

  static Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    DocumentSnapshot ds =
        await _mainCollection.doc(userCredential.user!.uid).get();
    if (ds.exists) {
      print('data sudah ada');
    } else {
      createUser(user: userCredential.user!, onesignal: 'onesignal player id');
    }
  }

  static Stream<QuerySnapshot> readUser() {
    CollectionReference chatsCollection = _firestore.collection('user');
    return chatsCollection.snapshots();
  }

  static signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
