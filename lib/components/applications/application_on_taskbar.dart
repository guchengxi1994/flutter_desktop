import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/application_details.dart';

import '../app_style.dart';

class ApplicationOnTaskbar extends StatelessWidget {
  const ApplicationOnTaskbar(
      {super.key, required this.details, required this.currentAppCount})
      : assert(currentAppCount >= 1);
  final ApplicationDetails details;
  final int currentAppCount;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
