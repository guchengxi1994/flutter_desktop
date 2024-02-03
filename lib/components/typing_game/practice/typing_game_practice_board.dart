// ignore_for_file: avoid_init_to_null, use_build_context_synchronously

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/src/rust/api/simple.dart' as api;
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/applications/application.dart';
import 'package:flutter_desktop/platform/typing_game_logger.dart';
import 'package:flutter_desktop/src/rust/idiom/model.dart';
import 'package:provider/provider.dart';

import '../matching.dart';
import 'controller.dart';
import 'typing_game_practice_details.dart';

const duration = 3;

Application typingGamePracticeApplication() {
  final GlobalKey<_TypingGamePracticeFormState> globalKey = GlobalKey();
  return Application(
    uuid: typingGamePracticeDetails.uuid,
    name: typingGamePracticeDetails.name ?? typingGamePracticeDetails.openWith,
    resizable: false,
    background: AppStyle.light,
    child: ChangeNotifierProvider(
      create: (_) => PracticeController(),
      child: TypingGamePracticeForm(
        key: globalKey,
      ),
    ),
    onClose: () async {
      await globalKey.currentState!.saveStatus();
    },
  );
}

class TypingGamePracticeForm extends StatefulWidget {
  const TypingGamePracticeForm({super.key});

  @override
  State<TypingGamePracticeForm> createState() => _TypingGamePracticeFormState();
}

class _TypingGamePracticeFormState extends State<TypingGamePracticeForm>
    with TypingGameLoggerMixin {
  bool next = true;
  late Idiom? current = null;
  late TypingMatching? currentMatch = null;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  final GlobalKey<MatchWidgetState> globalKey = GlobalKey();
  late int currentPracticeId = 0;
  late PracticeController? typeGameController = null;

  @override
  void initState() {
    super.initState();
  }

  saveStatus() async {
    if (currentPracticeId == 0) {
      return;
    }
    await updatePractice(typeGameController!.hitCount,
        typeGameController!.current, currentPracticeId);
  }

  @override
  Widget build(BuildContext context) {
    typeGameController = context.watch<PracticeController>();
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: MenuBar(
                    style: MenuStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => AppStyle.light2),
                    ),
                    children: [
                      SubmenuButton(
                          menuChildren: _meunList(), child: const Text("系统"))
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: current == null || currentMatch == null
                  ? const Text(
                      "点击开始",
                      style: TextStyle(fontSize: fontSize),
                    )
                  : MatchWidget(
                      key: globalKey,
                      matches: currentMatch!.matches,
                      text: currentMatch!.text,
                      pinyin: current!.pinyinTone.split(" "),
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: AppStyle.light2,
                  borderRadius: BorderRadius.circular(25)),
              width: 800,
              height: 60,
              child: TextField(
                controller: controller,
                style: const TextStyle(fontSize: fontSize),
                autofocus: true,
                focusNode: _focusNode,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  if (currentMatch == null) {
                    return;
                  }
                  final text = value.split(" ");

                  if (text.length == currentMatch!.pinyin.length ||
                      value.endsWith(" ")) {
                    currentMatch!.match(text);
                    // print(currentMatch.matches);
                    globalKey.currentState!.refresh(currentMatch!);
                  }
                },
                onSubmitted: current != null && next
                    ? (value) async {
                        setState(() {
                          next = false;
                        });
                        globalKey.currentState!.setDelay(true);

                        await Future.delayed(const Duration(seconds: duration))
                            .then((value) {
                          if (currentMatch!.matchAll()) {
                            context.read<PracticeController>().addHitCount();
                          }

                          FocusScope.of(context).requestFocus(_focusNode);
                          controller.text = "";
                        });
                        current =
                            await context.read<PracticeController>().getNext();

                        currentMatch = TypingMatching(
                            text: current!.idiom.split(""),
                            pinyin: current!.pinyin.split(" "),
                            pinyinTone: current!.pinyinTone.split(" "));
                        setState(() {
                          next = true;
                        });
                        globalKey.currentState!.setDelay(false);
                        globalKey.currentState!.refresh(currentMatch!);
                      }
                    : null,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            current == null
                ? const SizedBox()
                : DottedBorder(
                    child: SizedBox(
                    width: 750,
                    child: Text(
                      current!.meaning,
                      style: const TextStyle(fontSize: fontSize2),
                    ),
                  )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  currentPracticeId = await newPractice();
                  current = await context.read<PracticeController>().getNext();
                  currentMatch = TypingMatching(
                      text: current!.idiom.split(""),
                      pinyin: current!.pinyin.split(" "),
                      pinyinTone: current!.pinyinTone.split(" "));
                  setState(() {});
                },
                child: current != null ? const Text("重置") : const Text("开始")),
          ],
        ),
        Positioned(
            right: 10,
            top: 50,
            child: Text(
                "${typeGameController!.hitCount}/${typeGameController!.current}")),
      ],
    );
  }

  List<Widget> _meunList() {
    return [
      MenuItemButton(
        child: const Text("继续"),
        onPressed: () async {
          currentPracticeId = await typeGameController!.setLast();
          current = await context.read<PracticeController>().getNext();
          currentMatch = TypingMatching(
              text: current!.idiom.split(""),
              pinyin: current!.pinyin.split(" "),
              pinyinTone: current!.pinyinTone.split(" "));

          setState(() {});
        },
      ),
    ];
  }
}
