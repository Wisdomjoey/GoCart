import 'package:flutter/material.dart';
import 'package:schoolproj/components/ReviewBoxCon.dart';
import 'package:schoolproj/components/homeAppBar.dart';
import 'package:schoolproj/utils/dimensions.dart';
import 'package:schoolproj/widgets/headSectionWidget.dart';
import 'package:schoolproj/widgets/rateNumberWidget.dart';
import 'package:schoolproj/widgets/starRatingWidget.dart';
import 'package:schoolproj/widgets/txtButtonWidget.dart';

class RatingViewPage extends StatelessWidget {
  const RatingViewPage({super.key});

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
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadSedction(text: 'VERIFIED PRODUCT RATINGS (13)'),
            Container(
              width: double.maxFinite,
              color: Colors.white,
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
                        color: const Color.fromARGB(255, 243, 243, 243),
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
                                '4.9',
                                style: TextStyle(
                                    color: const Color(0XFFF8C300),
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.font14 * 2),
                              ),
                              Text(
                                '/5',
                                style: TextStyle(
                                    color: const Color(0XFFF8C300),
                                    fontSize: Dimensions.font14 * 2),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight3,
                          ),
                          const StarRating(),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight4 * 2,
                          ),
                          const Text(
                            '13 ratings',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.sizedBoxWidth15,
                  ),
                  Column(
                    children: const [
                      RateNumber(
                        rateNo: '5',
                        rateCount: '5',
                        value: 0.4,
                      ),
                      RateNumber(
                        rateNo: '5',
                        rateCount: '5',
                        value: 0.8,
                      ),
                      RateNumber(
                        rateNo: '5',
                        rateCount: '5',
                        value: 0.5,
                      ),
                      RateNumber(
                        rateNo: '5',
                        rateCount: '5',
                        value: 0.3,
                      ),
                      RateNumber(
                        rateNo: '5',
                        rateCount: '5',
                        value: 0.2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.sizedBoxWidth4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadSedction(
                      text: 'COMMENTS FROM VERIFIED PURCHASES (26)'),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.sizedBoxWidth4),
                    child: Column(
                      children: [
                        ReviewBoxCon(
                            date: '21-11-2022',
                            topic: 'Status',
                            review:
                                'A very good product for public use, I recommend to all.',
                            name: 'Jay Z',
                            addHPad: true,
                            rad: Dimensions.sizedBoxWidth3,
                        ),
                        SizedBox(
                          height: Dimensions.sizedBoxHeight15 / 2,
                        ),
                        ReviewBoxCon(
                            date: '21-11-2022',
                            topic: 'Status',
                            review:
                                'A very good product for public use, I recommend to all.',
                            name: 'Jay Z',
                            addHPad: true,
                            rad: Dimensions.sizedBoxWidth3,
                        ),
                        SizedBox(
                          height: Dimensions.sizedBoxHeight15 /2,
                        ),
                        ReviewBoxCon(
                            date: '21-11-2022',
                            topic: 'Status',
                            review:
                                'A very good product for public use, I recommend to all.',
                            name: 'Jay Z',
                            addHPad: true,
                            rad: Dimensions.sizedBoxWidth3,
                        ),
                      ],
                    ),
                  ),
                  const TxtButton(
                    text: 'READ MORE VIEWS',
                    visualD: -3,
                    addHPad: false,
                    color: Color(0XFFF8C300),
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
