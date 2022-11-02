import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app_constants/custom_theme.dart';
import 'package:flutter_application_1/model/custom_theme_data.dart';
import 'package:flutter_application_1/pages/landing_screen.dart';
import 'package:flutter_application_1/viewmodel/bookmark_view_model.dart';
import 'package:flutter_application_1/viewmodel/media_view_model.dart';
import 'package:flutter_application_1/viewmodel/movier_view_model.dart';
import 'package:provider/provider.dart';

ThemeData _theme = lightTheme;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.dark.statusBarColor ?? const Color(0xFF11111A),
      systemNavigationBarIconBrightness: _theme.brightness,
      statusBarBrightness: _theme.brightness,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) {
          return CustomThemeDataModal();
        },
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) {
          return MovierViewModel();
        },
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) {
          return MediaViewModel();
        },
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) {
          return BookmarkViewModel();
        },
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _theme,
      title: 'Movve',
      home: const LandingScreen(),
    );
  }
}
