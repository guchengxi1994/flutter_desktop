import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/short_cuts/short_cut_builder.dart';
import 'package:flutter_desktop/components/window_types.dart';

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({super.key});

  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ShortCutBuilder(
        builder: (ctx) {
          return Container(
            color: AppStyle.light2,
          );
        },
        type: WindowShortCutTypes.desktop);
  }

  @override
  bool get wantKeepAlive => true;
}
