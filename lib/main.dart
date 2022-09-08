import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/custom_theme.dart';

import 'package:flutter_application_1/model/custom_theme_data.dart';
import 'package:flutter_application_1/pages/signup_screen.dart';

import 'package:flutter_application_1/viewmodel/movier_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
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
        theme: lightTheme,
        //Provider.of<CustomThemeDataModal>(context).getThemeData,
        title: 'Material App',
        home: SignupScreen());
  }
}
