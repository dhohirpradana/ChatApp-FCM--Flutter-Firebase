import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/utils/behavior.dart';
import 'package:fire_chat/utils/store.dart';
import 'package:fire_chat/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  final String uid;
  const ChatList({Key? key, required this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Store.readChat(),
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
                  final uid = FirebaseAuth.instance.currentUser!.uid;
                  final chats = snapshot.data!.docs[index];
                  final sender = chats['sender'];
                  final receiver = chats['receiver'];
                  final isSender = (sender == uid);
                  final msg = chats['msg'];
                  final isRead = (chats['is_read'] == 1) ? true : false;
                  // final docID = snapshot.data!.docs[index].id;
                  return (uid == sender || uid == receiver)
                      ? Ink(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: BubbleNormal(
                            text: msg,
                            isSender: isSender,
                            color: const Color(0xFFE8E8EE),
                            seen: (isSender) ? isRead : false,
                            tail: true,
                          ),
                        )
                      : const SizedBox();
                },
              ));
        }
        return const LoadingWidget();
      },
    );
  }
}
