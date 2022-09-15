import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/model/movier.dart';
import 'package:flutter_application_1/core/service/iauth_service.dart';
import 'package:flutter_application_1/core/widgets/auth_widget.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<IAuth>(context);
    return StreamBuilder<Movier?>(
      builder: (context, AsyncSnapshot<Movier?> snapshot) {
        //final userData = snapshot.data;
        return Provider.value(
          value: snapshot,
          child: const AuthWidget(),
        );
      },
      stream: authService.onAuthStateChange,
    );
  }
}
