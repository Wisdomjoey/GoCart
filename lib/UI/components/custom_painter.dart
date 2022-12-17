import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../utils/dimensions.dart';

class CurvedPainter extends StatelessWidget with PreferredSizeWidget {
  final String text1;
  final String text2;
  const CurvedPainter({super.key, required this.text1, required this.text2});

  @override
  Size get preferredSize => Size.fromHeight(Dimensions.sizedBoxHeight100 * 2.5);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(
                Dimensions.screenWidth, Dimensions.sizedBoxHeight100 * 2.5),
            painter: CustomCurvedPainter(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.sizedBoxHeight10 * 7,
                  left: Dimensions.sizedBoxWidth10 * 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: TextStyle(
                        fontSize: Dimensions.font13 * 3,
                        color: const Color(0XFFF8C300),
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    text2,
                    style: TextStyle(
                        fontSize: Dimensions.font13 * 3,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomCurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        [const Color(0XFF00923F), const Color.fromARGB(255, 1, 191, 84)]);

    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height / 1.25);
    path.quadraticBezierTo(
        size.width / 4,
        size.height,
        (size.width / 2) - (size.width / (size.width / 10)),
        size.height / 1.25);
    path.quadraticBezierTo(
        (size.width / 4) * 3,
        size.height / 1.923076923076923,
        size.width,
        size.height / 1.388888888888889);
    path.lineTo(size.width, 0);
    // path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
