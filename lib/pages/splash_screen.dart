import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          curve: Curves.bounceOut,
          duration: const Duration(milliseconds: 500),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Mov',
                  style: TextStyles.splashLogoStyle,
                ),
                TextSpan(
                  text: 've',
                  style: TextStyles.splashLogoStyle.copyWith(
                    color: const Color(0xFFE11A38),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
