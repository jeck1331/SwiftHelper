import 'package:flutter/material.dart';
import 'dart:math';

import '../../../constants/constant_colors.dart';
import '../models/pie_item.dart';

class BaseChartPainter extends CustomPainter {
  num sum = 0;
  final List<PieItem> categories;
  final double radius;

  BaseChartPainter({required this.categories, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    List<Paint> paints = List.generate(
        categories.length,
        (index) => Paint()
          ..style = PaintingStyle.fill
          ..color = categories[index].color);

    var fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = ConstantColors.mainBgColor;

    Offset center = Offset(size.width / 2, size.height / 2);
    Rect rect = Rect.fromCircle(center: center, radius: radius);

    sum = 0;
    for (var element in categories) {
      sum += element.sum;
    }

    double startAngle = -pi / 2;
    double endAngle = 0.0;

    for (int i = 0; i < categories.length; i++) {
      endAngle = startAngle + 2 * pi * categories[i].sum / sum;

      canvas.drawArc(rect, startAngle, endAngle - startAngle, true, paints[i]);

      startAngle = endAngle;
    }

    canvas.drawCircle(center, radius - 40, fillPaint);
    drawTextCentered(canvas, center, sum.toString(), const TextStyle(fontSize: 20), 150 * 0.6);
  }

  TextPainter measureText(
      String s, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter(
        text: span, textAlign: align, textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  Size drawTextCentered(Canvas canvas, Offset position, String text,
      TextStyle style, double maxWidth) {
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    final pos = position + Offset(-tp.width / 2.0, -tp.height / 2.0);

    tp.paint(canvas, pos);
    return tp.size;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
