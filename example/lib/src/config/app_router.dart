import 'package:example/src/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) =>
      switch (settings.name) {
        HomeScreen.routeName => HomeScreen.route(),
        NumericExampleScreen.routeName => NumericExampleScreen.route(),
        TextExampleScreen.routeName => TextExampleScreen.route(),
        TimeExampleScreen.routeName => TimeExampleScreen.route(),
        _ => _errorRoute(settings.name),
      };

  static Route _errorRoute(String? route) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          titleTextStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.red,
          title: const Text('Error'),
        ),
        body: Center(
          child: Text('Something went wrong with this route: $route!'),
        ),
      ),
    );
  }
}
