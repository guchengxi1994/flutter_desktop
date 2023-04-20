import 'package:flutter/material.dart';

class VolumeWidget extends StatelessWidget {
  const VolumeWidget({super.key, required this.volume});
  final double volume;

  @override
  Widget build(BuildContext context) {
    if (volume < 0.3) {
      return Image.asset("assets/images/appicons/v1.png");
    }

    if (volume < 0.6) {
      return Image.asset("assets/images/appicons/v2.png");
    }

    return Image.asset("assets/images/appicons/v3.png");
  }
}
