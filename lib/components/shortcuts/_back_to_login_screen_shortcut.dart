import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_desktop/components/shortcuts/window_shortcut.dart';
import 'package:flutter_desktop/components/window_shortcut_types.dart';

import '../utils.dart';

WindowShortcut backToLoginScreenShortcut() {
  final shortcut =
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyL);
  return WindowShortcut(
    shortcut: shortcut,
    type: WindowShortcutTypes.system,
    callback: () {
      // Routers.navigatorKey.currentState!.pop();
      PageNavigateController.navigateTo(0);
    },
  );
}
