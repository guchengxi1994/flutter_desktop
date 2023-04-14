// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/screen_fit_utils.dart';
import 'package:flutter_desktop/components/taskbar/taskbar_controller.dart';
import 'package:flutter_desktop/components/taskbar/widgets/status_bar_controller.dart';
import 'package:provider/provider.dart';

import '../applications/application_on_taskbar.dart';
import 'widgets/status_bar.dart';

class Taskbar extends StatelessWidget {
  const Taskbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 219, 206, 195),
          Color.fromARGB(255, 98, 180, 235)
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      )),
      child: Row(
        children: [
          const Expanded(child: SizedBox()),
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset("assets/images/appicons/system.png"),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
            width: 150.w(MediaQuery.of(context).size.width),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: AppStyle.light2,
                borderRadius: BorderRadius.circular(150)),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.search,
                color: AppStyle.dark,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * AppStyle.taskbarFactor,
            child: _buildTaskbarApp(context),
          ),
          const Expanded(child: SizedBox()),
          ChangeNotifierProvider(
            create: (_) => StatusBarController()..init(),
            child: const StatusBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskbarApp(BuildContext ctx) {
    final l = ctx.watch<TaskbarController>().displayedApplications;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: l
          .map((e) => ApplicationOnTaskbar(
                details: e,
                currentAppCount: l.length,
              ) as Widget)
          .toList(),
    );
  }
}
