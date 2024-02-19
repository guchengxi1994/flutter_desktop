import 'package:simple_terminal/simple_terminal.dart';

import '../application.dart';
import 'details.dart' show replDetails;

Application replApplication() {
  return Application(
    uuid: replDetails.uuid,
    name: replDetails.name ?? replDetails.openWith,
    resizable: replDetails.resizable,
    child: const TerminalView(),
  );
}
