// Define route names as constants for better manageability
import 'package:accurate_task/core/Di/di.dart';
import 'package:accurate_task/features/auth/login/presentation/login_view.dart';
import 'package:accurate_task/features/pickup/pickup_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String login = '/';
  static const String pickup = '/pickup';
  static const String looby = '/looby';
}

// Route manager to handle navigation
class RouteManager {
  static Route<String> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.pickup:
        return MaterialPageRoute(builder: (_) => const PickupView());
      case Routes.login:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => LoginView());
      // case Routes.profile:
      //   return MaterialPageRoute(builder: (_) => signUpPresentation());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
