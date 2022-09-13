// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/movier.dart';
import 'package:flutter_application_1/services/auth_base.dart';
import 'package:flutter_application_1/services/firebase_auth_service.dart';

class MovierViewModel with ChangeNotifier implements AuthBase {
  Movier? _movier;
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  Movier? get movier => _movier;

  MovierViewModel() {
    debugPrint('Constructure method tetiklendi');
    currentMovier();
  }

  @override
  Future<Movier?> currentMovier() async {
    _movier = await firebaseAuthService.currentMovier();
    notifyListeners();
    return _movier;
  }

  @override
  Future<Movier?> signinMovier(String email, String password) async {
    _movier = await firebaseAuthService.signinMovier(email, password);
    notifyListeners();
    return _movier;
  }

  @override
  Future<Movier?> signupMovier(String email, String password) async {
    debugPrint('signupMovier fonk içindeyiz');
    _movier = await firebaseAuthService.signupMovier(email, password);
    return _movier;
  }

  @override
  Future<Movier?> googlesignupMovier() async {
    _movier = await firebaseAuthService.googlesignupMovier();
    return _movier;
  }

  @override
  Future<bool?> signOut() async {
    _movier = null;
    notifyListeners();
    return await firebaseAuthService.signOut();
  }
}
