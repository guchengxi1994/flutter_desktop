// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:siri_wave/siri_wave.dart';

import '../../utils.dart' show durationToMinuts;
import '../application.dart';
import 'details.dart';

Application audioPlayerApplication({String? audioPath}) {
  return Application(
    resizable: false,
    uuid: audioPlayerDetails.uuid,
    name: audioPlayerDetails.name,
    child: AudioPlayerForm(
      audioPath: audioPath,
    ),
  );
}

class AudioPlayerController {
  static final player = AudioPlayer();

  static stop() async {
    await player.stop();
  }

  static pause() async {
    await player.pause();
  }

  static resume() async {
    await player.resume();
  }

  static setPath(String s) async {
    await player.setSource(DeviceFileSource(s));
  }

  static setVolume(double v) async {
    assert(v >= 0 && v <= 1);
    await player.setVolume(v);
  }

  static getDuration() async {
    return await player.getDuration();
  }
}

class AudioPlayerForm extends StatefulWidget {
  const AudioPlayerForm({super.key, required this.audioPath});
  final String? audioPath;

  @override
  State<AudioPlayerForm> createState() => _AudioPlayerFormState();
}

class _AudioPlayerFormState extends State<AudioPlayerForm> {
  bool isPlaying = false;
  late final lisener;
  final _controller = SiriWaveController();
  final scrollerController = ScrollController();
  late final Timer timer;
  late int _count = 0;
  static const double length = 1000;
  static const int frequency = 5;
  static const double gap = 10;
  late Duration duration = Duration.zero;
  late Duration currentDuration = Duration.zero;
  final GlobalKey<State<Slider>> sliderKey = GlobalKey();
  double f = 0;
  late String? audioPath = widget.audioPath ?? /* for test */
      r"D:\CloudMusic\CANT太子 - 类少年爱情故事（钢琴版）.mp3";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      /// TODO
      ///
      /// remove !
      await AudioPlayerController.setPath(audioPath!);
      await AudioPlayerController.setVolume(0.15);
      duration = await AudioPlayerController.getDuration()!;

      setState(() {});
    });

    lisener = AudioPlayerController.player.onPositionChanged.listen((event) {
      setState(() {
        currentDuration = event;
        // print(currentDuration.inSeconds);
        if (duration.inSeconds != 0) {
          f = currentDuration.inSeconds / duration.inSeconds;
        }
      });
    });
    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      _count += 1;
      if ((_count * frequency) > length - 50) {
        _count = 0;
      }
      scrollerController.jumpTo(_count * gap);
    });
  }

  @override
  void dispose() {
    lisener.cancel();
    timer.cancel();
    super.dispose();
  }

  Widget _scrollableText(String s) {
    return SizedBox(
      width: 200,
      child: SingleChildScrollView(
        controller: scrollerController,
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.only(left: 100),
          width: length,
          child: Text(
            s,
            maxLines: 1,
            style: const TextStyle(color: AppStyle.light2),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(color: AppStyle.dark),
          width: 200,
          height: 200,
          child: Column(children: [
            _scrollableText(audioPath ?? "未找到音乐文件"),
            isPlaying
                ? Expanded(
                    child: SiriWave(
                      controller: _controller,
                    ),
                  )
                : const Expanded(
                    child: SizedBox(),
                  ),
          ]),
        ),
        Row(
          children: [
            Text(durationToMinuts(currentDuration)),
            Slider(key: sliderKey, value: f, onChanged: (v) {}),
            Text(durationToMinuts(duration)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {}, child: const Icon(Icons.skip_previous)),
            ElevatedButton(
                onPressed: () {
                  if (audioPath == null) {
                    return;
                  }
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                  if (isPlaying) {
                    AudioPlayerController.resume();
                  } else {
                    AudioPlayerController.pause();
                  }
                },
                child: isPlaying
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow)),
            ElevatedButton(
                onPressed: () {}, child: const Icon(Icons.skip_next)),
          ],
        )
      ],
    );
  }
}
