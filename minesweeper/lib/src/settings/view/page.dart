import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/minesweeper_settings_cubit.dart';

class MinesweeperSettingsView extends StatelessWidget {
  const MinesweeperSettingsView({super.key});

  static Widget getWindow(BuildContext context) {
    return BlocProvider(
      create: (context) => MinesweeperSettingsCubit(),
      child: const MinesweeperSettingsView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: const Text("easy"),
          onPressed: () {
            // Window.of(context).close(data: MinesweeperSettings.easy);
          },
        ),
        ElevatedButton(
          child: const Text("normal"),
          onPressed: () {
            // Window.of(context).close(data: MinesweeperSettings.normal);
          },
        ),
        ElevatedButton(
          child: const Text("hard"),
          onPressed: () {
            // Window.of(context).close(data: MinesweeperSettings.hard);
          },
        ),
      ],
    );
  }
}
