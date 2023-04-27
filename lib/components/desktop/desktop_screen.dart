// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart';
import 'package:flutter_desktop/components/applications/_system_applications/system_application_builder.dart';
import 'package:flutter_desktop/components/applications/application_controller.dart';
import 'package:flutter_desktop/components/context_menu/desktop_context_menu.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:flutter_desktop/components/dialogs/dialog_manager.dart';
import 'package:flutter_desktop/components/notifications/notification_builder.dart';
import 'package:flutter_desktop/components/routers.dart';
import 'package:flutter_desktop/components/shortcuts/shortcut_builder.dart';
import 'package:flutter_desktop/components/shortcuts/widgets/key_widget.dart';
import 'package:flutter_desktop/components/taskbar/tray.dart';
import 'package:flutter_desktop/components/window_shortcut_types.dart';
import 'package:flutter_desktop/platform/operation_logger.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import '../shortcuts/shortcut_controller.dart';
import '../taskbar/taskbar.dart';

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({super.key});

  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen>
    with
        OperationLoggerMixin,
        WindowListener,
        DesktopContextMenuMixin,
        AutomaticKeepAliveClientMixin {
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
    if (mounted) {
      bool isPreventClose = await windowManager.isPreventClose();
      if (isPreventClose) {
        DialogManager.showShutdownDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l = context.watch<DesktopController>().l;
    return Scaffold(
      key: Routers.desktopKey,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: context.select<DesktopController, bool>(
                  (value) => value.applications.isEmpty)
              ? context
                  .watch<ShortcutPreviewController>()
                  .events
                  .map((e) => Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: KeyWidget(keylabel: e.logicalKey.keyLabel),
                      ))
                  .toList()
              : [],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ShortcutBuilder(
        builder: (ctx) {
          return GestureDetector(
              onSecondaryTapUp: (details) {
                showContextMenu(details.globalPosition, context);
              },
              onTapUp: (details) {
                ctx.read<ApplicationController>().changeTrayVisible(b: false);
                dismiss();
              },
              child: Container(
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
                              SystemApplicationBuilder.build(
                                  ctx, recycleDetails),
                              SystemApplicationBuilder.build(
                                  ctx, appManagementDetails),
                              SystemApplicationBuilder.build(
                                  ctx, audioPlayerDetails),
                              SystemApplicationBuilder.build(
                                  ctx, videoPlayerDetails),
                              SystemApplicationBuilder.build(
                                  ctx, editorDetails),
                              SystemApplicationBuilder.build(
                                  ctx, browserDetails),
                              SystemApplicationBuilder.build(
                                  ctx, gameCenterDetails),
                              ...l.map((e) {
                                return e.map(file: (f) {
                                  switch (f.field0.openWith) {
                                    case SystemConfig.sEditor:
                                      return SystemApplicationBuilder
                                          .txtAppBuild(ctx, f.field0.realPath,
                                              f.field0.virtualPath);

                                    default:
                                      return Container();
                                  }
                                }, folder: (f) {
                                  return Container();
                                });
                              }).toList()
                            ],
                          ),
                        )),
                        const Taskbar()
                      ],
                    ),
                    NotificationBuilder(),
                    Visibility(
                        visible: ctx.select<ApplicationController, bool>(
                            (value) => value.trayVisible),
                        child: const Tray()),
                    ...context.watch<DesktopController>().applications
                  ],
                ),
              ));
        },
        type: WindowShortcutTypes.desktop,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
