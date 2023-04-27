// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

const fontSize = 28.0;
const fontSize2 = 20.0;

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

  bool matchAll() {
    return matches.sum == pinyin.length;
  }

  @override
  String toString() {
    return "$text $pinyin $pinyinTone";
  }
}

class MatchWidget extends StatefulWidget {
  const MatchWidget(
      {super.key,
      required this.matches,
      required this.text,
      required this.pinyin});
  final List<int> matches;
  final List<String> text;
  final List<String> pinyin;

  @override
  State<MatchWidget> createState() => MatchWidgetState();
}

class MatchWidgetState extends State<MatchWidget> {
  late List<int> matches;
  late List<String> text;
  late List<String> pinyin;
  bool delayed = false;

  @override
  void initState() {
    super.initState();
    matches = widget.matches;
    text = widget.text;
    pinyin = widget.pinyin;
  }

  refresh(TypingMatching matching) {
    setState(() {
      matches = matching.matches;
      text = matching.text;
      pinyin = matching.pinyinTone;
    });
  }

  setDelay(bool b) {
    setState(() {
      delayed = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        children: !delayed
            ? text
                .mapIndexed((i, e) => TextSpan(
                    text: e,
                    style: TextStyle(
                        fontSize: fontSize,
                        color: matches[i] == 1 ? Colors.red : Colors.black)))
                .toList()
            : [
                ...text
                    .mapIndexed((i, e) => TextSpan(
                        text: e,
                        style: TextStyle(
                            fontSize: fontSize,
                            color:
                                matches[i] == 1 ? Colors.red : Colors.black)))
                    .toList(),
                const TextSpan(
                    text: " ( ",
                    style: TextStyle(
                      fontSize: fontSize,
                    )),
                ...pinyin.mapIndexed((index, element) => TextSpan(
                    text: "$element ",
                    style: TextStyle(
                        fontSize: fontSize,
                        color:
                            matches[index] == 1 ? Colors.red : Colors.black))),
                const TextSpan(
                    text: " ) ",
                    style: TextStyle(
                      fontSize: fontSize,
                    )),
              ]));
  }
}
