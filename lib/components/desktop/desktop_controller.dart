// ignore_for_file: unnecessary_type_check

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/application.dart';

class DesktopController<T extends Application> extends ChangeNotifier {
  List<T> applications = [];

  String focusedApplicationUuid = "";

  setFocusedUuid(String u) {
    focusedApplicationUuid = u;
    sortByUuid();
    notifyListeners();
  }

  sortByUuid() {
    final w = applications
        .indexWhere((element) => (element).uuid == focusedApplicationUuid);
    if (w == -1) {
      return;
    }

    final s = applications.removeAt(w);
    applications.add(s);
  }

  addApplication(T w, {bool exists = false}) {
    if (!exists) {
      applications.add(w);
    }
    if (w is Application) {
      focusedApplicationUuid = w.uuid;
      sortByUuid();
    }

    notifyListeners();
  }

  removeWidget(String uuid) {
    final w = applications.indexWhere((element) => element.uuid == uuid);

    if (w == -1) {
      return;
    }

    applications.removeAt(w);
    notifyListeners();
  }
}
