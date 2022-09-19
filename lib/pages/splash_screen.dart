import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';

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
          RichText(
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
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
