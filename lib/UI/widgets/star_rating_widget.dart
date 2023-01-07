import 'package:flutter/material.dart';
import 'package:GOCart/UI/utils/dimensions.dart';

import '../../CONSTANTS/constants.dart';

class StarRating extends StatelessWidget {
  const StarRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [1, 2, 3, 4, 5]
          .map((e) => Icon(
                Icons.star_rate_rounded,
                color: Constants.tetiary,
                size: Dimensions.font16,
              ))
          .toList(),
    );
  }
}
