import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_screen.dart';
import 'package:flutter_application_1/pages/login_screen.dart';
import 'package:flutter_application_1/pages/signup_screen.dart';
import 'package:flutter_application_1/viewmodel/movier_view_model.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MovierViewModel movierViewModel = Provider.of<MovierViewModel>(context);
    debugPrint('Landing page içerisindeyiz');
    debugPrint(movierViewModel.movier?.movierEmail);

    if (movierViewModel.movier == null) {
      return const LoginScreen();
    } else {
      debugPrint('Go to homepage');
      return const HomePage();
    }
  }
}
