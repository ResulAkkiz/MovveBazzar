import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/model/bookmark_model.dart';
import 'package:flutter_application_1/services/firebase_db_service.dart';

class BookmarkViewModel extends ChangeNotifier {
  FirebaseDbService firebaseDbService = FirebaseDbService();

  List<BookMark> bookmarkList = [];

  Future<bool> saveBookMarks(BookMark media) async {
    try {
      firebaseDbService.saveBookMark(media);
      return true;
    } on Exception catch (e) {
      debugPrint('Error in saving Bookmarks : ${e.toString()}');
      return false;
    }
  }

  Future<void> getBookMarks(String movierID) async {
    try {
      bookmarkList = await firebaseDbService.getBookMarks(movierID);
      notifyListeners();
    } catch (e) {
      debugPrint('Error in saving Bookmarks : ${e.toString()}');
    }
  }
}
