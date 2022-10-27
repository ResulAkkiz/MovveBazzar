import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/model/bookmark_model.dart';
import 'package:flutter_application_1/model/movier.dart';
import 'package:flutter_application_1/model/type_definitions.dart';
import 'package:flutter_application_1/services/db_base.dart';

class FirebaseDbService implements DbBase {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
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

  @override
  Future<bool> saveBookMark(BookMark media) async {
    Map<String, dynamic> mediaMap = media.toMap();
    await firestore
        .collection('bookmarks')
        .doc(firebaseAuth.currentUser?.uid)
        .set({media.mediaID.toString(): mediaMap}, SetOptions(merge: true));
    return true;
  }

  @override
  Future<List<BookMark>> getBookMarks(String movierID) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('bookmarks').doc(movierID).get();
    Map<String, dynamic>? bookmarkMap = snapshot.data();
    List<BookMark> bookmarkList = [];
    if (bookmarkMap != null) {
      for (var element in bookmarkMap.values) {
        bookmarkList.add(BookMark.fromMap(element));
      }
    }

    return bookmarkList;
  }

  @override
  Future<bool> deleteBookmark(String movierID, Id mediaID) async {
    firestore
        .collection('bookmarks')
        .doc(movierID)
        .update({mediaID.toString(): FieldValue.delete()});

    return true;
  }
}
