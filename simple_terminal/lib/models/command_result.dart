import 'package:flutter/material.dart';
import 'package:simple_terminal/UI/styles.dart';

class CommandResult {
  final String command;
  final String result;
  final TextStyle resultStyle;
  final String timestamp;

  CommandResult(
      {required this.command,
      required this.result,
      required this.resultStyle,
      required this.timestamp});

  Widget toWidget() {
    return SizedBox(
      width: 800,
      child: Text.rich(TextSpan(children: [
        TextSpan(text: "[$timestamp]: ", style: Styles.defaultTextStyle),
        TextSpan(text: result, style: resultStyle)
      ])),
    );
  }
}
