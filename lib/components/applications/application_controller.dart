import 'package:flutter/material.dart';

import 'application_details.dart';

class ApplicationController<T extends ApplicationDetails>
    extends ChangeNotifier {
  List<T> details = [];

  T? getDetailsById(String uuid) {
    final index = details.findIndex(uuid);
    if (index == -1) {
      return null;
    }
    return details[index];
  }

  bool trayVisible = false;
  changeTrayVisible({bool? b}) {
    if (b != null) {
      if (b != trayVisible) {
        trayVisible = b;
      } else {
        return;
      }
    } else {
      trayVisible = !trayVisible;
    }
    notifyListeners();
  }

  bool exists(String uuid) {
    // print(details);
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

    if (details[index].xmin + d.delta.dx < 0 ||
        details[index].ymin + d.delta.dy < 0) {
      return;
    }

    details[index].xmin += d.delta.dx;
    details[index].ymin += d.delta.dy;
    details[index].xmax += d.delta.dx;
    details[index].ymax += d.delta.dy;

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

  addDetail(T d) {
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
