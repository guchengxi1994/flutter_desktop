import 'package:flutter/material.dart';

import '../app_style.dart';
import 'application_details.dart';

class ApplicationOnTray extends StatelessWidget {
  const ApplicationOnTray({super.key, required this.details});
  final ApplicationDetails details;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppStyle.light2.withOpacity(0.75)),
      height: 20,
      width: 20,
      child: details.icon,
    );
  }
}
