import 'package:flutter/material.dart';
import 'future_builder.dart';
import 'loading/loading_screen.dart' deferred as loading;
import 'login/login_screen.dart' deferred as login;
import 'desktop/desktop_screen.dart' deferred as desktop;

class Routers {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static String loadingScreen = "/loadingScreen";
  static String loginScreen = "/loginScreen";
  static String desktopScreen = "/desktopScreen";

  static Map<String, WidgetBuilder> routers = {
    loadingScreen: (context) => FutureLoaderWidget(
        builder: (context) => loading.LoadingScreen(),
        loadWidgetFuture: loading.loadLibrary()),
    loginScreen: (context) => FutureLoaderWidget(
        builder: (context) => login.LoginScreen(),
        loadWidgetFuture: login.loadLibrary()),
    desktopScreen: (context) => FutureLoaderWidget(
        builder: (context) => desktop.DesktopScreen(),
        loadWidgetFuture: desktop.loadLibrary()),
  };
}
