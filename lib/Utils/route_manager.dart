import 'package:flutter/material.dart';
import 'package:isidore_task/Screens/home_view.dart';
import 'package:isidore_task/Screens/sign_up_success.dart';
import 'package:isidore_task/Screens/sign_up_view.dart';
import '../Screens/login_view.dart';
import '../Screens/splash_view.dart';
class Routes {
  static const String splashRoute = "/";
  static const String homeRoute = "/dashboard";
  static const String loginRoute = "/login";
  static const String signupRoute = "/signup";
  static const String signupSuccessRoute = "/signupSuccess";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (context) {
          return const HomeView();
        }
        );
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (context) {
          return const LoginView();
        }
        );
      case Routes.signupRoute:
        return MaterialPageRoute(builder: (context) {
          return const SignUpView();
        }
        );
      case Routes.signupSuccessRoute:
        return MaterialPageRoute(builder: (context) {
          return const SignUpSuccessView();
        }
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text("No route found"),
          ),
          body: const Center(child: Text("No route found")),
        ));
  }
}
