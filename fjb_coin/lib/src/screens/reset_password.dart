import 'package:firebase_auth/firebase_auth.dart';
import 'package:fjb_coin/src/screens/login.dart';
import 'package:flutter/material.dart';
import '../app.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreen createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  late String _email = '';

  final auth = FirebaseAuth.instance;
  bool obscurePassword = true;
  String registerErrorText = '';

  final emailSentSB = const SnackBar(
    content: Text(
      'Reset Password Email Sent',
      style: TextStyle(fontSize: 16, color: Colors.white),
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    margin: EdgeInsets.fromLTRB(75, 20, 75, 20),
    behavior: SnackBarBehavior.floating,
    backgroundColor: FJBApp.bannerColor,
  );

  final errorSB = const SnackBar(
    content: Text(
      'Unknown Email Provided',
      style: TextStyle(fontSize: 16, color: Colors.white),
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    margin: EdgeInsets.fromLTRB(75, 20, 75, 20),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: FJBApp.bannerColor,
        title: const Text('Reset Password'),
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
                  '\n\n\n\n\n\n\n\n\n\nReset your password',
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
                  Text(registerErrorText,
                      style: const TextStyle(fontSize: 14, color: Colors.red)),
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
                  const SizedBox(height: 50),
                  RaisedButton(
                    onPressed: () async {
                      if (_email.contains('@')) {
                        await auth.sendPasswordResetEmail(email: _email);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));

                        ScaffoldMessenger.of(context).showSnackBar(emailSentSB);
                      } else {
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
                          'RESET PASSWORD',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FlatButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Center(
                      child: Text(
                        "Don't need to reset password? Sign in",
                        style: TextStyle(fontSize: 16, color: Colors.black),
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
