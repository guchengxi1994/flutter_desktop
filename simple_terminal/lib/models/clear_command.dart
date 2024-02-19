import 'package:simple_terminal/models/command.dart';

const String _kClearCommand = "clear";

class ClearCommand extends TerminalCommand {
  ClearCommand()
      : super(name: _kClearCommand, description: "clear screen", manual: "");

  @override
  String? autocomplete(String argument) {
    return _kClearCommand.startsWith(argument) ? _kClearCommand : null;
  }

  @override
  Future<String> execute({required List<String> arguments}) async {
    return "";
  }
}
