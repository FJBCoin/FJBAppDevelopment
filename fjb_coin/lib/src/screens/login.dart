import 'package:firebase_auth/firebase_auth.dart';
import 'package:fjb_coin/src/app.dart';
import 'package:fjb_coin/src/screens/main_page.dart';
import 'package:fjb_coin/src/screens/register.dart';
import 'package:fjb_coin/src/screens/reset_password.dart';
import 'package:flutter/material.dart';

import '../flutterfire.dart';
import 'homepage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  late String _email = '';
  late String _password = '';

  final auth = FirebaseAuth.instance;
  bool obscurePassword = true;
  String loginErrorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.amberAccent,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [FJBApp.bannerColor, FJBApp.bannerColorGradient],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topLeft,
            child: Image(
                image: const AssetImage('assets/img/Freedom_Jobs_Business.png'),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3),
          ),
          Stack(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height:
                    MediaQuery.of(context).size.height / FJBApp.formTextOffset,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(400.0),
                    image: DecorationImage(
                        image: const AssetImage('assets/img/fjb_logo.jpg'),
                        fit: BoxFit.fitWidth,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.16), BlendMode.dstATop)),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height:
                    MediaQuery.of(context).size.height / FJBApp.loginTextOffset,
                child: const Text(
                  '\n\n\n\nWelcome, Patriots!',
                  style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 36),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height:
                    MediaQuery.of(context).size.height / FJBApp.loginTextOffset,
                child: const Text(
                  '\n\n\n\n\n\n\n\n\n\nSign in to continue',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height:
                  MediaQuery.of(context).size.height / FJBApp.formTextOffset,
              padding:
                  const EdgeInsets.symmetric(horizontal: FJBApp.textPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    initialValue: '',
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "Enter your email address",
                      labelText: 'Email',
                      fillColor: Colors.red,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: '',
                    obscureText: obscurePassword,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      labelText: 'Password',
                      fillColor: Colors.red,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: IconButton(
                          onPressed: () => setState(
                              () => obscurePassword = !obscurePassword),
                          icon: obscurePassword == true
                              ? const Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey,
                                  size: 20,
                                )
                              : const Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ResetPasswordScreen()));
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  RaisedButton(
                    onPressed: () async {
                      loginErrorText = await signIn(_email, _password);
                      if (loginErrorText == '') {
                        final user = auth.currentUser;
                        print(user?.email.toString());

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()));
                      } else {
                        final errorSB = SnackBar(
                          content: Text(
                            loginErrorText,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          duration: const Duration(seconds: 2),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          margin: const EdgeInsets.fromLTRB(75, 20, 75, 20),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(errorSB);
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      width: MediaQuery.of(context).size.height / 2,
                      height: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        color: Colors.red,
                      ),
                      child: const Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                    child: const Center(
                      child: Text(
                        "Don't have account? Create a new account",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
