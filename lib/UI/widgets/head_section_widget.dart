import 'package:flutter/material.dart';
import 'package:GOCart/UI/utils/dimensions.dart';

class HeadSedction extends StatelessWidget {
  final String text;
  final double? textSize;
  final double? lMargin;
  final double? tMargin;
  final double? bMargin;
  final FontWeight weight;

  const HeadSedction(
      {super.key,
      required this.text,
      this.textSize,
      this.weight = FontWeight.w600,
      this.lMargin, this.tMargin, this.bMargin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: tMargin ?? Dimensions.sizedBoxHeight10 * 2,
          bottom: bMargin ?? Dimensions.sizedBoxHeight10,
          left: lMargin ?? Dimensions.sizedBoxWidth10),
      child: Text(text,
          style: TextStyle(
              fontSize: textSize ?? Dimensions.font12,
              color: const Color.fromARGB(255, 130, 130, 130),
              fontWeight: weight)),
    );
  }
}
