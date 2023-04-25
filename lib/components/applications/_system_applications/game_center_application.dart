import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart'
    show gameCenterDetails;
import 'package:flutter_desktop/components/applications/application.dart';
import 'package:flutter_desktop/components/minesweeper/minesweeper_details.dart';
import 'package:flutter_desktop/components/typing_game/typing_game_details.dart';

import 'system_application_builder.dart';

Application gameCenterApplication() {
  return Application(
    uuid: gameCenterDetails.uuid,
    name: gameCenterDetails.name ?? gameCenterDetails.openWith,
    resizable: false,
    background: AppStyle.dark,
    child: const GameCenterForm(),
  );
}

class GameCenterForm extends StatefulWidget {
  const GameCenterForm({super.key});

  @override
  State<GameCenterForm> createState() => _GameCenterFormState();
}

class _GameCenterFormState extends State<GameCenterForm> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SystemApplicationBuilder.build(context, mineEasyDetails),
        SystemApplicationBuilder.build(context, typingGameDetails)
      ],
    );
  }
}
