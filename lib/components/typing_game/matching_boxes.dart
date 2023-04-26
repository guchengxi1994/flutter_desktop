// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:collection/collection.dart';

typedef OnBoxClicked = Function(int);

class MatchingBoxes extends StatefulWidget {
  const MatchingBoxes({super.key, this.onBoxClicked});
  final OnBoxClicked? onBoxClicked;

  @override
  State<MatchingBoxes> createState() => MatchingBoxesState();
}

class MatchingBoxesState extends State<MatchingBoxes> {
  late List<int> generated = [];

  init(int itemCount) {
    setState(() {
      // generated = List.generate(itemCount, (index) => index + 1);
      generated = List.filled(itemCount, 0);
    });
  }

  setStatus(int index, int status) {
    setState(() {
      generated[index] = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return generated.isEmpty
        ? Container()
        : Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(color: AppStyle.light2),
            width: 800,
            child: Wrap(
              runSpacing: 10,
              spacing: 10,
              children: generated
                  .mapIndexed((i, e) => InkWell(
                        onTap: () {
                          if (widget.onBoxClicked != null) {
                            widget.onBoxClicked!(i);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: e == 0
                                  ? Colors.lightBlue
                                  : e == 1
                                      ? Colors.lightGreen
                                      : Colors.redAccent),
                          width: 40,
                          height: 40,
                          child: Center(
                            child: Text(
                              (i + 1).toString(),
                              style: const TextStyle(
                                  color: AppStyle.light2, fontSize: 20),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
  }
}
