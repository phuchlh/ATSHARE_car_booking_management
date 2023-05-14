import 'package:flutter/material.dart';

class Global {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? useContext() {
    return navigatorKey.currentContext;
  }

  static NavigatorState? useCurrentState() {
    return navigatorKey.currentState;
  }
}
