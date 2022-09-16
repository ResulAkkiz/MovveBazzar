import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/model/movier.dart';
import 'package:flutter_application_1/core/views/home_page_view.dart';
import 'package:flutter_application_1/core/views/signin_page_view.dart';
import 'package:provider/provider.dart';

typedef MovierSnapshot = AsyncSnapshot<Movier?>;

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key, required this.movierSnapshot});
  final MovierSnapshot movierSnapshot;
  @override
  Widget build(BuildContext context) {
    var movier = Provider.of<Movier?>(context);
    if (movier != null) {
      debugPrint('movier dolu');
    } else {
      debugPrint('movier boş');
    }

    // final userData = snapshot.data;

    if (movierSnapshot.connectionState == ConnectionState.active) {
      return movierSnapshot.hasData
          ? const HomePageView()
          : const SigninPageView();
    } else {
      return const ErrorPage();
    }
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
