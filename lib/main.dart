// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/routers.dart';
import 'package:flutter_desktop/components/shortcuts/shortcut_controller.dart';
import 'package:flutter_desktop/components/sysinfo/sysinfo_controller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'platform/system_commands.dart';
import 'src/rust/frb_generated.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  ShortcutController.init();
  SystemCommands.init();
  await RustLib.init();

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

class CustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SysInfoController()),
      ],
      builder: (ctx, child) {
        ctx.read<SysInfoController>().init();

        return MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            AppFlowyEditorLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: '桌面',
          theme: ThemeData(fontFamily: "思源", useMaterial3: true),
          routes: Routers.routers,
          scrollBehavior: CustomScrollBehavior(),
          initialRoute: Routers.loadingScreen,
          navigatorKey: Routers.navigatorKey,
        );
      },
    );
  }
}
