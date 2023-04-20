// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/bridge/native.dart';

const int listLength = 100;

extension Format on NativeSysInfo {
  String formatTime() {
    var t = this.t * 1000;
    var time = DateTime.fromMillisecondsSinceEpoch(t);
    return "${time.hour}:${time.minute}:${time.second}";
  }

  String formatCpu() {
    var cpu = (this.cpu * 100).toStringAsFixed(2);
    return "$cpu%";
  }

  String formatMemory() {
    var memory = this.memory;
    return filesize(memory);
  }

  String toStr() {
    return "${formatTime()}, cpu: ${formatCpu()}, memory: ${formatMemory()} ";
  }
}

class SysInfoController extends ChangeNotifier {
  late final Stream<NativeSysInfo> sysInfoStream = api.sysInfoStream();
  late List<NativeSysInfo> infos = [];
  init() {
    if (infos.isNotEmpty) {
      return;
    }
    Future.microtask(() async {
      await api.listenSysinfo();
    });

    sysInfoStream.listen((event) {
      // debugPrint(event.toStr());
      if (infos.length == listLength) {
        infos.removeAt(0);
      }

      infos.add(event);
      notifyListeners();
    });
  }
}
