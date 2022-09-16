import 'package:flutter_application_1/core/model/movier.dart';
import 'package:flutter_application_1/core/service/firebase_service.dart';
import 'package:flutter_application_1/core/service/iauth_service.dart';

class UserViewModel extends IAuth {
  AuthService authService = AuthService();

  @override
  Future<Movier> createUserWithEmailandPassword(
      String email, String password) async {
    return await authService.createUserWithEmailandPassword(email, password);
  }

  @override
  Stream<Movier?> get onAuthStateChange {
    return authService.onAuthStateChange;
  }

  @override
  Future<bool> signOut() async {
    return await authService.signOut();
  }

  @override
  Future<Movier> signinWithEmailandPassword(
      String email, String password) async {
    return await authService.signinWithEmailandPassword(email, password);
  }
}
