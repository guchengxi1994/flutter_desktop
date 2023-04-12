// ignore_for_file: avoid_init_to_null

import 'package:flutter/services.dart';
import 'package:flutter_desktop/components/short_cuts/_back_to_login_screen_shortcut.dart';
import 'package:flutter_desktop/components/window_types.dart';

import 'window_shortcut.dart';

class ShortCutController {
  ShortCutController._();

  static init() {
    registerShortCut(backToLoginScreenShortCut());
  }

  static final Set<WindowShortCut> _shortCuts = {};

  static registerShortCut(WindowShortCut shortCut) {
    _shortCuts.add(shortCut);
  }

  static removeShortCut(WindowShortCut shortCut) {
    _shortCuts.remove(shortCut);
  }

  static ShortCutCallback? accepts(
      RawKeyEvent event, WindowShortCutTypes type) {
    final Iterable<WindowShortCut> shortcuts;
    if (type == WindowShortCutTypes.system) {
      shortcuts = _shortCuts.where((element) => element.type == type);
    } else {
      shortcuts = _shortCuts.where((element) =>
          element.type == type || element.type == WindowShortCutTypes.system);
    }

    if (shortcuts.isEmpty) {
      return null;
    }
    ShortCutCallback? callback = null;
    for (final s in shortcuts) {
      if (s.shortCut.accepts(event, RawKeyboard.instance)) {
        if (s.type == WindowShortCutTypes.system) {
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
