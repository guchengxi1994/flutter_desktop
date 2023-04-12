import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/window_types.dart';

typedef ShortCutCallback = void Function();

class WindowShortCut {
  final WindowShortCutTypes type;
  final LogicalKeySet shortCut;
  final ShortCutCallback? callback;
  WindowShortCut({required this.shortCut, required this.type, this.callback});

  @override
  bool operator ==(Object other) {
    if (other is! WindowShortCut) {
      return false;
    }
    return other.type == type && other.shortCut == shortCut;
  }

  @override
  int get hashCode => shortCut.hashCode + type.hashCode;
}
