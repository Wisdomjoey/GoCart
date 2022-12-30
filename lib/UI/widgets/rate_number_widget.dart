import 'package:flutter/material.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants/constants.dart';

class RateNumber extends StatelessWidget {
  final String rateNo;
  final String rateCount;
  final double value;

  const RateNumber(
      {super.key,
      required this.rateNo,
      required this.rateCount,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Row(
            children: [
              Text(rateNo),
              SizedBox(
                width: Dimensions.sizedBoxWidth3,
              ),
              Icon(
                Icons.star_rate_rounded,
                color: Constants.tetiary,
                size: Dimensions.font16,
              ),
              SizedBox(
                width: Dimensions.sizedBoxWidth3,
              ),
              Text(
                '($rateCount)',
                style: const TextStyle(color: Constants.grey),
              )
            ],
          ),
        ),
        LinearPercentIndicator(
          lineHeight: Dimensions.sizedBoxHeight4,
          backgroundColor: Constants.backgroundColor,
          width: Dimensions.sizedBoxWidth10 * 12,
          progressColor: Constants.tetiary,
          percent: value,
        )
      ],
    );
  }
}
