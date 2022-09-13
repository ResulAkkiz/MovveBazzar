import 'package:flutter_application_1/model/movier.dart';

abstract class DbBase {
  Future<bool> saveMovier(Movier movier);
  Future<Movier> getMovier(String movierID);
}
