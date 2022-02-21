import 'package:firebase_auth/firebase_auth.dart';
import 'package:fjb_coin/src/screens/login.dart';

Future<String> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return '';
  } on FirebaseAuthException catch (e) {
    switch (e.code.toUpperCase()) {
      case "INVALID-EMAIL":
        return "Your email address appears to be malformed.";
      case "WRONG-PASSWORD":
        return "Incorrect password.";
      case "INTERNAL-ERROR":
        return "User with this email doesn't exist.";
      case "USER-DISABLED":
        return "User with this email has been disabled.";
      case "TOO-MANY-REQUESTS":
        return "Servers are busy, please try again later.";
      case "OPERATION-NOT-ALLOWED":
        return "Signing in with Email and Password is not enabled.";
      default:
        return "An undefined error happened.";
    }
  }
}

Future<String> register(
    String email, String password, String matchPassword) async {
  if (password != matchPassword) {
    return 'Your passwords do not match';
  }

  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return '';
  } on FirebaseAuthException catch (e) {
    print('caught an error: ' + e.code.toUpperCase());
    switch (e.code.toUpperCase()) {
      case "WEAK-PASSWORD":
        return 'The password provided is too weak.';
      case "EMAIL-ALREADY-IN-USE":
        return 'An account already exists for that email.';
      default:
        return "An undefined error happened.";
    }
  }
}
