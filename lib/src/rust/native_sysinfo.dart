// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.21.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import 'frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

class NativeSysInfo {
  final double cpu;
  final int memory;
  final int t;

  const NativeSysInfo({
    required this.cpu,
    required this.memory,
    required this.t,
  });

  @override
  int get hashCode => cpu.hashCode ^ memory.hashCode ^ t.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NativeSysInfo &&
          runtimeType == other.runtimeType &&
          cpu == other.cpu &&
          memory == other.memory &&
          t == other.t;
}
