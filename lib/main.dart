import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/routers.dart';
import 'package:flutter_desktop/components/shortcuts/shortcut_controller.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ShortcutController.init();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      title: "桌面",
      size: Size(1280, 720),
      minimumSize: Size(1280, 720),
      center: false,
      // backgroundColor: Colors.transparent,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '桌面',
      theme: ThemeData(fontFamily: "思源"),
      routes: Routers.routers,
      initialRoute: Routers.loadingScreen,
      navigatorKey: Routers.navigatorKey,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
    );
  }
}
