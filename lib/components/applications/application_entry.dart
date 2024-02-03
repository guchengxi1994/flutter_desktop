import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import 'application_details.dart';

class ApplicationEntry extends StatelessWidget {
  const ApplicationEntry(
      {super.key,
      required this.details,
      required this.onDoubleClick,
      this.onSecondaryTapUp});
  final VoidCallback onDoubleClick;
  final Function(TapUpDetails)? onSecondaryTapUp;
  final ApplicationDetails details;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        onDoubleClick();
      },
      onSecondaryTapUp: (details) {
        if (onSecondaryTapUp == null) {
          return;
        }
        onSecondaryTapUp!(details);
      },
      // ignore: sized_box_for_whitespace
      child: JustTheTooltip(
          offset: -20,
          content: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(8),
            child: Text(details.name ?? details.openWith),
          ),
          tailBuilder: (point1, point2, point3) {
            return Path()
              ..moveTo(point1.dx, point1.dy)
              ..lineTo(point3.dx, point3.dy)
              ..close();
          },
          preferredDirection: AxisDirection.right,
          child: SizedBox(
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
                Text(
                  details.name ?? details.openWith,
                  style: TextStyle(color: details.nameColor),
                  overflow: TextOverflow.ellipsis,
                )
                // Tooltip(
                //   // margin: const EdgeInsets.only(top: 20),
                //   message: details.name ?? details.openWith,
                //   child: Text(
                //     details.name ?? details.openWith,
                //     style: TextStyle(color: details.nameColor),
                //     overflow: TextOverflow.ellipsis,
                //   ),
                // )
              ],
            ),
          )),
    );
  }
}
