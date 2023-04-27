// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_desktop/components/shortcuts/_back_to_login_screen_shortcut.dart';
import 'package:flutter_desktop/components/window_shortcut_types.dart';

import 'window_shortcut.dart';

class ShortcutPreviewController extends ChangeNotifier {
  List<RawKeyEvent> events = [];

  clear() {
    events.clear();
    notifyListeners();
  }

  operateEvent(RawKeyEvent e) {
    if (e is RawKeyDownEvent) {
      if (e.repeat) {
        return;
      }
      events.add(e);
    } else {
      events.retainWhere(
          (element) => element.logicalKey.keyLabel != e.logicalKey.keyLabel);
    }
    notifyListeners();
  }
}

class ShortcutController {
  ShortcutController._();

  static init() {
    registerShortCut(backToLoginScreenShortcut());
  }

  static final Set<WindowShortcut> _shortCuts = {};

  static registerShortCut(WindowShortcut shortCut) {
    _shortCuts.add(shortCut);
  }

  static removeShortCut(WindowShortcut shortCut) {
    _shortCuts.remove(shortCut);
  }

  static ShortCutCallback? accepts(
      RawKeyEvent event, WindowShortcutTypes type) {
    final Iterable<WindowShortcut> shortcuts;
    if (type == WindowShortcutTypes.system) {
      shortcuts = _shortCuts.where((element) => element.type == type);
    } else {
      shortcuts = _shortCuts.where((element) =>
          element.type == type || element.type == WindowShortcutTypes.system);
    }

    if (shortcuts.isEmpty) {
      return null;
    }
    ShortCutCallback? callback = null;
    for (final s in shortcuts) {
      if (s.shortcut.accepts(event, RawKeyboard.instance)) {
        if (s.type == WindowShortcutTypes.system) {
          return s.callback;
        } else {
          callback = s.callback;
          continue;
        }
      }
    }

    return callback;
  }
}
