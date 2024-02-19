import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:simple_terminal/controllers/command_controller.dart';
import 'package:simple_terminal/controllers/terminal_controller.dart';
import 'package:simple_terminal/models/clear_command.dart';

import 'command_line_region.dart';

class TerminalView extends StatefulWidget {
  const TerminalView({super.key});

  @override
  State<TerminalView> createState() => _TerminalViewState();
}

class _TerminalViewState extends State<TerminalView> {
  final TerminalController controller = TerminalController();

  @override
  void initState() {
    super.initState();
    CommandController.registerCommand(ClearCommand());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      height: 565,
      decoration: const BoxDecoration(color: Colors.black),
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListenableBuilder(
                listenable: controller,
                builder: (ctx, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 800,
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'Simple Terminal',
                                textStyle: const TextStyle(
                                    fontSize: 48.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                speed: const Duration(milliseconds: 500),
                              ),
                            ],
                            repeatForever: true,
                            pause: const Duration(milliseconds: 1000),
                            displayFullTextOnTap: true,
                            stopPauseOnTap: true,
                          ),
                        ),
                        ...controller.results.map((e) => e.toWidget())
                      ],
                    )),
          )),
          CommandLineRegion(
            onSubmit: (p0) async {
              final result = await CommandController.runCommand(p0);
              if (result.result == "") {
                controller.clearResult();
              } else {
                controller.addResult(result);
              }
            },
          )
        ],
      ),
    );
  }
}
