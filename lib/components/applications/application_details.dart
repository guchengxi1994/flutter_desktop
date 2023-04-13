import 'package:flutter/material.dart';

extension ListOperation on List<ApplicationDetails> {
  int findIndex(String uuid) {
    final r = lastIndexWhere((element) => element.uuid == uuid);

    return r;
  }
}

class ApplicationDetails {
  final String uuid;
  final String name;

  /// 是否支持多开
  final bool multiple;
  Widget? icon;
  String? iconUrl;

  double xmin;
  double xmax;
  double ymin;
  double ymax;

  @override
  bool operator ==(Object other) {
    if (other is! ApplicationDetails) {
      return false;
    }
    if (multiple && other.multiple) {
      return uuid != other.uuid;
    } else {
      return other.name != name && uuid != other.uuid;
    }
  }

  ApplicationDetails({
    this.icon,
    this.iconUrl,
    required this.uuid,
    this.multiple = false,
    required this.name,
    this.xmax = 100,
    this.xmin = 0,
    this.ymax = 100,
    this.ymin = 0,
  }) {
    if (icon == null && iconUrl == null) {
      icon = const Icon(
        Icons.apps,
        color: Colors.lightBlue,
      );
    } else if (iconUrl != null) {
      icon = Image.asset(iconUrl!);
    }
  }

  @override
  int get hashCode => name.hashCode + uuid.hashCode;
}
