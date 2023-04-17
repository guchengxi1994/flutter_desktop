// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  static const Color dark = Color.fromARGB(255, 47, 42, 42);
  static const Color light = Color.fromARGB(255, 213, 190, 190);
  static const Color light2 = Colors.white;
  static const Color grey = Color.fromARGB(255, 200, 195, 195);
  static const Color passwordInputBackground = Color.fromARGB(255, 47, 42, 42);
  static const double iconSize = 24;
  static const double iconSizeSmall = 20;
  static const double appEntryWidgetSize = 70;
  static const double appEntryIconSize = 50;
  static const double appbarIconSize = 18;
  static const double taskbarFactor = 0.4;
}

class SystemConfig {
  SystemConfig._();
  static const String sMyComputer = "我的电脑";
  static const String sRecycle = "回收站";
  static const String sAppManagement = "管理";
  static const String sAudioPlayer = "音乐播放器";
}
