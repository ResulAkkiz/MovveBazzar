import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/service/iauth_service.dart';

import 'package:provider/provider.dart';

class SigninPageView extends StatelessWidget {
  const SigninPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<IAuth>(context, listen: false);
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () async {
          await authService.createUserWithEmailandPassword(
              'resulakkiz1626@gmail.com', '123456');
        },
        child: const Text('Sign up'),
      )),
    );
  }
}
