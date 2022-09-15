import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/core/model/movier.dart';
import 'package:flutter_application_1/core/service/iauth_service.dart';
import 'package:flutter_application_1/core/service/mixin_user.dart';

class AuthService with ConvertUser implements IAuth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Movier> createUserWithEmailandPassword(
      String email, String password) async {
    var tempUser = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return convertUserCredential(tempUser);
  }

  @override
  Stream<Movier?> get onAuthStateChange =>
      firebaseAuth.authStateChanges().map(convertUser);

  @override
  Future<bool> signOut() async {
    await firebaseAuth.signOut();
    return true;
  }

  @override
  Future<Movier> signinWithEmailandPassword(
      String email, String password) async {
    var tempUser = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return convertUserCredential(tempUser);
  }
}
