import 'package:debug_repl/components/repl_window.dart';

import '../application.dart';
import 'details.dart' show replDetails;

Application replApplication() {
  return Application(
    uuid: replDetails.uuid,
    name: replDetails.name ?? replDetails.openWith,
    resizable: replDetails.resizable,
    child: const ReplWindow(
      height: 400,
      width: 600,
      prevCommands: [],
    ),
  );
}
