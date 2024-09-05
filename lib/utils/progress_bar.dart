import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tanachyomi/utils/appcolor.dart';

class ProgressPainter extends CustomPainter {
  Color defaultCircleColor;
  Color percentageCompletedCircleColor;
  double? completedPercentage;
  double? circleWidth;

  ProgressPainter(
      {required this.defaultCircleColor,
      required this.percentageCompletedCircleColor,
      this.completedPercentage,
      this.circleWidth});

  getPaint(Color color) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth!;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    Paint defualtCirclePaint = getPaint(defaultCircleColor);
    Paint progressCirclePaint = getPaint(percentageCompletedCircleColor);

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, defualtCirclePaint);

    double arcAngle = 2 * pi * (completedPercentage! / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, progressCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class Gradientbar extends CustomPainter {
  Color defaultCircleColor;
  Color percentageCompletedCircleColor;
  double? completedPercentage;
  double? circleWidth;

  Gradientbar(
      {required this.defaultCircleColor,
      required this.percentageCompletedCircleColor,
      this.completedPercentage,
      this.circleWidth});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);

    final gradient = new SweepGradient(
      startAngle: 3 * pi / 2,
      endAngle: 7 * pi / 2,
      tileMode: TileMode.repeated,
      colors: [
        percentageCompletedCircleColor,
        defaultCircleColor,
        percentageCompletedCircleColor
      ],
    );

    final fullCircle = new Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Color(0xFFdfe8f9)
      ..strokeWidth = circleWidth!;

    final shadow = new Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5)
      ..strokeWidth = circleWidth! - 4;

    final paint = new Paint()
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth!;

    final circlepaint = new Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = AppColor.progressbar
      ..strokeWidth = circleWidth!;

    final center = new Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - (circleWidth! / 2);
    final startAngle = pi / 2;
    final endAngle = -pi / 2;
    final sweepAngle = -2 * pi * completedPercentage!;
    final sweepAngle1 = -pi * completedPercentage!;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        360, false, fullCircle);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle + 1, false, /*circlepaint*/ paint);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle + 0.09, false, shadow);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, circlepaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
