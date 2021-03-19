import 'package:buzzoole/presentation/login_screen.dart';
import 'package:flutter/material.dart';

class BuzzooleRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<dynamic, dynamic> _args = settings.arguments;
    switch (settings.name) {
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
    }
  }
}
