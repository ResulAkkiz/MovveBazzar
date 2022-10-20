import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';

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

Future<dynamic> buildAlertDialog(BuildContext context, bool isSuccess) {
  return showDialog(
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: const [
            Text('Succesfully '),
            Icon(Icons.check_circle_outline_rounded)
          ],
        ),
        content: Text(
          'It is added to Bookmark List ',
          style: TextStyles.robotoBold18Style,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
    },
    context: context,
  );
}
