import 'package:isar/isar.dart';
part 'browser_history.g.dart';

@collection
class BrowserHistory {
  Id id = Isar.autoIncrement;
  String? url;
  int createAt = DateTime.now().millisecondsSinceEpoch;
}
