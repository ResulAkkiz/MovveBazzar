// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/movier.dart';
import 'package:flutter_application_1/services/auth_base.dart';
import 'package:flutter_application_1/services/db_base.dart';
import 'package:flutter_application_1/services/firabase_storage_service.dart';
import 'package:flutter_application_1/services/firebase_auth_service.dart';
import 'package:flutter_application_1/services/firebase_db_service.dart';

class MovierViewModel with ChangeNotifier implements AuthBase {
  Movier? _movier;
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  FirebaseDbService firebaseDbService = FirebaseDbService();
  FirebaseStorageService firebaseStorageService = FirebaseStorageService();

  Movier? get movier => _movier;

  MovierViewModel() {
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
    _movier = await firebaseAuthService.signupMovier(email, password);
    notifyListeners();
    if (_movier != null) {
      firebaseDbService.saveMovier(_movier!);
    }

    return _movier;
  }

  @override
  Future<Movier?> googlesignupMovier() async {
    _movier = await firebaseAuthService.googlesignupMovier();
    notifyListeners();
    return _movier;
  }

  @override
  Future<bool?> signOut() async {
    _movier = null;
    notifyListeners();
    return await firebaseAuthService.signOut();
  }

  @override
  Future<void> updateEmail(String email) async {
    await firebaseAuthService.updateEmail(email);
  }

  Future<bool> saveMovier(Movier movier) async {
    return await firebaseDbService.saveMovier(movier);
  }

  Future<Movier?> getMovierByID(String movierID) async {
    return await firebaseDbService.getMovierByID(movierID);
  }

  Future<bool> updateMovier(Movier movier) {
    throw UnimplementedError();
  }

  Future<String> uploadFile(String userID, String fileType, File uploadedFile) {
    return firebaseStorageService.uploadFile(userID, fileType, uploadedFile);
  }
}
