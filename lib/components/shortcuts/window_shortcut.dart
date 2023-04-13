import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/window_shortcut_types.dart';

typedef ShortCutCallback = void Function();

class WindowShortcut {
  final WindowShortcutTypes type;
  final LogicalKeySet shortcut;
  final ShortCutCallback? callback;
  WindowShortcut({required this.shortcut, required this.type, this.callback});

  @override
  bool operator ==(Object other) {
    if (other is! WindowShortcut) {
      return false;
    }
    return other.type == type && other.shortcut == shortcut;
  }

  @override
  int get hashCode => shortcut.hashCode + type.hashCode;
}
