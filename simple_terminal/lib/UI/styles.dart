import 'package:flutter/material.dart';

class Styles {
  Styles._();
  static const TextStyle defaultTextStyle = TextStyle(color: Colors.white);
  static const TextStyle commentTextStyle = TextStyle(
      color: Color.fromARGB(255, 218, 204, 204), fontStyle: FontStyle.italic);

  static const Color ok = Colors.green;
  static const Color err = Colors.red;

  static const TextStyle errStyle =
      TextStyle(color: err, fontStyle: FontStyle.italic);

  static const TextStyle okStyle = TextStyle(
      color: Color.fromARGB(255, 218, 204, 204), fontStyle: FontStyle.italic);
}
