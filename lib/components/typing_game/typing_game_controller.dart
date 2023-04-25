import 'package:flutter/material.dart';
import 'package:flutter_desktop/bridge/native.dart';

class TypingMatching {
  final List<String> text;
  final List<String> pinyin;
  final List<String> pinyinTone;
  late List<int> matches = List.filled(text.length, 0);

  TypingMatching(
      {required this.text, required this.pinyin, required this.pinyinTone});

  void match(List<String> s) {
    s.retainWhere((element) => element.trim() != "");
    if (s.isEmpty) {
      matches = List.filled(text.length, 0);
    }

    for (int i = 0; i < s.length; i++) {
      if (s[i] == pinyin[i]) {
        matches[i] = 1;
      }
    }
  }
}

class TypingGameController extends ChangeNotifier {
  List<Idiom> idioms = [];
  int current = 0;

  late List<int> hits = [];
  late List<TypingMatching> matches = [];
  TypingMatching? get currentMatches => matches.isEmpty ? null : matches.last;

  Idiom? get currentIdiom => idioms.isEmpty ? null : idioms[current];

  bool get hasNext => !(current == idioms.length - 1) && idioms.isNotEmpty;

  refresh() async {
    idioms = await api.getIdioms(/* 10 for test*/ count: 10);
    hits = List.filled(idioms.length, 0);
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
