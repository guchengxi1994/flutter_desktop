import 'dart:io';

import 'package:flutter/material.dart';

class DevUtils {
  static Directory get executableDir =>
      File(Platform.resolvedExecutable).parent;

  static String cacheTxtPath = "${DevUtils.executableDir.path}/cache/txts/";
}

class PageNavigateController {
  static PageController controller = PageController();
  static navigateTo(int index) {
    controller.jumpToPage(index);
  }
}

class DesktopFocusNodeController {
  static FocusNode focusNode = FocusNode(debugLabel: "desktop");
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

Color combineColor(Color c0, Color c1, {double factor = 0.5}) {
  var r0 = c0.red;
  var g0 = c0.green;
  var b0 = c0.blue;

  var r1 = c1.red;
  var g1 = c1.green;
  var b1 = c1.blue;

  return Color.fromARGB(
      255,
      (r0 * factor + r1 * (1 - factor)).ceil(),
      (g0 * factor + g1 * (1 - factor)).ceil(),
      (b0 * factor + b1 * (1 - factor)).ceil());
}
