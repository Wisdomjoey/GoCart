import 'package:flutter/material.dart';
import 'package:schoolproj/utils/dimensions.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
                color: const Color(0XFFF8C300),
                size: Dimensions.font16,
              ),
              SizedBox(
                width: Dimensions.sizedBoxWidth3,
              ),
              Text(
                '($rateCount)',
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        LinearPercentIndicator(
          lineHeight: Dimensions.sizedBoxHeight4,
          backgroundColor: const Color.fromARGB(255, 243, 243, 243),
          width: Dimensions.sizedBoxWidth10 * 12,
          progressColor: const Color(0XFFF8C300),
          percent: value,
        )
      ],
    );
  }
}
