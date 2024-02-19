import 'package:simple_terminal/UI/styles.dart';
import 'package:simple_terminal/models/command.dart';
import 'package:simple_terminal/models/command_result.dart';

class CommandController {
  CommandController._();

  static List<TerminalCommand> commands = [];

  static void registerCommand(TerminalCommand command) {
    if (commands.where((element) => element.name == command.name).isNotEmpty) {
      return;
    }

    commands.add(command);
  }

  static Future<CommandResult> runCommand(String k,
      {List<String> arguments = const []}) async {
    final l = commands.where((element) => element.name == k).firstOrNull;
    if (l != null) {
      return CommandResult(
          command: k,
          result: await l.execute(arguments: arguments),
          resultStyle: Styles.okStyle,
          timestamp: DateTime.now().toIso8601String());
    }
    return CommandResult(
        command: k,
        result: "$k: command not found",
        resultStyle: Styles.errStyle,
        timestamp: DateTime.now().toIso8601String());
  }

  static String? autoComplete(String argument) {
    for (final i in commands) {
      if (i.autocomplete(argument) != null) {
        return i.name;
      }
    }
    return null;
  }
}
