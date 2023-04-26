import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/typing_game/base/typing_game_board.dart';
import 'package:flutter_desktop/components/typing_game/base/typing_game_controller.dart';
import 'package:provider/provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ChangeNotifierProvider(
        create: (_) => TypingGameController(),
        child: const TypingGameForm(),
      )),
    );
  }
}
