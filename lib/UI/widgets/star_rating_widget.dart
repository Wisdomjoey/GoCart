import 'package:flutter/material.dart';
import 'package:GOCart/UI/utils/dimensions.dart';

import '../../CONSTANTS/constants.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final MainAxisAlignment? axis;

  const StarRating({super.key, required this.rating, this.axis});

  @override
  Widget build(BuildContext context) {
    int filled = rating.truncate();
    int half = (rating - filled).ceil();
    int empty = 5 - rating.ceil();

    return Row(
      mainAxisAlignment: axis ?? MainAxisAlignment.start,
      children: [
        ...List.generate(
            filled,
            (index) => Icon(
                  Icons.star_rounded,
                  color: Constants.tetiary,
                  size: Dimensions.font16,
                )),
        ...List.generate(
            half,
            (index) => Icon(
                  Icons.star_half_rounded,
                  color: Constants.tetiary,
                  size: Dimensions.font16,
                )),
        ...List.generate(
            empty,
            (index) => Icon(
                  Icons.star_outline_rounded,
                  color: Constants.grey,
                  size: Dimensions.font16,
                ))
      ],
    );
  }
}
