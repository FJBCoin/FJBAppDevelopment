import 'package:firebase_auth/firebase_auth.dart';
import 'package:fjb_coin/src/screens/verify_email.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return VerifyEmailScreen();
            } else {
              return Homepage();
            }
          },
        ),
      );
}
