import 'package:xterm/xterm.dart';

import '../application.dart';
import 'details.dart' show replDetails;

Application replApplication() {
  final terminal = Terminal();
  return Application(
    uuid: replDetails.uuid,
    name: replDetails.name ?? replDetails.openWith,
    resizable: replDetails.resizable,
    child: TerminalView(terminal),
  );
}
