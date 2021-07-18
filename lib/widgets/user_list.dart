import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/screens/chat_screen.dart';
import 'package:fire_chat/utils/auth.dart';
import 'package:fire_chat/utils/behavior.dart';
import 'package:fire_chat/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Auth.readUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final users = snapshot.data!.docs[index];
                  final name = users['name'];
                  final email = users['email'];
                  final onesignal = users['onesignal'];
                  final docID = snapshot.data!.docs[index].id;
                  return (docID == FirebaseAuth.instance.currentUser!.uid)
                      ? const SizedBox()
                      : Ink(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            uid: docID,
                                            onesignal: onesignal,
                                          )));
                            },
                            title: Text(name),
                            subtitle: Text(email),
                          ));
                },
              ));
        }
        return const LoadingWidget();
      },
    );
  }
}
