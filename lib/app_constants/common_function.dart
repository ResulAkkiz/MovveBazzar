import 'dart:math';

import 'package:flutter/cupertino.dart';

String generateRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

String getImage({required String? path, required String size}) {
  return path != null
      ? 'https://image.tmdb.org/t/p/$size$path'
      : 'https://cdn-icons-png.flaticon.com/512/3286/3286282.png';
}
