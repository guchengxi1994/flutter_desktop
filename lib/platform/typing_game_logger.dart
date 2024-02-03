import 'package:flutter_desktop/src/rust/api/simple.dart' as api;
import 'package:flutter_desktop/src/rust/idiom/practice.dart';

class TypingGameLogger {
  TypingGameLogger._();

  static Future<int> newPractice() async {
    return await api.newPractice();
  }

  static Future updatePractice(int hit, int current, int rowId) async {
    await api.updatePractice(hit: hit, index: current, rowId: rowId);
  }

  static Future<PracticeStatus?> getLast() async {
    return await api.getLastPractice();
  }
}

mixin TypingGameLoggerMixin {
  Future<int> newPractice() async {
    return await TypingGameLogger.newPractice();
  }

  Future updatePractice(int hit, int current, int rowId) async {
    await TypingGameLogger.updatePractice(hit, current, rowId);
  }
}
