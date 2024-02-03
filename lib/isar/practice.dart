import 'package:isar/isar.dart';
part 'practice.g.dart';

@collection
class Practice {
  Id id = Isar.autoIncrement;
  int? hit;
  int? current;
  int createAt = DateTime.now().millisecondsSinceEpoch;
}
