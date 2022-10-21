import 'package:flutter_application_1/model/bookmark_model.dart';
import 'package:flutter_application_1/model/movier.dart';

abstract class DbBase {
  Future<bool> saveMovier(Movier movier);
  Future<bool> updateMovier(Movier movier);
  Future<Movier?> getMovierByID(String movierID);
  Future<bool> saveBookMark(BookMark bookmarkMedia);
  Future<List<BookMark>> getBookMarks(String movierID);
  Future<bool> deleteBookmark(String movierID, int mediaID);
}
