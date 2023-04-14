import 'package:flutter/material.dart';

import 'application_details.dart';

class ApplicationController extends ChangeNotifier {
  List<ApplicationDetails> details = [];

  ApplicationDetails? getDetailsById(String uuid) {
    final index = details.findIndex(uuid);
    if (index == -1) {
      return null;
    }
    return details[index];
  }

  bool exists(String uuid) {
    final index = details.findIndex(uuid);
    if (index == -1) {
      return false;
    }
    return true;
  }

  changeApplicationPosition(String uuid, DragUpdateDetails d) {
    final index = details.findIndex(uuid);
    if (index == -1) {
      return;
    }

    details[index].xmin += d.delta.dx;
    details[index].ymin += d.delta.dy;
    details[index].xmax += d.delta.dx;
    details[index].ymax += d.delta.dy;

    if (details[index].xmin < 0) {
      details[index].xmin = 0;
    }

    if (details[index].ymin < 0) {
      details[index].ymin = 0;
    }
    notifyListeners();
  }

  changeApplicationByRightBottomPosition(String uuid, DragUpdateDetails d) {
    final index = details.findIndex(uuid);
    if (index == -1) {
      return;
    }
    details[index].xmax += d.delta.dx;
    details[index].ymax += d.delta.dy;
    notifyListeners();
  }

  changeApplicationByLeftTopPosition(String uuid, DragUpdateDetails d) {
    final index = details.findIndex(uuid);
    if (index == -1) {
      return;
    }
    details[index].xmin += d.delta.dx;
    details[index].ymin += d.delta.dy;

    if (details[index].xmin < 0) {
      details[index].xmin = 0;
    }

    if (details[index].ymin < 0) {
      details[index].ymin = 0;
    }
    notifyListeners();
  }

  changeApplicationByRightTopPosition(String uuid, DragUpdateDetails d) {
    final index = details.findIndex(uuid);
    if (index == -1) {
      return;
    }
    details[index].xmax += d.delta.dx;
    details[index].ymin += d.delta.dy;

    if (details[index].ymin < 0) {
      details[index].ymin = 0;
    }
    notifyListeners();
  }

  changeApplicationByLeftBottomPosition(String uuid, DragUpdateDetails d) {
    final index = details.findIndex(uuid);
    if (index == -1) {
      return;
    }
    details[index].xmin += d.delta.dx;
    details[index].ymax += d.delta.dy;

    if (details[index].xmin < 0) {
      details[index].xmin = 0;
    }
    notifyListeners();
  }

  double getHeightById(String uuid) {
    final index = details.findIndex(uuid);
    if (index == -1) {
      return 0;
    }
    return details[index].ymax - details[index].ymin;
  }

  double getWidthById(String uuid) {
    final index = details.findIndex(uuid);
    if (index == -1) {
      return 0;
    }
    return details[index].xmax - details[index].xmin;
  }

  addDetail(ApplicationDetails d) {
    details.add(d);
    notifyListeners();
  }

  removeDetail(String uuid) {
    final index = details.findIndex(uuid);
    if (index == -1) {
      return;
    }
    details.removeAt(index);
    notifyListeners();
  }
}
