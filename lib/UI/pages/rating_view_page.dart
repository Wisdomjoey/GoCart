import 'package:flutter/material.dart';
import 'package:GOCart/UI/components/review_box_con.dart';
import 'package:GOCart/UI/components/home_app_bar.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/head_section_widget.dart';
import 'package:GOCart/UI/widgets/rate_number_widget.dart';
import 'package:GOCart/UI/widgets/star_rating_widget.dart';
import 'package:GOCart/UI/widgets/txt_button_widget.dart';
import 'package:intl/intl.dart';

import '../../CONSTANTS/constants.dart';

class RatingViewPage extends StatefulWidget {
  final List reviews;
  final double rating;

  const RatingViewPage(
      {super.key, required this.reviews, required this.rating});

  @override
  State<RatingViewPage> createState() => _RatingViewPageState();
}

class _RatingViewPageState extends State<RatingViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Verified Customer Feedback',
        showPopUp: true,
        showCart: true,
        textSize: Dimensions.font24,
        implyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadSedction(
                text: 'VERIFIED PRODUCT RATINGS (${widget.reviews.length})'),
            Container(
              width: double.maxFinite,
              color: Constants.white,
              padding: EdgeInsets.only(
                  top: Dimensions.sizedBoxHeight15,
                  bottom: Dimensions.sizedBoxHeight15,
                  left: Dimensions.sizedBoxWidth15),
              child: Row(
                children: [
                  Container(
                    width: Dimensions.sizedBoxWidth10 * 11,
                    height: Dimensions.sizedBoxWidth10 * 11,
                    decoration: BoxDecoration(
                        color: Constants.backgroundColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.font12 / 6)),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.rating.toString(),
                                style: TextStyle(
                                    color: Constants.tetiary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.font14 * 2),
                              ),
                              Text(
                                '/5',
                                style: TextStyle(
                                    color: Constants.tetiary,
                                    fontSize: Dimensions.font14 * 2),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight3,
                          ),
                          StarRating(
                            rating: widget.rating,
                            axis: MainAxisAlignment.center,
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight4 * 2,
                          ),
                          Text(
                            '${widget.reviews.length} ratings',
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.sizedBoxWidth15,
                  ),
                  Column(
                    children: [
                      RateNumber(
                        rateNo: '5',
                        rateCount: widget.reviews
                            .where((element) =>
                                element[Constants.reviewStarNo] == 5)
                            .length
                            .toString(),
                        value: widget.reviews
                                .where((element) =>
                                    element[Constants.reviewStarNo] == 5)
                                .length /
                            widget.reviews.length,
                      ),
                      RateNumber(
                        rateNo: '4',
                        rateCount: widget.reviews
                            .where((element) =>
                                element[Constants.reviewStarNo] == 4)
                            .length
                            .toString(),
                        value: widget.reviews
                                .where((element) =>
                                    element[Constants.reviewStarNo] == 4)
                                .length /
                            widget.reviews.length,
                      ),
                      RateNumber(
                        rateNo: '3',
                        rateCount: widget.reviews
                            .where((element) =>
                                element[Constants.reviewStarNo] == 3)
                            .length
                            .toString(),
                        value: widget.reviews
                                .where((element) =>
                                    element[Constants.reviewStarNo] == 3)
                                .length /
                            widget.reviews.length,
                      ),
                      RateNumber(
                        rateNo: '2',
                        rateCount: widget.reviews
                            .where((element) =>
                                element[Constants.reviewStarNo] == 2)
                            .length
                            .toString(),
                        value: widget.reviews
                                .where((element) =>
                                    element[Constants.reviewStarNo] == 2)
                                .length /
                            widget.reviews.length,
                      ),
                      RateNumber(
                        rateNo: '1',
                        rateCount: widget.reviews
                            .where((element) =>
                                element[Constants.reviewStarNo] == 1)
                            .length
                            .toString(),
                        value: widget.reviews
                                .where((element) =>
                                    element[Constants.reviewStarNo] == 1)
                                .length /
                            widget.reviews.length,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadSedction(
                      text:
                          'COMMENTS FROM VERIFIED PURCHASES (${widget.reviews.where((element) => element[Constants.name] != '').length})'),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.sizedBoxWidth4),
                    child: Column(
                      children: widget.reviews.map((e) {
                        return Column(
                          children: [
                            ReviewBoxCon(
                              date: DateFormat("yyyy-MM-dd")
                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(e[Constants.updatedAt])))
                                  .toString(),
                              topic: e[Constants.reviewTitle],
                              review: e[Constants.reviewBody],
                              name: e[Constants.name],
                              addHPad: true,
                              rad: Dimensions.sizedBoxWidth3,
                              rating: e[Constants.reviewStarNo].toDouble(),
                            ),
                            SizedBox(
                              height: Dimensions.sizedBoxHeight15 / 2,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const TxtButton(
                    text: 'READ MORE VIEWS',
                    visualD: -3,
                    addHPad: false,
                    color: Constants.tetiary,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
