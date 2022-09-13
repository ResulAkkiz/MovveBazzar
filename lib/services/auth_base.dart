import 'package:flutter_application_1/model/movier.dart';

abstract class AuthBase {
  Future<Movier?> currentMovier();
  Future<Movier?> signupMovier(String email, String password);
  Future<Movier?> signinMovier(String email, String password);
  Future<Movier?> googlesignupMovier();
  Future<bool?> signOut();
}
