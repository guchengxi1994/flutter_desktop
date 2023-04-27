// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';

typedef OnBrowserInit = String Function();
typedef OnUrlChanged = void Function(String);

class BrowserController {
  final OnBrowserInit? onBrowserInit;
  final OnUrlChanged? onUrlChanged;

  BrowserController({this.onBrowserInit, this.onUrlChanged});

  WebviewController get controller => _controller;

  List<String> history = [];
  final _controller = WebviewController();

  Future back() async {
    if (history.length < 2) {
      return;
    }
    history.removeLast();
    final s = history.removeLast();
    await _controller.loadUrl(s);
  }

  Future initPlatformState() async {
    await _controller.initialize();
    _controller.url.listen((url) {
      if (history.isNotEmpty && history.last == url) {
        return;
      }
      history.add(url);
      if (onUrlChanged != null) {
        onUrlChanged!(url);
      }
    });
    await _controller.setBackgroundColor(Colors.transparent);
    await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.sameWindow);

    if (onBrowserInit != null) {
      final s = onBrowserInit!();
      await _controller.loadUrl(s);
    } else {
      await _controller.loadUrl('https://flutter.dev');
    }
  }
}
