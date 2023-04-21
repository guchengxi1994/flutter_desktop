import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper/src/theme.dart';

import '../cubit/minesweeper_game_cubit.dart';
import '../models/minefield_highlight.dart';
import '../models/minesweeper_settings.dart';
import 'game_board.dart';
import 'indicator.dart';

const defaultCellSize = 23.0;

class MinesweeperWindow extends StatelessWidget {
  final MinesweeperSettings initalSettings;
  const MinesweeperWindow({
    Key? key,
    this.initalSettings = MinesweeperSettings.easy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MinesweeperGameCubit(initalSettings),
      child: const Minesweeper(),
    );
  }
}

class Minesweeper extends StatelessWidget {
  const Minesweeper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
                left: BorderSide(
                  color: highlightColor,
                  width: borderWidth,
                ),
                top: BorderSide(
                  color: highlightColor,
                  width: borderWidth,
                ),
                right: BorderSide(
                  color: shadowColor,
                  width: borderWidth,
                ),
                bottom: BorderSide(
                  color: shadowColor,
                  width: borderWidth,
                )),
          ),
          padding: const EdgeInsets.all(4),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                      color: shadowColor.withAlpha(100),
                      width: borderWidth,
                    ),
                    top: BorderSide(
                      color: shadowColor.withAlpha(100),
                      width: borderWidth,
                    ),
                    right: BorderSide(
                      color: highlightColor.withAlpha(100),
                      width: borderWidth,
                    ),
                    bottom: BorderSide(
                      color: highlightColor.withAlpha(100),
                      width: borderWidth,
                    )),
              ),
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  MinesCounterView(),
                  ResetButtonView(),
                  TimerView(),
                ],
              ),
            ),
            const GameView(),
          ]),
        ),
      ],
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.select((MinesweeperGameCubit c) => c.state);

    return Container(
      decoration: BoxDecoration(
        border: Border(
            left: BorderSide(
              color: shadowColor.withAlpha(100),
              width: borderWidth,
            ),
            top: BorderSide(
              color: shadowColor.withAlpha(100),
              width: borderWidth,
            ),
            right: BorderSide(
              color: highlightColor.withAlpha(100),
              width: borderWidth,
            ),
            bottom: BorderSide(
              color: highlightColor.withAlpha(100),
              width: borderWidth,
            )),
      ),
      child: GameBoard(
        field: state.field,
        //size: new Size(300, 300),
        cellSize: defaultCellSize,
        modifier: state.modifier,
        finished: state is MinesweeperGameFinished && !state.victory,
        onTap: (pos) => context.read<MinesweeperGameCubit>().openCell(pos),
        onTapDown: (pos) => context.read<MinesweeperGameCubit>().pressCell(pos),
        onSecondaryTap: (pos) =>
            context.read<MinesweeperGameCubit>().markCell(pos),
        onTapUp: () => context.read<MinesweeperGameCubit>().unPressCell(),
      ),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    var time = context.select((MinesweeperGameCubit c) => c.state.time);

    return Container(
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                color: shadowColor.withAlpha(100),
                width: borderWidth,
              ),
              top: BorderSide(
                color: shadowColor.withAlpha(100),
                width: borderWidth,
              ),
              right: BorderSide(
                color: highlightColor.withAlpha(100),
                width: borderWidth,
              ),
              bottom: BorderSide(
                color: highlightColor.withAlpha(100),
                width: borderWidth,
              ))),
      child: SevenSegmentIndicator(
        height: 30,
        number: time,
      ),
    );
  }
}

class MinesCounterView extends StatelessWidget {
  const MinesCounterView({super.key});

  @override
  Widget build(BuildContext context) {
    var bombsLeft =
        context.select((MinesweeperGameCubit c) => c.countBombsLeft());

    return Container(
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                color: shadowColor.withAlpha(100),
                width: borderWidth,
              ),
              top: BorderSide(
                color: shadowColor.withAlpha(100),
                width: borderWidth,
              ),
              right: BorderSide(
                color: highlightColor.withAlpha(100),
                width: borderWidth,
              ),
              bottom: BorderSide(
                color: highlightColor.withAlpha(100),
                width: borderWidth,
              ))),
      child: SevenSegmentIndicator(
        height: 30,
        number: bombsLeft,
      ),
    );
  }
}

// D:/github_repo/flutter_windows_desktop/minesweeper/lib/assets/minesweeper/emoji/lost.png

class ResetButtonView extends StatelessWidget {
  static const smile = "assets/smile.png";
  static const panic = "assets/panic.png";
  static const won = "assets/won.png";
  static const lost = "assets/lost.png";
  static const what = "assets/what.png";

  const ResetButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.select((MinesweeperGameCubit c) => c.state);

    String emoji = smile;

    if (state is MinesweeperGameFinished) {
      emoji = state.victory ? won : lost;
    }

    if (state is MinesweeperGameGoing) {
      if (state.modifier is! MinefieldHighlightNone) {
        emoji = panic;
      }
    }

    return InkWell(
      onTap: () => context.read<MinesweeperGameCubit>().resetGame(),
      // child: Image.asset(
      //   emoji,
      //   height: 38,
      // ),
      child: Image.asset(
        AssetImage(emoji).assetName,
        package: "minesweeper",
      ),
    );
  }
}
