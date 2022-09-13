import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/movier.dart';
import 'package:flutter_application_1/services/auth_base.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    debugPrint('Giriş işlemi başarılı :${userCredential.user!.email}');
    return userToMovier(userCredential.user);
  }

  @override
  Future<Movier?> signupMovier(String email, String password) async {
    debugPrint('user credential öncesi');
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    debugPrint('Kayıt olan email:${userCredential.user?.email.toString()}');
    return userToMovier(userCredential.user);
  }

  @override
  Future<Movier?> googlesignupMovier() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        var result = await firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
        return googleUserToMovier(result.user);
      } else {
        return null;
      }
    } else {
      return null;
    }
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

  Movier? googleUserToMovier(User? user) {
    if (user != null) {
      return Movier(
          movierID: user.uid,
          movierEmail: user.email ?? '',
          movierUsername: user.displayName ?? 'movier-${user.uid}',
          movierPhotoUrl: user.photoURL);
    } else {
      return null;
    }
  }

  @override
  Future<bool?> signOut() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint("Singout Hatası: ${e.toString()}");
      return null;
    }
  }

  @override
  Future<void> updateEmail(String email) async {
    User? currentUser = firebaseAuth.currentUser;
    await currentUser?.updateEmail(email);
  }
}
