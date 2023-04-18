import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/notifications/notification_details.dart';

class NotificationController extends ChangeNotifier {
  List<NotificationDetails> details = [];

  raiseANotification(NotificationDetails d) {
    details.insert(0, d);
    notifyListeners();
  }

  removeANotification(NotificationDetails d) {
    details.remove(d);
    notifyListeners();
  }

  removeNotificationByUuid(String d) {
    details.retainWhere((element) => element.uuid != d);
    notifyListeners();
  }
}
