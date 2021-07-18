import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Lottie.asset('assets/lottie/9308-welcome-screen-animation.json',
            width: MediaQuery.of(context).size.width / 5),
      ),
    );
  }
}
