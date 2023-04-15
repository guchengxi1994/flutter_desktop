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
