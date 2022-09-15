import 'package:flutter_application_1/core/model/movier.dart';

abstract class IAuth {
  Future<Movier> createUserWithEmailandPassword(String email, String password);
  Future<Movier> signinWithEmailandPassword(String email, String password);
  Future<bool> signOut();
  Stream<Movier?> get onAuthStateChange;
}
