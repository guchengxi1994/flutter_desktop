import 'package:flutter/material.dart';
import 'future_builder.dart';
import 'loading/loading_screen.dart' deferred as loading;
import 'desktop/desktop.dart' deferred as desktop;

class Routers {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static GlobalKey desktopKey = GlobalKey();

  static String loadingScreen = "/loadingScreen";
  static String desktopScreen = "/desktopScreen";

  static Map<String, WidgetBuilder> routers = {
    loadingScreen: (context) => FutureLoaderWidget(
        builder: (context) => loading.LoadingScreen(),
        loadWidgetFuture: loading.loadLibrary()),
    desktopScreen: (context) => FutureLoaderWidget(
        builder: (context) => desktop.Desktop(),
        loadWidgetFuture: desktop.loadLibrary()),
  };
}
