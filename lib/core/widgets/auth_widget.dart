import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/model/movier.dart';
import 'package:flutter_application_1/core/views/home_page_view.dart';
import 'package:flutter_application_1/core/views/signin_page_view.dart';
import 'package:provider/provider.dart';

typedef MovierSnapshot = AsyncSnapshot<Movier?>;

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final MovierSnapshot snapshot = Provider.of<MovierSnapshot>(context);
    // final userData = snapshot.data;

    if (snapshot.connectionState == ConnectionState.active) {
      return snapshot.hasData ? const HomePageView() : const SigninPageView();
    }
    return const ErrorPage();
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hata var'),
      ),
    );
  }
}
