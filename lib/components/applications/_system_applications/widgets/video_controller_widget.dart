import 'dart:async';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

import 'volume_slider.dart';

class VideoControllerWidget extends StatefulWidget {
  const VideoControllerWidget({super.key, required this.player});
  final Player player;

  @override
  State<VideoControllerWidget> createState() => _VideoControllerWidgetState();
}

class _VideoControllerWidgetState extends State<VideoControllerWidget> {
  bool playing = false;
  bool seeking = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  Duration buffer = Duration.zero;

  List<StreamSubscription> subscriptions = [];

  @override
  void dispose() {
    super.dispose();
    for (final s in subscriptions) {
      s.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    playing = widget.player.state.playing;
    position = widget.player.state.position;
    duration = widget.player.state.duration;
    buffer = widget.player.state.buffer;
    subscriptions.addAll(
      [
        widget.player.streams.playing.listen((event) {
          setState(() {
            playing = event;
          });
        }),
        widget.player.streams.completed.listen((event) {
          setState(() {
            position = Duration.zero;
          });
        }),
        widget.player.streams.position.listen((event) {
          setState(() {
            if (!seeking) position = event;
          });
        }),
        widget.player.streams.duration.listen((event) {
          setState(() {
            duration = event;
          });
        }),
        widget.player.streams.buffer.listen((event) {
          setState(() {
            buffer = event;
          });
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Slider(
              min: 0.0,
              max: duration.inMilliseconds.toDouble(),
              value: position.inMilliseconds.toDouble().clamp(
                    0.0,
                    duration.inMilliseconds.toDouble(),
                  ),
              onChangeStart: (e) {
                seeking = true;
              },
              secondaryTrackValue: buffer.inMilliseconds.toDouble().clamp(
                    0.0,
                    duration.inMilliseconds.toDouble(),
                  ),
              onChanged: position.inMilliseconds > 0
                  ? (e) {
                      setState(() {
                        position = Duration(milliseconds: e ~/ 1);
                      });
                    }
                  : null,
              onChangeEnd: (e) {
                seeking = false;
                widget.player.seek(Duration(milliseconds: e ~/ 1));
              }),
          Row(
            children: [
              SizedBox(
                height: 40,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        elevation: MaterialStateProperty.all(20),
                        shape: MaterialStateProperty.all(
                          const CircleBorder(
                              side: BorderSide(color: Colors.white)),
                        )),
                    onPressed: () async {
                      if (widget.player.state.playing) {
                        await widget.player.pause();
                      } else {
                        await widget.player.play();
                      }
                    },
                    child: widget.player.state.playing
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow)),
              ),
              CustomVolumeSliderWidget(
                color: Colors.blueAccent,
                initial: 0.5,
                height: 30,
                width: 80,
                onSliderChanged: (d) async {
                  await widget.player.setVolume(d * 100);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
