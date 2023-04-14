import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../login/widgets/battery.dart';
import 'status_bar_controller.dart';
import 'volume_widget.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Row(
        children: [
          Transform.rotate(
            angle: math.pi / 2,
            child: const Icon(
              Icons.chevron_left,
              size: AppStyle.iconSizeSmall + 10,
              color: AppStyle.dark,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          StreamBuilder(
              stream: StatusBarController.wifiStream(),
              builder: (ctx, s) {
                if (s.data == null) {
                  return const Icon(
                    Icons.wifi_off,
                    size: AppStyle.iconSizeSmall,
                    color: AppStyle.dark,
                  );
                } else {
                  return const Icon(
                    Icons.wifi,
                    size: AppStyle.iconSizeSmall,
                    color: AppStyle.dark,
                  );
                }
              }),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 40,
            height: 20,
            child: VolumnWidget(
              volumn: context.watch<StatusBarController>().volume,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          StreamBuilder(
              stream: StatusBarController.batteryStream(),
              builder: (ctx, s) {
                return BatteryWidget(
                  battery: s.data ?? 50,
                  state: context.watch<StatusBarController>().batteryState,
                  showBattery: false,
                  color: AppStyle.dark,
                  size: AppStyle.iconSizeSmall,
                );
              }),
          const Expanded(
            child: SizedBox(),
          ),
          StreamBuilder(
              stream: StatusBarController.timeStream(),
              builder: (c, s) {
                if (s.data == null) {
                  return const CircularProgressIndicator();
                }
                var minute = "";
                if (s.data!.minute < 10) {
                  minute = "0${s.data!.minute}";
                } else {
                  minute = s.data!.minute.toString();
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${s.data!.hour}:$minute",
                      style:
                          const TextStyle(color: AppStyle.dark, fontSize: 14),
                    ),
                    Text(
                      "${s.data!.year}/${s.data!.month}/${s.data!.day}",
                      style:
                          const TextStyle(color: AppStyle.dark, fontSize: 14),
                    ),
                  ],
                );
              }),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
