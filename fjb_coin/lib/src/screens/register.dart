import 'package:firebase_auth/firebase_auth.dart';
import 'package:fjb_coin/src/screens/login.dart';
import 'package:fjb_coin/src/screens/verify_email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../flutterfire.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String _email = '';
  late String _password = '';
  late String _matchPassword = '';

  final auth = FirebaseAuth.instance;
  bool obscurePassword = true;
  String registerErrorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: FJBApp.bannerColor,
        title: const Text('Register'),
      ),*/
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
                  TextFormField(
                    initialValue: '',
                    obscureText: obscurePassword,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "Re-enter your password",
                      labelText: 'Re-enter Password',
                      fillColor: Colors.red,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(top: 18.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _matchPassword = value.trim();
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  RaisedButton(
                    onPressed: () async {
                      registerErrorText =
                          await register(_email, _password, _matchPassword);
                      if (registerErrorText == '') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const VerifyEmailScreen()));
                      } else {
                        final errorSB = SnackBar(
                          content: Text(
                            registerErrorText,
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
                          'REGISTER',
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
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Center(
                      child: Text(
                        "Already have an account? Sign in",
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
