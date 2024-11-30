import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mr_chicken_x/pages/getstarted/index.dart';
import 'package:mr_chicken_x/pages/home/index.dart';
import 'package:mr_chicken_x/pages/login/index.dart';
import 'package:mr_chicken_x/pages/splash/index.dart';

class NAVIGATION {
  static const String home = '/home';
  static const String login = '/login';
  static const String getStart = "/getStarted";
  static const String splash = "/";
}

List<Map<String, dynamic>> stackNavigation = [
  {
    "name": NAVIGATION.home,
    "component": (BuildContext context, GoRouterState state) =>
        const MyHomePage(),
    "options": {"path": NAVIGATION.home}
  },
  {
    "name": NAVIGATION.login,
    "component": (BuildContext context, GoRouterState state) =>
        const LoginPage(),
    "options": {"path": NAVIGATION.login}
  },
  {
    "name": NAVIGATION.getStart,
    "component": (BuildContext context, GoRouterState state) =>
    const GetStartedScreen(),
    "options": {"path": NAVIGATION.getStart}
  },
  {
    "name": NAVIGATION.splash,
    "component": (BuildContext context, GoRouterState state) =>
        const SplashScreen(),
    "options": {"path": NAVIGATION.splash}
  }
];
