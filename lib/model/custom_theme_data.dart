import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/custom_theme.dart';

class CustomThemeDataModal extends ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get getThemeData => _themeData;

  void setThemeData(ThemeData data) {
    _themeData = data;
    notifyListeners();
  }
}
