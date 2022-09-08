// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_application_1/model/movier.dart';
import 'package:flutter_application_1/services/firebase_auth_service.dart';

class MovierViewModel with ChangeNotifier {
  Movier? _movier;

  FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  Movier? get movier {
    return _movier;
  }

  MovierViewModel() {
    currentMovier();
    notifyListeners();
  }

  Future<Movier?> currentMovier() async {
    _movier = await firebaseAuthService.currentMovier();
    return _movier;
  }

  Future<Movier?> signinMovier(String email, String password) async {
    return firebaseAuthService.signinMovier(email, password);
  }

  Future<Movier?> signupMovier(String email, String password) async {
    return firebaseAuthService.signupMovier(email, password);
  }
}
