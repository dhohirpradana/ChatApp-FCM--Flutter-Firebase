import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SomethingWrongWidget extends StatelessWidget {
  const SomethingWrongWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/lottie/66708-something-went-wrong.json'),
      ),
    );
  }
}
