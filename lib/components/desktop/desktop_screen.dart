import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';

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
    return Container(
      color: AppStyle.light2,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
