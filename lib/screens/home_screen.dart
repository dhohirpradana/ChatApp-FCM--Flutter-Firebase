import 'package:fire_chat/widgets/appbar_title.dart';
import 'package:fire_chat/widgets/custom_color.dart';
import 'package:fire_chat/widgets/user_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.wetAsphalt,
        appBar: const AppBarTitleWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: UserList(),
        ));
  }
}
