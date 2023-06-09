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

    details[index].lastXmax = details[index].xmax;
    details[index].lastXmin = details[index].xmin;
    details[index].lastYmax = details[index].ymax;
    details[index].lastYmin = details[index].ymin;

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
    details[index].lastXmax = details[index].xmax;
    details[index].xmax += d.delta.dx;
    details[index].lastYmax = details[index].ymax;
    details[index].ymax += d.delta.dy;
    notifyListeners();
  }

  changeApplicationByLeftTopPosition(String uuid, DragUpdateDetails d) {
    final index = details.findIndex(uuid);
    if (index == -1) {
      return;
    }
    details[index].lastXmin = details[index].xmin;
    details[index].xmin += d.delta.dx;
    details[index].lastYmin = details[index].ymin;
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
    details[index].lastXmax = details[index].xmax;
    details[index].xmax += d.delta.dx;
    details[index].lastYmin = details[index].ymin;
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
    details[index].lastXmin = details[index].xmin;
    details[index].xmin += d.delta.dx;
    details[index].lastYmax = details[index].ymax;
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

  /// double click window to maximize and minimize
  changeWindowSizeOnDoubleClick(String uuid, int flag, Size windowSize) {
    final index = details.findIndex(uuid);
    if (index == -1) {
      return;
    }
    if (flag == 1) {
      details[index].xmin = 0;
      details[index].ymin = 0;
      details[index].xmax = windowSize.width;
      details[index].ymax = windowSize.height - 50;
    } else {
      details[index].xmin = details[index].lastXmin;
      details[index].ymin = details[index].lastYmin;
      details[index].xmax = details[index].lastXmax;
      details[index].ymax = details[index].lastYmax;
    }
    notifyListeners();
  }
}
