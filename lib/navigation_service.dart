import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService instance = NavigationService._instance();

  factory NavigationService() => instance;

  NavigationService._instance();

  GlobalKey<NavigatorState> navigationKey = GlobalKey();
  RouteObserver<Route> routeObserver = RouteObserver();
}
