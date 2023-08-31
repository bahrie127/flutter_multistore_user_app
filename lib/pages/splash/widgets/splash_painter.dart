import 'package:flutter/material.dart';

import '../../../utils/color_resources.dart';

class SplashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = ColorResources.lightSkyBlue.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;
    var path = Path();

    path.moveTo(0, size.height * 0.375);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.25,
        size.width * 0.65, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.65,
        size.width * 1.0, size.height * 0.60);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
