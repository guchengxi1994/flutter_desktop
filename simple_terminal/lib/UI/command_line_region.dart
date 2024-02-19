import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_terminal/controllers/command_controller.dart';

import 'styles.dart';

typedef OnSubmit = void Function(String);

class CommandLineRegion extends StatefulWidget {
  const CommandLineRegion({super.key, required this.onSubmit});
  final OnSubmit onSubmit;

  @override
  State<CommandLineRegion> createState() => _CommandLineRegionState();
}

class _CommandLineRegionState extends State<CommandLineRegion> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 800,
        decoration: const BoxDecoration(color: Color.fromARGB(137, 43, 42, 42)),
        child: KeyboardListener(
          focusNode: FocusNode(
            onKey: (node, event) {
              if (event.logicalKey == LogicalKeyboardKey.tab) {
                final s = CommandController.autoComplete(controller.text);
                if (s != null) {
                  controller.text = s;
                  focusNode.requestFocus();
                }
              }

              if (event.logicalKey == LogicalKeyboardKey.enter) {
                widget.onSubmit(controller.text);
                controller.text = "";
                focusNode.requestFocus();
              }
              return KeyEventResult.ignored;
            },
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              const Text(
                "\$",
                style: TextStyle(color: Styles.ok, fontSize: 20),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.white),
                      focusNode: focusNode,
                      maxLines: 1,
                      cursorColor: Colors.white,
                      cursorWidth: 10,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      )))
            ],
          ),
        ));
  }
}
