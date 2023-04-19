import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/applications/application_controller.dart';
import 'package:flutter_desktop/components/applications/application_on_tray.dart';
import 'package:provider/provider.dart';

class Tray extends StatelessWidget {
  const Tray({super.key});

  @override
  Widget build(BuildContext context) {
    final details = context.watch<ApplicationController>().details;
    double height = details.length ~/ 5 * 25;
    if (height < 50) {
      height = 50;
    }
    return Positioned(
        bottom: 60,
        right: 100,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: AppStyle.light2, borderRadius: BorderRadius.circular(15)),
          width: 200,
          // height: 200,
          height: height,
          child: Wrap(
            children:
                details.map((e) => ApplicationOnTray(details: e)).toList(),
          ),
        ));
  }
}
