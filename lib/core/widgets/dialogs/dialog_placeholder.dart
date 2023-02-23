// import 'dart:ui' as ui;
//
// import 'package:flutter/cupertino.dart';
//
// //Add this CustomPaint widget to the Widget Tree
// CustomPaint(
// size: Size(WIDTH, (WIDTH*0.8391167192429022).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
// painter: RPSCustomPainter(),
// )
//
// //Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';

class DialogPlaceholder extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9022082, size.height * 0.1814485);
    path_0.cubicTo(
        size.width * 0.9022082,
        size.height * 0.1145680,
        size.width * 0.8536498,
        size.height * 0.06238045,
        size.width * 0.7978297,
        size.height * 0.06926541);
    path_0.lineTo(size.width * 0.1448312, size.height * 0.1498083);
    path_0.cubicTo(
        size.width * 0.09659432,
        size.height * 0.1557583,
        size.width * 0.05993691,
        size.height * 0.2041989,
        size.width * 0.05993691,
        size.height * 0.2619910);
    path_0.lineTo(size.width * 0.05993691, size.height * 0.7669173);
    path_0.cubicTo(
        size.width * 0.05993691,
        size.height * 0.8292068,
        size.width * 0.1023076,
        size.height * 0.8796992,
        size.width * 0.1545741,
        size.height * 0.8796992);
    path_0.lineTo(size.width * 0.8075710, size.height * 0.8796992);
    path_0.cubicTo(
        size.width * 0.8598391,
        size.height * 0.8796992,
        size.width * 0.9022082,
        size.height * 0.8292068,
        size.width * 0.9022082,
        size.height * 0.7669173);
    path_0.lineTo(size.width * 0.9022082, size.height * 0.1814485);
    path_0.close();

    // Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    // paint_0_fill.color = Colors.white.withOpacity(1.0);
    // canvas.drawPath(path_0,paint_0_fill);
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
