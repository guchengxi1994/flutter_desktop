import 'package:flutter/material.dart';
import 'package:flutter_desktop/bridge/native.dart';

import '../matching.dart';

class TypingGameController extends ChangeNotifier {
  List<Idiom> idioms = [];
  int current = 0;

  static int idiomCount = /* 10 for test*/ 10;

  late List<TypingMatching> matches = [];
  TypingMatching? get currentMatches => matches.isEmpty ? null : matches.last;

  Idiom? get currentIdiom => idioms.isEmpty ? null : idioms[current];

  bool get hasNext => !(current == idioms.length - 1) && idioms.isNotEmpty;

  bool get allRight =>
      matches.length == idioms.length &&
      matches.where((element) => element.matchAll() == false).isEmpty;

  refresh() async {
    idioms = await api.getIdioms(count: idiomCount);
    current = 0;
    matches.add(TypingMatching(
        text: currentIdiom!.idiom.split(""),
        pinyin: currentIdiom!.pinyin.split(" "),
        pinyinTone: currentIdiom!.pinyinTone.split(" ")));

    notifyListeners();
  }

  next() {
    if (current == idioms.length - 1) {
      return;
    }
    current += 1;
    matches.add(TypingMatching(
        text: currentIdiom!.idiom.split(""),
        pinyin: currentIdiom!.pinyin.split(" "),
        pinyinTone: currentIdiom!.pinyinTone.split(" ")));
    notifyListeners();
  }
}
