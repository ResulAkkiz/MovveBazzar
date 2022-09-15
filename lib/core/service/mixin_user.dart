import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/core/model/movier.dart';

mixin ConvertUser {
  Movier convertUserCredential(UserCredential user) {
    return Movier(
        movierID: user.user!.uid,
        movierEmail: user.user!.email!,
        movierUsername: 'movier-${user.user!.uid}');
  }

  Movier convertUser(User? user) {
    return Movier(
        movierID: user!.uid,
        movierEmail: user.email!,
        movierUsername: 'movier-${user.uid}');
  }
}
