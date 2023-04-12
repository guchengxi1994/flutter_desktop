import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_desktop/components/routers.dart';
import 'package:flutter_desktop/components/shortcuts/window_shortcut.dart';
import 'package:flutter_desktop/components/window_types.dart';

WindowShortcut backToLoginScreenShortcut() {
  final shortcut =
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyL);
  return WindowShortcut(
    shortcut: shortcut,
    type: WindowShortcutTypes.system,
    callback: () {
      Routers.navigatorKey.currentState!.popAndPushNamed(Routers.loginScreen);
    },
  );
}
