import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart';
import 'package:flutter_desktop/components/applications/application.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import 'widgets/video_controller_widget.dart';

Application videoPlayerApplication({String? videoPath}) {
  return Application(
    background: AppStyle.dark,
    uuid: videoPlayerDetails.uuid,
    name: videoPlayerDetails.name ?? videoPlayerDetails.openWith,
    resizable: videoPlayerDetails.resizable,
    child: const VideoPlayerForm(),
  );
}

class VideoPlayerForm extends StatefulWidget {
  const VideoPlayerForm({super.key});

  @override
  State<VideoPlayerForm> createState() => _VideoPlayerFormState();
}

class _VideoPlayerFormState extends State<VideoPlayerForm> {
  final Player videoPlayer = Player();
  VideoController? controller;
  late double width = 800;
  late double height = 450;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      /// Create a [VideoController] to show video output of the [Player].
      controller = await VideoController.create(videoPlayer);

      /// Play any media source.
      ///
      /// TODO
      ///
      /// remove test
      await videoPlayer.open(/*for test*/ Media(
          r"C:\Users\xiaoshuyui\Desktop\不常用的东西\新建文件夹 (2)\result_voice324.mp4"));
      await videoPlayer.setVolume(50);

      setState(() {});
    });
  }

  @override
  void dispose() {
    Future.microtask(() async {
      /// Release allocated resources back to the system.
      await controller?.dispose();
      await videoPlayer.dispose();
    });
    super.dispose();
  }

  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width,
          height: height,
          child: Video(
            controller: controller,
          ),
        ),
        VideoControllerWidget(
          player: videoPlayer,
        )
      ],
    );
  }
}
