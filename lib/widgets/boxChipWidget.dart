import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class BoxChip extends StatelessWidget {
  final Color color;
  final String text;

  const BoxChip({super.key, this.color = const Color.fromARGB(255, 107, 205, 110), required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.sizedBoxWidth4,
          vertical: Dimensions.sizedBoxHeight4 / 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4 / 2),
          color: color),
      child: Text(
        text,
        style: TextStyle(
            fontSize: Dimensions.font11,
            color: Colors.white,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
