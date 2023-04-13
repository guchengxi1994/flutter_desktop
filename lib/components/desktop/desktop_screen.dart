import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/application.dart';
import 'package:flutter_desktop/components/applications/application_controller.dart';
import 'package:flutter_desktop/components/applications/application_details.dart';
import 'package:flutter_desktop/components/desktop/desktop_controller.dart';
import 'package:flutter_desktop/components/shortcuts/shortcut_builder.dart';
import 'package:flutter_desktop/components/window_shortcut_types.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
    return Scaffold(
      body: ShortcutBuilder(
          builder: (ctx) {
            return Container(
              // color: AppStyle.light2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/desktop.jpg"),
                      fit: BoxFit.fill)),
              child: Stack(
                children: context.watch<DesktopController>().applications,
              ),
            );
          },
          type: WindowShortcutTypes.desktop),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            final uuid = const Uuid().v1();
            final c = Application(
                uuid: uuid,
                name: '测试',
                child: const SizedBox(
                  child: Text(
                      "aaaaaaaaaaaaaaaaaaaaaaaaaaaa\bbbbbbbbbbbbbbbbbbbbbb"),
                ));
            final ad = ApplicationDetails(uuid: uuid, name: '测试');

            context.read<ApplicationController>().addDetail(ad);
            context.read<DesktopController>().addApplication(c);
          },
          child: const Text("Add overlay")),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
