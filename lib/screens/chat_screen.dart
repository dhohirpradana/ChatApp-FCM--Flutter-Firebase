import 'dart:async';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/utils/behavior.dart';
import 'package:fire_chat/utils/onesignal.dart';
import 'package:fire_chat/utils/store.dart';
import 'package:fire_chat/widgets/appbar_title_chat.dart';
import 'package:fire_chat/widgets/custom_color.dart';
import 'package:fire_chat/widgets/loading.dart';
import 'package:fire_chat/widgets/something_wrong.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatScreen extends StatefulWidget {
  final String uid, onesignal, photo, nama, status;
  const ChatScreen({
    Key? key,
    required this.uid,
    required this.onesignal,
    required this.photo,
    required this.nama,
    required this.status,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    // After 1 second, it takes you to the bottom of the ListView
    Timer(
      const Duration(milliseconds: 600),
      () => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
      ),
    );
    return Scaffold(
        backgroundColor: CustomColor.wetAsphalt,
        appBar: AppBarTitleChatWidget(
          url: widget.photo,
          nama: widget.nama,
          status: widget.status,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 70),
              child: StreamBuilder<QuerySnapshot>(
                stream: Store.readChat(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const SomethingWrongWidget();
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView.builder(
                          controller: _scrollController,
                          // reverse: true,
                          cacheExtent: 10,
                          shrinkWrap: true,
                          // separatorBuilder: (context, index) =>
                          //     const SizedBox(height: 16.0),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final chats = snapshot.data!.docs[index];
                            final sender = chats['sender'];
                            final receiver = chats['receiver'];
                            final isSender = (sender == uid);
                            final msg = chats['msg'];
                            final isRead =
                                (chats['is_read'] == 1) ? true : false;
                            final docID = snapshot.data!.docs[index].id;
                            return (uid == sender && widget.uid == receiver ||
                                    uid == receiver && widget.uid == sender)
                                ? Ink(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: GestureDetector(
                                      onLongPress: () => (isSender)
                                          ? Store.deleteChat(docId: docID)
                                          : () {},
                                      child: BubbleNormal(
                                        text: msg,
                                        isSender: isSender,
                                        color: const Color(0xFFE8E8EE),
                                        seen: (isSender) ? isRead : false,
                                        tail: true,
                                      ),
                                    ),
                                  )
                                : const SizedBox();
                          },
                        ));
                  }
                  return const LoadingWidget();
                },
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _textEditingController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(
                            MdiIcons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (_textEditingController.text != '') {
                              Store.createChat(
                                      sender: uid,
                                      receiver: widget.uid,
                                      msg: _textEditingController.text)
                                  .then((value) {
                                handleSendNotification(
                                    playerId: widget.onesignal,
                                    msg: _textEditingController.text,
                                    sender: FirebaseAuth
                                        .instance.currentUser!.displayName!);
                                _textEditingController.clear();
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.fastOutSlowIn,
                                );
                              });
                            }
                          },
                        ),
                        hintStyle: const TextStyle(color: Colors.white70),
                        hintText: 'tulis sesuatu...',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
