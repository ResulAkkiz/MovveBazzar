import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/model/movier.dart';
import 'package:flutter_application_1/core/service/iauth_service.dart';
import 'package:flutter_application_1/core/widgets/auth_widget.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<IAuth>(context, listen: false);
    final Movier? movier =
        Provider.of<MovierSnapshot>(context, listen: false).data;
    return Scaffold(
      appBar: AppBar(
        title: Text(movier?.movierEmail ?? ''),
        actions: [
          IconButton(
              onPressed: () async {
                await authService.signOut();
              },
              icon: const Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
