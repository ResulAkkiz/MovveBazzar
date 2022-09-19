import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/movier.dart';
import 'package:flutter_application_1/services/db_base.dart';
import 'package:flutter_application_1/viewmodel/movier_view_model.dart';

class FirebaseDbService extends DbBase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<Movier?> getMovierByID(String movierID) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('users').doc(movierID).get();
    Map<String, dynamic>? movierMap = snapshot.data();
    return Movier.fromMap(movierMap!);
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

  @override
  Future<bool> updateMovier(Movier movier) {
    throw UnimplementedError();
  }
}
