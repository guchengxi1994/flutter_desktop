import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:network_info_plus/network_info_plus.dart';

class StatusBarController extends ChangeNotifier {
  static final _battery = Battery();
  static final _info = NetworkInfo();
  var batteryState = BatteryState.unknown;
  double volume = 0;

  init() async {
    volume = (await FlutterVolumeController.getVolume()) ?? 0;
    notifyListeners();
    _battery.onBatteryStateChanged.listen((event) {
      // debugPrint(event.toString());
      if (hasListeners) {
        batteryState = event;
        notifyListeners();
      }
    });

    FlutterVolumeController.addListener(
      (v) {
        // debugPrint('Volume changed: $volume');
        if (hasListeners) {
          volume = v;
          notifyListeners();
        }
      },
    );
  }

  static Stream<DateTime> timeStream() async* {
    while (1 == 1) {
      final datetime = DateTime.now();
      yield datetime;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  static Stream<int> batteryStream() async* {
    while (1 == 1) {
      var batteryLevel = await _battery.batteryLevel;
      // debugPrint(batteryLevel.toString());
      yield batteryLevel;
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  static Stream<String?> wifiStream() async* {
    while (1 == 1) {
      final wifiName = await _info.getWifiName();
      yield wifiName;
      await Future.delayed(const Duration(seconds: 5));
    }
  }
}
