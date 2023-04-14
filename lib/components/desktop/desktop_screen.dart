import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart';
import 'package:flutter_desktop/components/applications/_system_applications/system_application_builder.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:flutter_desktop/components/shortcuts/shortcut_builder.dart';
import 'package:flutter_desktop/components/window_shortcut_types.dart';
import 'package:provider/provider.dart';

import '../taskbar/taskbar.dart';

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({super.key});

  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen>
    with AutomaticKeepAliveClientMixin {
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
