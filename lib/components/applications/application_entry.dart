import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';

import 'application_details.dart';

class ApplicationEntry extends StatelessWidget {
  const ApplicationEntry(
      {super.key, required this.details, required this.onDoubleClick});
  final VoidCallback onDoubleClick;
  final ApplicationDetails details;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        onDoubleClick();
      },
      onSecondaryTapUp: (details) {
        debugPrint("右键点击事件");
      },
      // ignore: sized_box_for_whitespace
      child: Container(
        width: AppStyle.appEntryWidgetSize,
        height: AppStyle.appEntryWidgetSize,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: AppStyle.appEntryIconSize,
              height: AppStyle.appEntryIconSize,
              child: details.icon,
            ),
            Tooltip(
              // margin: const EdgeInsets.only(top: 20),
              message: details.name,
              child: Text(
                details.name ?? details.openWith,
                style: const TextStyle(color: AppStyle.light2),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
