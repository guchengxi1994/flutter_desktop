import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minesweeper/src/view/static.dart';

import '../models/minefield_highlight.dart';
import '../models/minesweeper_cell.dart';
import '../models/position.dart';

class GameBoard extends StatefulWidget {
  final double cellSize;
  final List<List<MinesweeperCell>> field;
  final MinefieldHighlight modifier;
  final bool finished;

  final void Function(IntPos)? onTap;
  final void Function(IntPos)? onSecondaryTap;
  final void Function()? onTapUp;
  final void Function(IntPos)? onTapDown;

  const GameBoard({
    Key? key,
    required this.field,
    required this.modifier,
    this.cellSize = 20,
    this.onTap,
    this.onSecondaryTap,
    this.onTapUp,
    this.onTapDown,
    this.finished = false,
  }) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  IntPos cursorPos = const IntPos(-1, -1);
  ui.Image? flagImage;
  ui.Image? mineImage;

  IntPos _getCellPos(Offset pos) {
    var x = (pos.dx / widget.cellSize).floor();
    var y = (pos.dy / widget.cellSize).floor();
    return IntPos(x, y); // todo math max and min
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  @override
  void initState() {
    super.initState();

    loadFlag().then((result) => setState(() => mineImage = result));
    loadMine().then((result) => setState(() => flagImage = result));
  }

  loadFlag() async {
    Uint8List bytes = dataFromBase64String(flagB64String);
    ui.Codec codec = await ui.instantiateImageCodec(bytes);
    return (await codec.getNextFrame()).image;
  }

  loadMine() async {
    Uint8List bytes = dataFromBase64String(mineB64Str);
    ui.Codec codec = await ui.instantiateImageCodec(bytes);
    return (await codec.getNextFrame()).image;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          cursorPos = _getCellPos(details.localPosition);
        });

        widget.onTapDown?.call(cursorPos);
      },
      onTapCancel: () {
        widget.onTapUp?.call();
      },
      onTapUp: (details) {
        var pos = _getCellPos(details.localPosition);

        if (cursorPos.x == pos.x && cursorPos.y == pos.y) {
          widget.onTap?.call(cursorPos);
        }
        widget.onTapUp?.call();
      },
      onSecondaryTapDown: (details) {
        var cellPos = _getCellPos(details.localPosition);
        widget.onSecondaryTap?.call(cellPos);
      },
      child: CustomPaint(
          isComplex: true,
          size: Size(
            widget.cellSize * widget.field.length,
            widget.cellSize * widget.field[0].length,
          ),
          painter: MineSweeperFieldPainter(
            mineImage: mineImage,
            flagImage: flagImage,
            field: widget.field,
            modifier: widget.modifier,
            finished: widget.finished,
            squareSize: widget.cellSize,
            fillColor: const Color(0xFFc4c4c4),
            fillDarkColor: const Color(0xff979797),
          )),
    );
  }
}

class MineSweeperFieldPainter extends CustomPainter {
  static List<Color> numberColors = [
    Colors.black,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.deepPurple,
    Colors.deepOrange,
    Colors.teal,
    Colors.lightGreen,
    Colors.lime,
    Colors.black,
  ];

  ui.Image? flagImage;
  ui.Image? mineImage;
  final bool finished;
  final List<List<MinesweeperCell>> field;
  final MinefieldHighlight modifier;
  final double squareSize;
  final Color fillColor;
  final Color fillDarkColor;

  MineSweeperFieldPainter({
    required this.finished,
    required this.modifier,
    required this.field,
    this.flagImage,
    this.mineImage,
    this.squareSize = 20.0,
    required this.fillColor,
    required this.fillDarkColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        paint..color = fillDarkColor);

    for (int i = 0; i < field.length; i++) {
      for (int j = 0; j < field[i].length; j++) {
        var cell = modifier.check(i, j, field[i][j]);
        drawCell(
            canvas,
            Rect.fromLTWH(
                squareSize * i, squareSize * j, squareSize, squareSize),
            cell);
      }
    }
  }

  void drawCell(Canvas canvas, Rect rect, MinesweeperCell cell) {
    var paint = Paint();

    var border = 1;
    var innerRect = Rect.fromLTRB(
      rect.left + border,
      rect.top + border,
      rect.right - border,
      rect.bottom - border,
    );
    canvas.drawRect(innerRect, paint..color = fillColor);

    if (finished) {
      if (cell.isMarked) {
        drawMarked(canvas, rect, !cell.hasMine);
        return;
      }

      if (cell.hasMine) {
        drawBomb(canvas, rect, cell.isOpened);
        return;
      }

      if (cell.isOpened) {
        drawOpened(canvas, rect, cell.bombsAround);
        return;
      }

      drawClosed(canvas, rect);
      return;
    }

    if (!cell.isPressed && !cell.isOpened || cell.isMarked) {
      if (cell.isMarked) {
        drawMarked(canvas, rect, false);
        return;
      }
      drawClosed(canvas, rect);
      return;
    }

    if (cell.isOpened) {
      if (cell.hasMine) {
        drawBomb(canvas, rect, false);
      }
      drawOpened(canvas, rect, cell.bombsAround);
    }

    // draw nothing, empty open cell
  }

  void drawOpened(Canvas canvas, Rect rect, int bombsAround) {
    if (bombsAround > 0) {
      TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);

      textPainter.text = TextSpan(
          // todo don't make this obj every cell
          text: bombsAround.toString(),
          style: TextStyle(
            fontSize: squareSize,
            fontWeight: FontWeight.bold,
            color: numberColors[bombsAround],
          ));
      textPainter.layout(minWidth: 0, maxWidth: squareSize);
      textPainter.paint(canvas, Offset(rect.left + 4, rect.top - 1));
    }
  }

  void drawClosed(Canvas canvas, Rect rect) {
    const borderRadius = 2;

    var paint = Paint();

    var highlight = Path();

    highlight.moveTo(rect.left, rect.top);
    highlight.lineTo(rect.right, rect.top);
    highlight.lineTo(rect.right - borderRadius, rect.top + borderRadius);
    highlight.lineTo(rect.left + borderRadius, rect.top + borderRadius);
    highlight.lineTo(rect.left + borderRadius, rect.bottom - borderRadius);
    highlight.lineTo(rect.left, rect.bottom);

    var shadow = Path();

    shadow.moveTo(rect.right, rect.bottom);
    shadow.lineTo(rect.left, rect.bottom);
    shadow.lineTo(rect.left + borderRadius, rect.bottom - borderRadius);
    shadow.lineTo(rect.right - borderRadius, rect.bottom - borderRadius);
    shadow.lineTo(rect.right - borderRadius, rect.top + borderRadius);
    shadow.lineTo(rect.right, rect.top);

    canvas.drawPath(highlight, paint..color = Colors.grey[50]!);
    canvas.drawPath(shadow, paint..color = Colors.grey[600]!);
  }

  void drawMarked(Canvas canvas, Rect rect, bool wrong) {
    if (wrong) {
      canvas.drawRect(rect, Paint()..color = Colors.redAccent.withOpacity(0.3));
    }

    drawClosed(canvas, rect);

    if (flagImage != null) {
      paintImage(
        canvas: canvas,
        rect: rect,
        image: flagImage!,
        fit: BoxFit.scaleDown,
      );
    }
  }

  void drawBomb(Canvas canvas, Rect rect, bool wrong) {
    if (wrong) {
      canvas.drawRect(rect, Paint()..color = Colors.redAccent);
    }

    if (mineImage != null) {
      paintImage(
        canvas: canvas,
        rect: rect,
        image: mineImage!,
        fit: BoxFit.scaleDown,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
