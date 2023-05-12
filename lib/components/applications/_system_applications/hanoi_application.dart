import 'package:flutter/material.dart';

import '../application.dart';
import 'details.dart';
import 'package:flutter_hanoi/lib.dart';

Application myHanoiApplication() {
  return Application(
    uuid: hanoiDetails.uuid,
    name: hanoiDetails.name ?? hanoiDetails.openWith,
    child: const Center(
      child: HanoiForm(
        size: Size(500, 300),
      ),
    ),
  );
}
