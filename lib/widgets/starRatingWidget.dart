import 'package:flutter/material.dart';
import 'package:schoolproj/utils/dimensions.dart';

class StarRating extends StatelessWidget {
  const StarRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [1, 2, 3, 4, 5]
          .map((e) => Icon(
                Icons.star_rate_rounded,
                color: const Color(0XFFF8C300),
                size: Dimensions.font16,
              ))
          .toList(),
    );
  }
}
