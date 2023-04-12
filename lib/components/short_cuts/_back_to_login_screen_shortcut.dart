import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_desktop/components/routers.dart';
import 'package:flutter_desktop/components/short_cuts/window_shortcut.dart';
import 'package:flutter_desktop/components/window_types.dart';

WindowShortCut backToLoginScreenShortCut() {
  final shortCut =
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyL);
  return WindowShortCut(
    shortCut: shortCut,
    type: WindowShortCutTypes.system,
    callback: () {
      Routers.navigatorKey.currentState!.popAndPushNamed(Routers.loginScreen);
    },
  );
}
