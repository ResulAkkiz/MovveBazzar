import 'package:flutter_application_1/core/model/movier.dart';

abstract class AuthBase {
  Future<Movier?> currentMovier();
  Future<Movier?> signupMovier(String email, String password);
  Future<Movier?> signinMovier(String email, String password);
  Future<void> updateEmail(String email);
  Future<Movier?> googlesignupMovier();
  Future<bool?> signOut();
}
