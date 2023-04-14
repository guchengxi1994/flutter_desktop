import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_desktop/components/app_style.dart';

class BatteryWidget extends StatelessWidget {
  const BatteryWidget(
      {super.key,
      required this.battery,
      required this.state,
      this.showBattery = true,
      this.color = AppStyle.light2,
      this.size = AppStyle.iconSize});
  final BatteryState state;
  final int battery;
  final bool showBattery;
  final Color color;
  final double size;

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
            style: TextStyle(color: color, fontSize: 20),
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
            color: color,
            size: size,
          ),
        );
      case BatteryState.full:
        return Transform.rotate(
          angle: math.pi / 2,
          child: Icon(
            Icons.battery_full,
            color: color,
            size: size,
          ),
        );
      case BatteryState.discharging:
        return Transform.rotate(
          angle: math.pi / 2,
          child: Icon(
            Icons.battery_4_bar,
            color: color,
            size: size,
          ),
        );
      default:
        return Transform.rotate(
          angle: math.pi / 2,
          child: Icon(
            Icons.battery_alert,
            color: color,
            size: size,
          ),
        );
    }
  }
}
