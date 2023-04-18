import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/application_details.dart';

class NotificationDetails extends ApplicationDetails {
  NotificationDetails(
      {required super.uuid,
      required super.name,
      required super.icon,
      required this.content,
      required this.subject});
  final Widget content;
  final String subject;

  @override
  bool operator ==(Object other) {
    if (other is! NotificationDetails) {
      return false;
    }
    return uuid == other.uuid && subject == other.subject;
  }

  @override
  int get hashCode => uuid.hashCode + subject.hashCode;
}
