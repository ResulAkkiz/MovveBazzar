import 'package:flutter/material.dart';
import 'package:flutter_application_1/navigation_service.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends BaseState<BasePage> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

abstract class BaseState<T extends StatefulWidget> extends State<T>
    with RouteAware {
  late final bool isRoute = ModalRoute.of(context) is Route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (isRoute) {
      NavigationService.instance.routeObserver
          .subscribe(this, ModalRoute.of(context) as Route);
    }
  }

  @override
  void dispose() {
    if (isRoute) {
      NavigationService.instance.routeObserver.unsubscribe(this);
    }

    super.dispose();
  }
}
