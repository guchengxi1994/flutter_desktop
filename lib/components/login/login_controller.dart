// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/routers.dart';
import 'package:flutter_desktop/components/utils.dart';
import 'package:network_info_plus/network_info_plus.dart';

class LoginController extends ChangeNotifier {
  bool showForm = false;
  static final _battery = Battery();
  static final _info = NetworkInfo();
  var batteryState = BatteryState.unknown;

  init() {
    _battery.onBatteryStateChanged.listen((event) {
      // debugPrint(event.toString());
      if (hasListeners) {
        batteryState = event;
        notifyListeners();
      }
    });
  }

  changeShowForm() {
    if (showForm) {
      return;
    }
    showForm = true;
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
      // debugPrint(batteryLevel.toString());
      yield batteryLevel;
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  static Stream<String?> wifiStream() async* {
    while (1 == 1) {
      try {
        final wifiName = await _info.getWifiName();
        // debugPrint(wifiName);
        yield wifiName;
      } catch (e) {
        // debugPrint(e.toString());
        yield null;
      }
      await Future.delayed(const Duration(seconds: 5));
    }
  }
}

class LoginFormController extends ChangeNotifier {
  bool passwordVisible = true;
  bool isLoading = false;

  changePasswordStatus() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  Future submit(String password) async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    notifyListeners();
    // Routers.navigatorKey.currentState!.pushNamed(Routers.desktopScreen);
    PageNavigateController.navigateTo(1);
  }
}
