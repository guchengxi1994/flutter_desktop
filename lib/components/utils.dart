import 'dart:io';

import 'package:flutter/material.dart';

class DevUtils {
  static Directory get executableDir =>
      File(Platform.resolvedExecutable).parent;
}

class PageNavigateController {
  static PageController controller = PageController();
  static navigateTo(int index) {
    controller.jumpToPage(index);
  }
}

String durationToMinuts(Duration d) {
  if (d.inSeconds == 0) {
    return "00:00";
  } else {
    final m = d.inMinutes;
    final s = d.inSeconds - m * 60;

    final String ms;
    if (m < 10) {
      ms = "0$m";
    } else {
      ms = m.toString();
    }

    final String ss;
    if (s < 10) {
      ss = "0$s";
    } else {
      ss = s.toString();
    }

    return "$ms:$ss";
  }
}
