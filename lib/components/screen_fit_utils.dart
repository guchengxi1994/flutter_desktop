import 'dart:math';

import 'package:flutter/material.dart';

class DesignSize {
  static const double designWidth = 1280;
  static const double designHeight = 720;
}

extension Fitness on num {
  double w(double width, {bool fixedMinSize = false}) {
    if (fixedMinSize) {
      if (this > width / DesignSize.designWidth * this) {
        return this * 1.0;
      }
    }

    return width / DesignSize.designWidth * this;
  }

  double h(double height, {bool fixedMinSize = false}) {
    if (fixedMinSize) {
      if (height / DesignSize.designHeight < this) {
        return this * 1.0;
      }
    }
    return height / DesignSize.designHeight * this;
  }

  double size(double height, double width) {
    return min(w(width), h(height));
  }

  double sp(Size s) {
    return size(s.height, s.width);
  }
}
