import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/applications/application.dart';
import 'package:flutter_desktop/components/minesweeper/minesweeper_details.dart';
import 'package:minesweeper/lib.dart';

Application minesweeperApplication() {
  return Application(
    uuid: mineEasyDetails.uuid,
    name: mineEasyDetails.name ?? mineEasyDetails.openWith,
    resizable: false,
    background: AppStyle.light,
    child: const MinesweeperForm(),
  );
}

class MinesweeperForm extends StatefulWidget {
  const MinesweeperForm({super.key});

  @override
  State<MinesweeperForm> createState() => _MinesweeperFormState();
}

class _MinesweeperFormState extends State<MinesweeperForm> {
  @override
  Widget build(BuildContext context) {
    return const MinesweeperWindow();
  }
}
