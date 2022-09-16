import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/model/movier.dart';
import 'package:flutter_application_1/core/service/firebase_service.dart';
import 'package:flutter_application_1/core/service/iauth_service.dart';
import 'package:flutter_application_1/core/widgets/auth_widget.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<IAuth>(context, listen: false);
    return StreamBuilder<Movier?>(
      stream: authService.onAuthStateChange,
      builder: (context, AsyncSnapshot<Movier?> snapshot) {
        final movier = snapshot.data;
        return Provider.value(
          value: movier,
          child: AuthWidget(
            movierSnapshot: snapshot,
          ),
        );
      },
    );
  }
}
