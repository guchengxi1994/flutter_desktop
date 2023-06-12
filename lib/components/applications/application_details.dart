import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';

extension ListOperation on List<ApplicationDetails> {
  int findIndex(String uuid) {
    final r = lastIndexWhere((element) => element.uuid == uuid);

    return r;
  }
}

class ApplicationDetails {
  final String uuid;
  final String? name;
  final String openWith;
  Color? nameColor;

  /// 是否支持多开
  final bool multiple;
  final bool deletable;
  Widget? icon;
  String? iconUrl;

  final bool needsTaskbarDisplay;
  final bool needsTrayDisplay;
  final bool resizable;
  bool needScroll;

  double xmin;
  double xmax;
  double ymin;
  double ymax;

  double lastXmin;
  double lastXmax;
  double lastYmin;
  double lastYmax;

  @override
  bool operator ==(Object other) {
    if (other is! ApplicationDetails) {
      return false;
    }
    if (multiple && other.multiple) {
      return uuid != other.uuid;
    } else {
      return other.name != name &&
          uuid != other.uuid &&
          openWith != other.openWith;
    }
  }

  ApplicationDetails(
      {this.icon,
      this.iconUrl,
      required this.uuid,
      this.multiple = false,
      this.name,
      this.xmax = 100,
      this.xmin = 0,
      this.ymax = 100,
      this.ymin = 0,
      this.lastXmax = 100,
      this.lastXmin = 0,
      this.lastYmax = 100,
      this.lastYmin = 0,
      this.deletable = true,
      this.needsTaskbarDisplay = false,
      this.needsTrayDisplay = false,
      this.resizable = true,
      required this.openWith,
      this.nameColor = AppStyle.light2,
      this.needScroll = true}) {
    lastXmax = xmax;
    lastXmin = xmin;
    lastYmax = ymax;
    lastYmin = ymin;

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
