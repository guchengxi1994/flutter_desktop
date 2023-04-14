// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart';
import 'package:flutter_desktop/components/applications/_system_applications/system_application_builder.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:flutter_desktop/components/shortcuts/shortcut_builder.dart';
import 'package:flutter_desktop/components/window_shortcut_types.dart';
import 'package:flutter_desktop/platform/operation_logger.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import '../taskbar/taskbar.dart';

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({super.key});

  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen>
    with AutomaticKeepAliveClientMixin, OperationLoggerMixin, WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    _init();
    super.initState();
  }

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Are you sure you want to close this window?'),
            actions: [
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () async {
                  await log(content: "关机");
                  Navigator.of(context).pop();
                  await windowManager.destroy();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ShortcutBuilder(
        builder: (ctx) {
          return Container(
            // color: AppStyle.light2,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/desktop.jpg"),
                    fit: BoxFit.fill)),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                        child: SizedBox.expand(
                      child: Wrap(
                        direction: Axis.vertical,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          SystemApplicationBuilder.build(
                              ctx, myComputerDetails),
                          SystemApplicationBuilder.build(ctx, recycleDetails),
                          SystemApplicationBuilder.build(
                              ctx, appManagementDetails),
                        ],
                      ),
                    )),
                    const Taskbar()
                  ],
                ),
                ...context.watch<DesktopController>().applications
              ],
            ),
          );
        },
        type: WindowShortcutTypes.desktop);
  }

  @override
  bool get wantKeepAlive => true;
}
