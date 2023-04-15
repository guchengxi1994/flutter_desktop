import 'package:flutter/material.dart';
import 'package:flutter_desktop/bridge/native.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/routers.dart';
import 'package:flutter_desktop/components/screen_fit_utils.dart';

import '../utils.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future loading() async {
    await api.setDbPath(s: "${DevUtils.executableDir.path}/data.db");
    await api.initDb();

    await Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routers.desktopScreen, (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    loading();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: AppStyle.dark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Icon(
            Icons.desktop_windows,
            color: AppStyle.light,
            size: 150.h(size.height),
          ),
          SizedBox(
            height: 150.h(size.height),
          ),
          const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              color: AppStyle.light2,
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
