import 'package:fire_chat/utils/auth.dart';
import 'package:fire_chat/widgets/google_lottie.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 36,
            ),
            const GoogleLottieWidget(),
            ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(4),
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                Auth.signInWithGoogle();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 4.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 24,
                        child: Image.asset('assets/icon/google.png')),
                    const Text(
                      'Sign in with Google',
                      style: TextStyle(color: Colors.black87),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
