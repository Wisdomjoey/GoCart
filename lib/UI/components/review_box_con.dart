import 'package:flutter/material.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/star_rating_widget.dart';

import '../../CONSTANTS/constants.dart';

class ReviewBoxCon extends StatelessWidget {
  final String date;
  final String topic;
  final String review;
  final String name;
  final bool addHPad;
  final double? rad;

  const ReviewBoxCon(
      {super.key,
      required this.date,
      required this.topic,
      required this.review,
      required this.name,
      this.addHPad = false,
      this.rad});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.sizedBoxHeight10,
          horizontal: addHPad ? Dimensions.sizedBoxWidth10 : 0),
      decoration: BoxDecoration(
          color: Constants.white,
          borderRadius: BorderRadius.circular(rad ?? 0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StarRating(),
              Text(
                date,
                style: TextStyle(
                    color: Constants.grey, fontSize: Dimensions.font12),
              )
            ],
          ),
          SizedBox(
            height: Dimensions.sizedBoxHeight10,
          ),
          Text(
            topic,
            style: TextStyle(
                fontSize: Dimensions.font14, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: Dimensions.sizedBoxHeight10,
          ),
          Text(
            review,
            style: TextStyle(fontSize: Dimensions.font12),
          ),
          SizedBox(
            height: Dimensions.sizedBoxHeight10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'by $name',
                style: TextStyle(
                    color: Constants.grey, fontSize: Dimensions.font12),
              ),
              Row(
                children: [
                  Icon(
                    Icons.task_alt,
                    color: Constants.primary,
                    size: Dimensions.font18,
                  ),
                  SizedBox(
                    width: Dimensions.sizedBoxWidth10 / 2,
                  ),
                  Text(
                    'Verified Purchase',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 107, 205, 110),
                        fontSize: Dimensions.font12),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
