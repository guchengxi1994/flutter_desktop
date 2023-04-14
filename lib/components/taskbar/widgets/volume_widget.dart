import 'package:flutter/material.dart';

class VolumnWidget extends StatelessWidget {
  const VolumnWidget({super.key, required this.volumn});
  final double volumn;

  @override
  Widget build(BuildContext context) {
    if (volumn < 0.3) {
      return Image.asset("assets/images/appicons/v1.png");
    }

    if (volumn < 0.6) {
      return Image.asset("assets/images/appicons/v2.png");
    }

    return Image.asset("assets/images/appicons/v3.png");
  }
}
