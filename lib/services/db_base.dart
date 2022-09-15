import 'package:flutter_application_1/core/model/movier.dart';

abstract class DbBase {
  Future<bool> saveMovier(Movier movier);
  Future<Movier> getMovier(String movierID);
}
