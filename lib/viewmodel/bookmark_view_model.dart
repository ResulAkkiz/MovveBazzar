import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/model/bookmark_model.dart';
import 'package:flutter_application_1/services/firebase_db_service.dart';

class BookmarkViewModel extends ChangeNotifier {
  FirebaseDbService firebaseDbService = FirebaseDbService();

  List<BookMark> bookmarkList = [];
  bool isBookmarked = false;

  Future<bool> saveBookMarks(BookMark media) async {
    try {
      isBookmarked = await firebaseDbService.saveBookMark(media);
      notifyListeners();
      return isBookmarked;
    } on Exception catch (e) {
      debugPrint('Error in saving Bookmarks : ${e.toString()}');
      return false;
    }
  }

  Future<void> searchingBookmark(int mediaID) async {
    BookMark? bookMark = bookmarkList.firstWhereOrNull(
      (BookMark element) => element.mediaID == mediaID,
    );

    isBookmarked = bookMark != null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> getBookMarks(String movierID) async {
    try {
      bookmarkList = await firebaseDbService.getBookMarks(movierID);

      notifyListeners();
    } catch (e) {
      debugPrint('Error in saving Bookmarks : ${e.toString()}');
    }
  }

  Future<bool> deleteBookmark(String movierID, int mediaID) async {
    try {
      isBookmarked = !await firebaseDbService.deleteBookmark(movierID, mediaID);
      notifyListeners();
      return isBookmarked;
    } catch (e) {
      debugPrint('Error in deleting bookmark');
      return false;
    }
  }
}
