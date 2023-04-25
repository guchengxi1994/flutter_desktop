// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/typing_game/typing_game_controller.dart';
import 'package:flutter_desktop/components/typing_game/typing_game_details.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../applications/application.dart';

const fontSize = 28.0;
const fontSize2 = 20.0;
const duration = 3;

Application typingGameApplication() {
  return Application(
    uuid: typingGameDetails.uuid,
    name: typingGameDetails.name ?? typingGameDetails.openWith,
    resizable: false,
    background: AppStyle.light,
    child: ChangeNotifierProvider(
      create: (_) => TypingGameController(),
      child: const TypingGameForm(),
    ),
  );
}

class TypingGameForm extends StatefulWidget {
  const TypingGameForm({super.key});

  @override
  State<TypingGameForm> createState() => _TypingGameFormState();
}

class _TypingGameFormState extends State<TypingGameForm> {
  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  bool next = true;

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  final FocusNode _focusNode = FocusNode();
  late ConfettiController _controllerCenter;
  final TextEditingController controller = TextEditingController();
  final GlobalKey<__MatchWidgetState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final typeGameController = context.watch<TypingGameController>();
    final current = typeGameController.currentIdiom;
    final currentMatch = typeGameController.currentMatches;
    final currentIndex = current == null ? 0 : typeGameController.current + 1;
    if (globalKey.currentState != null && currentMatch != null) {
      globalKey.currentState!.refresh(currentMatch);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            shouldLoop:
                true, // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
            createParticlePath: drawStar, // define a custom shape/path.
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: current == null
              ? const Text(
                  "点击开始",
                  style: TextStyle(fontSize: fontSize),
                )
              : _MatchWidget(
                  key: globalKey,
                  matches: currentMatch!.matches,
                  text: currentMatch.text,
                  pinyin: current.pinyinTone.split(" "),
                ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              color: AppStyle.light2, borderRadius: BorderRadius.circular(25)),
          width: 800,
          height: 60,
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: fontSize),
            autofocus: true,
            focusNode: _focusNode,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: (value) {
              if (currentMatch == null) {
                return;
              }
              final text = value.split(" ");

              if (text.length == currentMatch.pinyin.length ||
                  value.endsWith(" ")) {
                currentMatch.match(text);
                // print(currentMatch.matches);
                globalKey.currentState!.refresh(currentMatch);
              }
            },
            onSubmitted: current != null && next
                ? (value) async {
                    setState(() {
                      next = false;
                    });
                    globalKey.currentState!.setDelay(true);
                    await Future.delayed(const Duration(seconds: duration))
                        .then((value) {
                      globalKey.currentState!.setDelay(false);
                      if (!context.read<TypingGameController>().hasNext) {
                        _controllerCenter.play();
                      } else {
                        context.read<TypingGameController>().next();
                        globalKey.currentState!.refresh(currentMatch!);
                      }
                      FocusScope.of(context).requestFocus(_focusNode);
                      controller.text = "";
                    });
                    setState(() {
                      next = true;
                    });
                  }
                : null,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        current == null
            ? const SizedBox()
            : DottedBorder(
                child: SizedBox(
                width: 500,
                child: Text(
                  current.meaning,
                  style: const TextStyle(fontSize: fontSize2),
                ),
              )),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () async {
              await context.read<TypingGameController>().refresh();
              FocusScope.of(context).requestFocus(_focusNode);
            },
            child: Text("开始"))
      ],
    );
  }
}

class _MatchWidget extends StatefulWidget {
  const _MatchWidget(
      {super.key,
      required this.matches,
      required this.text,
      required this.pinyin});
  final List<int> matches;
  final List<String> text;
  final List<String> pinyin;

  @override
  State<_MatchWidget> createState() => __MatchWidgetState();
}

class __MatchWidgetState extends State<_MatchWidget> {
  late List<int> matches;
  late List<String> text;
  late List<String> pinyin;
  bool delayed = false;

  @override
  void initState() {
    super.initState();
    matches = widget.matches;
    text = widget.text;
    pinyin = widget.pinyin;
  }

  refresh(TypingMatching matching) {
    setState(() {
      matches = matching.matches;
      text = matching.text;
      pinyin = matching.pinyinTone;
    });
  }

  setDelay(bool b) {
    setState(() {
      delayed = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        children: !delayed
            ? text
                .mapIndexed((i, e) => TextSpan(
                    text: e,
                    style: TextStyle(
                        fontSize: fontSize,
                        color: matches[i] == 1 ? Colors.red : Colors.black)))
                .toList()
            : [
                ...text
                    .mapIndexed((i, e) => TextSpan(
                        text: e,
                        style: TextStyle(
                            fontSize: fontSize,
                            color:
                                matches[i] == 1 ? Colors.red : Colors.black)))
                    .toList(),
                const TextSpan(
                    text: " ( ",
                    style: TextStyle(
                      fontSize: fontSize,
                    )),
                ...pinyin.mapIndexed((index, element) => TextSpan(
                    text: "$element ",
                    style: TextStyle(
                        fontSize: fontSize,
                        color:
                            matches[index] == 1 ? Colors.red : Colors.black))),
                const TextSpan(
                    text: " ) ",
                    style: TextStyle(
                      fontSize: fontSize,
                    )),
              ]));
  }
}
