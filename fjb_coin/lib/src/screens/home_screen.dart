import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
              child: const Text(
                'Hello, your total balance is:',
                style: TextStyle(
                    fontSize: 36,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(35, 130, 0, 0),
              child: const Text(
                '\$0.00',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 52,
                    color: Colors.red),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ), /*Text(
          'Hello, your total balance is:',
          style: TextStyle(fontSize: 40, color: Colors.black),
          textAlign: TextAlign.left,
        ),*/
      );
}
