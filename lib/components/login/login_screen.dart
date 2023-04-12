// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/login/widgets/battery.dart';
import 'package:flutter_desktop/components/login/login_controller.dart';
import 'package:flutter_desktop/components/login/widgets/login_form.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()..init())
      ],
      child: const _LoginScreen(),
    );
  }
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<LoginController>().changeShowForm();
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/login_background.jpg"),
                    fit: BoxFit.fill)),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: context.select<LoginController, bool>(
                        (value) => value.showForm)
                    ? 5.0
                    : 0,
                sigmaY: context.select<LoginController, bool>(
                        (value) => value.showForm)
                    ? 5.0
                    : 0),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const Expanded(child: SizedBox()),
                const SizedBox(
                  height: 100,
                ),
                if (context
                    .select<LoginController, bool>((value) => value.showForm))
                  LoginForm(),
                if (!context
                    .select<LoginController, bool>((value) => value.showForm))
                  StreamBuilder(
                      stream: LoginController.timeStream(),
                      builder: (c, s) {
                        if (s.data == null) {
                          return const CircularProgressIndicator();
                        }
                        return Column(
                          children: [
                            Text(
                              "${s.data!.hour}:${s.data!.minute}",
                              style: TextStyle(
                                  color: AppStyle.light2, fontSize: 72),
                            ),
                            Text(
                              "${s.data!.month}月${s.data!.day}日 ${DateFormat('EEEE', "zh_CN").format(s.data!)}",
                              style: TextStyle(
                                  color: AppStyle.light2, fontSize: 35),
                            ),
                          ],
                        );
                      }),
                const Expanded(child: SizedBox()),
                Visibility(
                    maintainState: true,
                    maintainSize: true,
                    maintainAnimation: true,
                    visible: !context.select<LoginController, bool>(
                        (value) => value.showForm),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 200,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StreamBuilder(
                                  stream: LoginController.batteryStream(),
                                  builder: (ctx, s) {
                                    return BatteryWidget(
                                      battery: s.data ?? 50,
                                      state: context
                                          .watch<LoginController>()
                                          .batteryState,
                                      showBattery: false,
                                    );
                                  }),
                              const SizedBox(
                                width: 20,
                              ),
                              StreamBuilder(
                                  stream: LoginController.wifiStream(),
                                  builder: (ctx, s) {
                                    if (s.data == null) {
                                      return Icon(
                                        Icons.wifi_off,
                                        size: AppStyle.iconSize,
                                        color: AppStyle.light2,
                                      );
                                    } else {
                                      return Icon(
                                        Icons.wifi,
                                        size: AppStyle.iconSize,
                                        color: AppStyle.light2,
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ))),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
