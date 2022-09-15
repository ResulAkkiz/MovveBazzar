import 'package:flutter_application_1/core/model/movier.dart';
import 'package:flutter_application_1/core/service/firebase_service.dart';
import 'package:flutter_application_1/core/service/iauth_service.dart';

class UserViewModel extends IAuth {
  AuthService authService = AuthService();

  @override
  Future<Movier> createUserWithEmailandPassword(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Stream<Movier?> get onAuthStateChange => throw UnimplementedError();

  @override
  Future<bool> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<Movier> signinWithEmailandPassword(String email, String password) {
    throw UnimplementedError();
  }
}
