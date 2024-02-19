import 'package:flutter/material.dart';
import 'package:simple_terminal/models/command_result.dart';

class TerminalController extends ChangeNotifier {
  List<CommandResult> results = [];

  addResult(CommandResult result) {
    results.add(result);
    notifyListeners();
  }

  clearResult() {
    results.clear();
    notifyListeners();
  }
}
