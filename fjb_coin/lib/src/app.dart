import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fjb_coin/src/screens/login.dart';
import 'package:flutter/material.dart';

class FJBApp extends StatelessWidget {
  const FJBApp({Key? key}) : super(key: key);
  static const String _title = 'FJB Coin';
  static const bannerColor = Color.fromARGB(255, 28, 44, 76);
  static const bannerColorGradient = Color.fromARGB(255, 28, 44, 76);
  static const double formTextOffset = 1.9;
  static const double loginTextOffset = 1.5;
  static const double textPadding = 50;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: AnimatedSplashScreen(
          splash: const Image(
              image: AssetImage('assets/img/fjb_coin_header.jpg'),
              width: 1000,
              height: 1000),
          duration: 2000,
          splashTransition: SplashTransition.rotationTransition,
          backgroundColor: const Color.fromARGB(255, 28, 44, 76),
          nextScreen: const Scaffold(
            backgroundColor: bannerColor,
            //appBar: AppBar(title: const Text(_title), backgroundColor: bannerColor),
            body: LoginScreen(),
          ),
        ));
  }
}
