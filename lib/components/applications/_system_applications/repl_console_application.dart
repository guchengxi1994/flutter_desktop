import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xterm/xterm.dart';

import '../application.dart';
import 'details.dart' show replDetails;

Application replApplication() {
  final terminal = Terminal();
  final terminalController = TerminalController();
  return Application(
    uuid: replDetails.uuid,
    name: replDetails.name ?? replDetails.openWith,
    resizable: replDetails.resizable,
    child: SizedBox(
      width: 600,
      height: 400,
      child: TerminalView(
        terminal,
        controller: terminalController,
        onSecondaryTapDown: (details, offset) async {
          final selection = terminalController.selection;
          if (selection != null) {
            final text = terminal.buffer.getText(selection);
            terminalController.clearSelection();
            await Clipboard.setData(ClipboardData(text: text));
          } else {
            final data = await Clipboard.getData('text/plain');
            final text = data?.text;
            if (text != null) {
              terminal.paste(text);
            }
          }
        },
      ),
    ),
  );
}
