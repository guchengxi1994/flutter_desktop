import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/routers.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future loading() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routers.loginScreen, (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    loading();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppStyle.dark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Icon(
            Icons.desktop_windows,
            color: AppStyle.light,
            size: 150,
          ),
          const SizedBox(
            height: 150,
          ),
          SizedBox(
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
