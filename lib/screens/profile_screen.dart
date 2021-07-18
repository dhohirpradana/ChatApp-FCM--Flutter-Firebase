import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/utils/auth.dart';
import 'package:fire_chat/widgets/custom_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fire_chat/utils/string_cap_extension.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _controller = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ubah status'),
            content: TextField(
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              maxLength: 18,
              controller: _controller,
              decoration: const InputDecoration(hintText: "tulis status..."),
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              Auth.updateStatus(status: _controller.text)
                                  .then((value) {
                                Navigator.pop(context);
                              });
                            }
                          },
                          child: const Text('SIMPAN'))),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // color: const Color(0xff74b9ff),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  // const Color(0xffdfe6e9),
                  const Color(0xff00cec9),
                  CustomColor.wetAsphalt,
                  CustomColor.wetAsphalt,
                ])),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 3 / 9,
                left: 15,
                right: 15,
                bottom: 160),
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 200.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                            Text(
                              'FOLLOW',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            Text(
                              '128K',
                              style: TextStyle(
                                  fontSize: 40, color: Colors.black87),
                            )
                          ],
                        ),
                        Column(
                          children: const [
                            Text(
                              'LIKES',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            Text(
                              '256K',
                              style: TextStyle(
                                  fontSize: 40, color: Colors.black87),
                            )
                          ],
                        ),
                        Column(
                          children: const [
                            Text(
                              'FRIENDS',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            Text(
                              '298',
                              style: TextStyle(
                                  fontSize: 40, color: Colors.black87),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ConstrainedBox(
                              constraints:
                                  const BoxConstraints.tightFor(height: 40),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xffe74c3c))),
                                  onPressed: () {
                                    Auth.signOut();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Sign out')),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 3 / 9 -
                          MediaQuery.of(context).size.width / 6,
                      bottom: 30),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: MediaQuery.of(context).size.width / 6,
                    backgroundImage: NetworkImage(
                      FirebaseAuth.instance.currentUser!.photoURL.toString(),
                    ),
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.displayName
                      .toString()
                      .capitalizeFirstofEach,
                  style: const TextStyle(fontSize: 26),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream:
                      Auth.readStatus(FirebaseAuth.instance.currentUser!.email),
                  builder: (context, snapshot) {
                    if (snapshot.hasData || snapshot.data != null) {
                      final status = snapshot.data!.docs[0]['status'];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            status.toString(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                _displayTextInputDialog(context);
                              },
                              child: const Icon(
                                MdiIcons.squareEditOutline,
                                color: Colors.black54,
                                size: 16,
                              ),
                            ),
                          )
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
