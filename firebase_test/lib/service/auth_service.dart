import 'package:firebase_auth/firebase_auth.dart';

import 'database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future registerUserWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        await DatabaseService(user.uid).saveUserData(email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  bool isLoggedIn() {
    if (firebaseAuth.currentUser?.uid == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
