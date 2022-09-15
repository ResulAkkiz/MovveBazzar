import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/core/model/movier.dart';
import 'package:flutter_application_1/services/db_base.dart';

class FirebaseDbService extends DbBase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<Movier> getMovier(String movierID) {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveMovier(Movier movier) async {
    Map<String, dynamic> movierMap = movier.toMap();
    await firestore
        .collection('users')
        .doc(movier.movierID.toString())
        .set(movierMap);
    return true;
  }
}
