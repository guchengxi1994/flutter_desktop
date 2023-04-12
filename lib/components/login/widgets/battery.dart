import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_desktop/components/app_style.dart';

class BatteryWidget extends StatelessWidget {
  const BatteryWidget(
      {super.key,
      required this.battery,
      required this.state,
      this.showBattery = true});
  final BatteryState state;
  final int battery;
  final bool showBattery;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _batteryIcon(state),
        if (showBattery)
          const SizedBox(
            width: 10,
          ),
        if (showBattery)
          Text(
            battery.toString(),
            style: TextStyle(color: AppStyle.light2, fontSize: 20),
          )
      ],
    );
  }

  Widget _batteryIcon(BatteryState state) {
    switch (state) {
      case BatteryState.charging:
        return Transform.rotate(
          angle: math.pi / 2,
          child: Icon(
            Icons.battery_charging_full,
            color: AppStyle.light2,
            size: AppStyle.iconSize,
          ),
        );
      case BatteryState.full:
        return Transform.rotate(
          angle: math.pi / 2,
          child: Icon(
            Icons.battery_full,
            color: AppStyle.light2,
            size: AppStyle.iconSize,
          ),
        );
      case BatteryState.discharging:
        return Transform.rotate(
          angle: math.pi / 2,
          child: Icon(
            Icons.battery_4_bar,
            color: AppStyle.light2,
            size: AppStyle.iconSize,
          ),
        );
      default:
        return Transform.rotate(
          angle: math.pi / 2,
          child: Icon(
            Icons.battery_alert,
            color: AppStyle.light2,
            size: AppStyle.iconSize,
          ),
        );
    }
  }
}
