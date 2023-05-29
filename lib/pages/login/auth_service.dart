import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/toasty.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Toasty.error('${e.message}');
      return e.message;
    }
  }
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      Toasty.error("${e.message}");
      throw e;
    }
  }
}