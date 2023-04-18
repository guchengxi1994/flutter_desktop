import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/notifications/notification_controller.dart';
import 'package:provider/provider.dart';

import '../applications/application_controller.dart';
import '../future_builder.dart';
import '../taskbar/taskbar_controller.dart';
import '../utils.dart';
import 'desktop_controller.dart';
import 'desktop_screen.dart' deferred as desktop;
import 'package:flutter_desktop/components/login/login_screen.dart'
    deferred as login;

class Desktop extends StatefulWidget {
  const Desktop({super.key});

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> with AutomaticKeepAliveClientMixin {
  List<Widget> pages = [
    FutureLoaderWidget(
        builder: (context) => login.LoginScreen(),
        loadWidgetFuture: login.loadLibrary()),
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApplicationController()),
        ChangeNotifierProvider(create: (_) => DesktopController()),
        ChangeNotifierProvider(create: (_) => TaskbarController()),
        ChangeNotifierProvider(create: (_) => NotificationController()),
      ],
      child: FutureLoaderWidget(
          builder: (context) => desktop.DesktopScreen(),
          loadWidgetFuture: desktop.loadLibrary()),
    )
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView(
      controller: PageNavigateController.controller,
      physics: const NeverScrollableScrollPhysics(),
      children: pages,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
