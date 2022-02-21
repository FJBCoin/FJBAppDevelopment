import 'package:firebase_auth/firebase_auth.dart';
import 'package:fjb_coin/src/app.dart';
import 'package:fjb_coin/src/screens/login.dart';
import 'package:flutter/material.dart';

import 'marketplace.dart';
import 'home_screen.dart';
import 'wallet.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final String? name = FirebaseAuth.instance.currentUser?.email.toString();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.blueGrey[50],
            appBar: AppBar(
              backgroundColor: FJBApp.bannerColor,
              centerTitle: true,
              title: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 4,
                    height: MediaQuery.of(context).size.height / 4.65,
                    child: const Image(
                        image:
                            AssetImage('assets/img/Freedom_Jobs_Business.png'),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topLeft),
                  ),
                  /*Text(
                    '$name\nSign Out?',
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 14),
                  ),*/
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: Text(
                        '$name\nSign Out?',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: navigationBar(),
            body: const TabBarView(
              children: [
                HomeScreen(),
                WalletScreen(),
                MarketplaceScreen(),
              ],
            )),
      ),
    );
  }

  Widget navigationBar() {
    return Container(
      color: FJBApp.bannerColor,
      child: const TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.red,
        tabs: [
          Tab(text: 'Home', icon: Icon(Icons.home)),
          Tab(
              text: 'Wallet',
              icon: Icon(Icons.account_balance_wallet_outlined)),
          Tab(text: 'Marketplace', icon: Icon(Icons.bar_chart)),
        ],
      ),
    );
  }
}
