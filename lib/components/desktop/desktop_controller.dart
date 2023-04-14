import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/application.dart';

class DesktopController extends ChangeNotifier {
  List<Widget> applications = [];

  String focusedApplicationUuid = "";

  setFocusedUuid(String u) {
    focusedApplicationUuid = u;
    sortByUuid();
    notifyListeners();
  }

  sortByUuid() {
    final w = applications.indexWhere(
        (element) => (element as Application).uuid == focusedApplicationUuid);
    if (w == -1) {
      return;
    }

    final s = applications.removeAt(w);
    applications.add(s);
  }

  addApplication(Widget w, {bool exists = false}) {
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
    final w = applications
        .indexWhere((element) => (element as Application).uuid == uuid);

    if (w == -1) {
      return;
    }

    applications.removeAt(w);
    notifyListeners();
  }
}
