import 'package:flutter/material.dart';
import 'package:flutter_desktop/bridge/native.dart';

class PracticeController extends ChangeNotifier {
  int current = 0;
  int hitCount = 0;

  addHitCount() {
    hitCount += 1;
    notifyListeners();
  }

  Future<Idiom?> getNext() async {
    current += 1;
    notifyListeners();
    return await api.getOneIdiom(index: current);
  }
}
