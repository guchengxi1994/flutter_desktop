import 'package:isar/isar.dart';
part 'operation.g.dart';

@collection
class Operation {
  Id id = Isar.autoIncrement;
  String? content;
  String? result;
  int createAt = DateTime.now().millisecondsSinceEpoch;
}
