import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/applications/_system_applications/details.dart';
import 'package:flutter_desktop/components/applications/application.dart';

Application videoPlayerApplication({String? videoPath}) {
  return Application(
    uuid: videoPlayerDetails.uuid,
    name: videoPlayerDetails.name,
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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
