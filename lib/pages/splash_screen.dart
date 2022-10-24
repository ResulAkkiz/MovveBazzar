import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool user = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSplashLogo(),
    );
  }

  Center _buildSplashLogo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildLogo(),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
