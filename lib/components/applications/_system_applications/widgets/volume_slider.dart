import 'package:flutter/material.dart';

typedef OnSliderChanged = Function(double);

class CustomVolumeSliderWidget extends StatefulWidget {
  const CustomVolumeSliderWidget(
      {super.key,
      this.initial = 0.15,
      this.width = 300,
      this.height = 150,
      required this.onSliderChanged,
      this.color = Colors.orange});
  final double initial;
  final double width;
  final double height;
  final OnSliderChanged onSliderChanged;
  final Color color;

  @override
  State<CustomVolumeSliderWidget> createState() =>
      _CustomVolumeSliderWidgetState();
}

class _CustomVolumeSliderWidgetState extends State<CustomVolumeSliderWidget> {
  late double volume = widget.initial;
  late double currentWidth = widget.width * volume;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onHorizontalDragUpdate: (v) {
          currentWidth = v.localPosition.dx;
          if (currentWidth < 0) {
            currentWidth = 0;
          }
          if (currentWidth > widget.width) {
            currentWidth = widget.width;
          }
          widget.onSliderChanged(currentWidth / widget.width);
          setState(() {});
        },
        child: CustomPaint(
          size: Size(widget.width, widget.height), //指定画布大小
          painter: _VolumePainter(activated: currentWidth, color: widget.color),
        ),
      ),
    );
  }
}

class _VolumePainter extends CustomPainter {
  final double activated;
  final Color color;
  _VolumePainter({required this.activated, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final maxHeight = size.height;
    final maxWidth = size.width;
    final h = maxHeight / 10;
    final gap = maxWidth / 20;
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    var paint2 = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 1; i <= 10; i++) {
      if (gap * 2 * i > activated) {
        canvas.drawRect(
            Rect.fromLTWH(gap * 2 * i, maxHeight - h * i, gap, h * i), paint);
      } else {
        canvas.drawRect(
            Rect.fromLTWH(gap * 2 * i, maxHeight - h * i, gap, h * i), paint2);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _VolumePainter oldDelegate) {
    return oldDelegate != this;
  }
}
