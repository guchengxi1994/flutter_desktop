import 'package:flutter/material.dart';
import 'future_builder.dart';
import 'loading/loading_screen.dart' deferred as loading;
import 'login/login_screen.dart' deferred as login;

class Routers {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static String loadingScreen = "/loadingScreen";
  static String loginScreen = "/loginScreen";

  static Map<String, WidgetBuilder> routers = {
    loadingScreen: (context) => FutureLoaderWidget(
        builder: (context) => loading.LoadingScreen(),
        loadWidgetFuture: loading.loadLibrary()),
    loginScreen: (context) => FutureLoaderWidget(
        builder: (context) => login.LoginScreen(),
        loadWidgetFuture: login.loadLibrary()),
  };
}
