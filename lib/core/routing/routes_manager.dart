// Define route names as constants for better manageability
import 'package:accurate_task/core/Di/di.dart';
import 'package:accurate_task/features/auth/login/presentation/login_view.dart';
import 'package:accurate_task/features/create_pickup/presentation/create_pickup_view.dart';
import 'package:accurate_task/features/create_request/presentation/create_request_view.dart';
import 'package:accurate_task/features/lobby/presentation/lobby_view.dart';
import 'package:accurate_task/features/pickup/presentation/pickup_view.dart';
import 'package:accurate_task/features/splash/splashScreen.dart';
import 'package:accurate_task/features/update_request/presentation/update_request_model.dart';
import 'package:accurate_task/features/update_request/presentation/update_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String login = '/login';
  static const String pickup = '/pickup';
  static const String lobby = '/lobby';
  static const String createPickup = '/createPickup';
  static const String createRequest = '/createRequest';
  static const String updateRequest = '/updateRequest';
  static const String splash = '/';
}

// Route manager to handle navigation
class RouteManager {
  static Route<String> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.updateRequest:
        initUpdateModel();
        return MaterialPageRoute(
            builder: (_) => UpdateView(
                  model: settings.arguments as UpdateRequestModel,
                ));
      case Routes.createRequest:
        initCreateRequestModule();
        return MaterialPageRoute(builder: (_) => CreateRequestView());
      case Routes.pickup:
        return MaterialPageRoute(builder: (_) => const PickupView());
      case Routes.login:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => LoginView());
      // case Routes.profile:
      //   return MaterialPageRoute(builder: (_) => signUpPresentation());
      case Routes.createPickup:
        return MaterialPageRoute(builder: (_) => CreatePickupView());
      case Routes.lobby:
        initLobbyModule();
        return MaterialPageRoute(builder: (_) => LobbyView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
