import 'package:flutter/material.dart';

import '../../CONSTANTS/constants.dart';
import '../utils/dimensions.dart';

class BoxChip extends StatelessWidget {
  final Color color;
  final Color? textColor;
  final String text;
  final EdgeInsets? pad;
  final FontWeight? textWeight;
  final double? textSize;

  const BoxChip(
      {super.key,
      this.color = const Color.fromARGB(255, 107, 205, 110),
      required this.text,
      this.pad,
      this.textColor,
      this.textWeight,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: pad ??
          EdgeInsets.symmetric(
              horizontal: Dimensions.sizedBoxWidth4,
              vertical: Dimensions.sizedBoxHeight4 / 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4 / 2),
          color: color),
      child: Text(
        text,
        style: TextStyle(
            fontSize: textSize ?? Dimensions.font11,
            color: textColor ?? Constants.white,
            fontWeight: textWeight ?? FontWeight.w500),
      ),
    );
  }
}
