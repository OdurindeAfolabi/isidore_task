import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigationKey_ = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => navigationKey_;

  pop() {
    return navigationKey_.currentState!.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigationKey_.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateReplacementTo(String routeName, {dynamic arguments}) {
    return navigationKey_.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }
  Future<dynamic> pushAndRemoveUntil<T extends dynamic>(String newRoute) {
    return   navigationKey_.currentState!.pushNamedAndRemoveUntil(newRoute,  (Route<dynamic> route) => false);
  }

}
