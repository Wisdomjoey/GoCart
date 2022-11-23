import 'package:flutter/material.dart';
import 'package:schoolproj/utils/dimensions.dart';

class HeadSedction extends StatelessWidget {
  final String text;
  final double? textSize;
  final FontWeight weight;

  const HeadSedction(
      {super.key,
      required this.text,
      this.textSize,
      this.weight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.sizedBoxHeight10 * 2, bottom: Dimensions.sizedBoxHeight10, left: Dimensions.sizedBoxWidth10),
      child: Text(text,
          style: TextStyle(
              fontSize: textSize ?? Dimensions.font12,
              color: Colors.grey,
              fontWeight: weight)),
    );
  }
}
