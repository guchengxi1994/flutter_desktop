import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/application_details.dart';
import 'package:provider/provider.dart';

import '../app_style.dart';
import '../desktop/desktop_controller.dart';

class ApplicationOnTaskbar extends StatelessWidget {
  const ApplicationOnTaskbar(
      {super.key, required this.details, required this.currentAppCount})
      : assert(currentAppCount >= 1);
  final ApplicationDetails details;
  final int currentAppCount;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = context.select<DesktopController, bool>(
      (value) => value.applications.isEmpty
          ? false
          : value.applications.last.uuid == details.uuid,
    );
    return InkWell(
      onTap: () {
        context.read<DesktopController>().setFocusedUuid(details.uuid);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isHighlighted
                ? AppStyle.light2.withOpacity(0.75)
                : Colors.transparent),
        height: min(
            MediaQuery.of(context).size.width *
                AppStyle.taskbarFactor /
                currentAppCount,
            40),
        width: min(
            MediaQuery.of(context).size.width *
                AppStyle.taskbarFactor /
                currentAppCount,
            40),
        padding: const EdgeInsets.all(5),
        child: details.icon,
      ),
    );
  }
}
