import 'package:flutter/material.dart';

import '../applications/application_details.dart';

class TaskbarController extends ChangeNotifier {
  List<ApplicationDetails> displayedApplications = [];

  addDetails(ApplicationDetails d, {bool exists = false}) {
    if (!exists) {
      displayedApplications.add(d);
      notifyListeners();
    }
  }

  removeDetails(String uuid) {
    final index = displayedApplications.findIndex(uuid);
    if (index == -1) {
      return;
    }
    displayedApplications.removeAt(index);
    notifyListeners();
  }
}
