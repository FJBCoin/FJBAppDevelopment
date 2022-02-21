import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fjb_coin/src/app.dart';
import 'package:fjb_coin/src/screens/homepage.dart';
import 'package:fjb_coin/src/screens/login.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 30));
      setState(() => canResendEmail = true);
    } catch (e) {
      print('sendverification error: ' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const Homepage()
      : Scaffold(
          backgroundColor: FJBApp.bannerColor,
          appBar: AppBar(
            title: const Text('Verify Email',
                style: TextStyle(color: Colors.white)),
            backgroundColor: FJBApp.bannerColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'A verification email has been sent to your email.',
                  style: TextStyle(fontSize: 40, color: Colors.lightBlueAccent),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60),
                  ),
                  icon: const Icon(Icons.email,
                      size: 32, color: FJBApp.bannerColor),
                  label: const Text(
                    'Resend Email',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  onPressed: canResendEmail ? sendVerificationEmail : null,
                ),
              ],
            ),
          ),
        );
}
