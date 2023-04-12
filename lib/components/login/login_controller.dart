import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

class LoginController extends ChangeNotifier {
  bool showForm = false;
  static final _battery = Battery();
  static final _info = NetworkInfo();
  var batteryState = BatteryState.unknown;
  bool passwordVisible = true;

  init() {
    _battery.onBatteryStateChanged.listen((event) {
      // debugPrint(event.toString());
      batteryState = event;
      notifyListeners();
    });
  }

  changeShowForm() {
    showForm = !showForm;
    notifyListeners();
  }

  changePasswordStatus() {
    passwordVisible = !passwordVisible;
    notifyListeners();
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
      debugPrint(batteryLevel.toString());
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
