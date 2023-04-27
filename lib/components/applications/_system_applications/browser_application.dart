import 'package:browser/lib.dart';
import 'package:flutter/material.dart';

import '../application.dart';
import 'details.dart' show browserDetails;

Application browserApplication() {
  return Application(
    resizable: browserDetails.resizable,
    uuid: browserDetails.uuid,
    name: browserDetails.name ?? browserDetails.openWith,
    child: const SizedBox(
      height: 550,
      width: 1100,
      child: BrowserWidget(),
    ),
  );
}
