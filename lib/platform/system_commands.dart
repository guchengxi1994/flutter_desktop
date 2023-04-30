import 'package:debug_repl/components/controller.dart';

class SystemCommands {
  SystemCommands._();

  static void init() {
    CommandController.registerCommand("this --show-auther", (s) async {
      return "xiaoshuyui";
    });
  }
}
