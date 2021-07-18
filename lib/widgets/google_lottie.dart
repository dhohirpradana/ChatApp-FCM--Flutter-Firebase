import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GoogleLottieWidget extends StatelessWidget {
  const GoogleLottieWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/8093-google-sign-in.json',
      width: MediaQuery.of(context).size.width / 5,
      frameRate: FrameRate(60),
      repeat: true,
    );
  }
}
