import 'package:flutter/material.dart';
import 'package:flutter_desktop/src/rust/api/simple.dart' as api;
import 'package:flutter_desktop/src/rust/idiom/model.dart';

class PracticeController extends ChangeNotifier {
  int current = 0;
  int hitCount = 0;

  addHitCount() {
    hitCount += 1;
    notifyListeners();
  }

  setLast() async {
    final last = await api.getLastPractice();
    debugPrint("[last] ${last?.current}");
    if (last != null) {
      current = last.current;
      hitCount = last.hit;
      notifyListeners();
      return last.practiceId;
    }
    return 0;
  }

  Future<Idiom?> getNext() async {
    current += 1;
    notifyListeners();
    return await api.getOneIdiom(index: current);
  }
}
