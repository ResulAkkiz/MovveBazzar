import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/movier.dart';
import 'package:flutter_application_1/services/auth_base.dart';

class FirebaseAuthService extends AuthBase {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<Movier?> currentMovier() async {
    User? currentUser = firebaseAuth.currentUser;
    return userToMovier(currentUser);
  }

  @override
  Future<Movier?> signinMovier(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userToMovier(userCredential.user);
  }

  @override
  Future<Movier?> signupMovier(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userToMovier(userCredential.user);
  }

  Movier? userToMovier(User? user) {
    if (user != null) {
      return Movier(
          movierID: user.uid,
          movierEmail: user.email ?? '',
          movierUsername: 'movier-${user.uid}');
    } else {
      return null;
    }
  }

  @override
  Future<bool?> signOut() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint("Singout Hatası: ${e.toString()}");
      return null;
    }
  }
}
