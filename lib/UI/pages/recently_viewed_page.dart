import 'dart:async';

import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/home_app_bar.dart';
import '../../CONSTANTS/constants.dart';
import '../routes/route_helper.dart';
import '../utils/dimensions.dart';
import '../widgets/box_chip_widget.dart';

class RecentlyViewedPage extends StatelessWidget {
  const RecentlyViewedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Recently Viewed',
        showCart: true,
        implyLeading: true,
        textSize: Dimensions.font24,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Center(
            //   child: Image.asset(
            //     'assets/images/view.png',
            //     width: Dimensions.sizedBoxWidth100 * 3,
            //   ),
            // ),
            // SizedBox(
            //   height: Dimensions.sizedBoxWidth15 * 2,
            // ),
            // const Center(
            //   child: Text(
            //     'You haven\'t viewed any item recently',
            //     style: TextStyle(color: Constants.grey),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.all(Dimensions.sizedBoxHeight10),
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        EdgeInsets.only(bottom: Dimensions.sizedBoxHeight10),
                    child: InkWell(
                      onTap: () => Timer(
                          const Duration(milliseconds: 200),
                          () =>
                              Get.toNamed(RouteHelper.getProductDetailsPage())),
                      child: Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.sizedBoxWidth10 / 2),
                            color: Constants.white),
                        padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Ink(
                                    width: double.maxFinite,
                                    height: Dimensions.sizedBoxHeight100,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/build.jpg'),
                                            fit: BoxFit.contain)),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.sizedBoxWidth10,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tractor with wide rollers and high cost maintainence',
                                        style: TextStyle(
                                            fontSize: Dimensions.font12),
                                      ),
                                      SizedBox(
                                        height: Dimensions.sizedBoxHeight4 * 2,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$1,000',
                                            style: TextStyle(
                                                fontSize: Dimensions.font16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          BoxChip(
                                            text: '-20%',
                                            pad: EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.sizedBoxWidth4,
                                              vertical:
                                                  Dimensions.sizedBoxHeight3 *
                                                      2,
                                            ),
                                            textSize: Dimensions.font14,
                                            textWeight: FontWeight.w600,
                                            color: const Color.fromARGB(
                                                35, 248, 194, 0),
                                            textColor: Constants.tetiary,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.sizedBoxHeight4 * 2,
                                      ),
                                      Text(
                                        '\$1,500',
                                        style: TextStyle(
                                            fontSize: Dimensions.font12,
                                            color: const Color.fromARGB(
                                                255, 98, 98, 98),
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                SizedBox(
                                  width: Dimensions.sizedBoxWidth148,
                                  height: Dimensions.sizedBoxHeight10 * 4,
                                  child: ElevatedBtn(text: 'ADD TO CART'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
