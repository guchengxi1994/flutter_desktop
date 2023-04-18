import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';

import '../../utils.dart';

class KeyWidget extends StatelessWidget {
  const KeyWidget({super.key, required this.keylabel});
  final String keylabel;

  @override
  Widget build(BuildContext context) {
    double w = keylabel.length * 10;
    if (w < 50) {
      w = 50;
    }

    return SizedBox(
      width: w,
      height: 50,
      child: CustomPaint(
        painter: _KeyPainter(),
        child: Center(
          child: Text(keylabel),
        ),
      ),
    );
  }
}

class _KeyPainter extends CustomPainter {
  final double strokeWidth = 15;
  late final halfWidth = strokeWidth / 2;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()
          ..color = AppStyle.light2
          ..style = PaintingStyle.fill);
    canvas.save(); //表示保存之前的画的东西
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()
          ..color = AppStyle.grey
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth);

    var p = Paint()
      // ..color = Color.fromARGB(255, 68, 58, 58)
      ..color = combineColor(AppStyle.grey, AppStyle.light2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawLine(Offset(-halfWidth, -halfWidth),
        Offset(strokeWidth - halfWidth, strokeWidth - halfWidth), p);
    canvas.drawLine(Offset(-halfWidth, size.height + halfWidth),
        Offset(strokeWidth - halfWidth, size.height - halfWidth), p);
    canvas.drawLine(Offset(size.width + halfWidth, -halfWidth),
        Offset(size.width - halfWidth, strokeWidth - halfWidth), p);
    canvas.drawLine(Offset(size.width + halfWidth, size.height + halfWidth),
        Offset(size.width - halfWidth, size.height - halfWidth), p);

    canvas.restore(); //表示合并两次画的东西
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
