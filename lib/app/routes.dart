import 'package:flutter/material.dart';
import '../features/landing/screens/landing_screen.dart';

import '../features/auth/screens/login_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/auth/login';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const LandingScreen(),
      login: (context) => const LoginScreen(),
    };
  }
}
