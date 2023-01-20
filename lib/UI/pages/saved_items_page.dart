import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/home_app_bar.dart';
import '../../CONSTANTS/constants.dart';
import '../routes/route_helper.dart';
import '../utils/dimensions.dart';
import '../widgets/box_chip_widget.dart';
import '../widgets/elevated_button_widget.dart';
import '../widgets/icon_box_widget.dart';

class SavedItemsPage extends StatelessWidget {
  const SavedItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Saved Items',
        showCart: true,
        implyLeading: true,
        textSize: Dimensions.font24,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Center(
            //   child: Icon(
            //     Icons.favorite,
            //     size: Dimensions.sizedBoxWidth25 * 6,
            //     color: const Color.fromARGB(255, 186, 186, 186),
            //   ),
            // ),
            // SizedBox(
            //   height: Dimensions.sizedBoxWidth15 * 2,
            // ),
            // Center(
            //   child: Text(
            //     'You don\'t have any saved items',
            //     style:
            //         TextStyle(color: Constants.grey, fontSize: Dimensions.font16),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.all(Dimensions.sizedBoxHeight10),
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.sizedBoxWidth10 / 2),
                          color: Constants.white),
                      padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                      margin:
                          EdgeInsets.only(bottom: Dimensions.sizedBoxHeight10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
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
                                      style:
                                          TextStyle(fontSize: Dimensions.font12),
                                    ),
                                    SizedBox(
                                      height: Dimensions.sizedBoxHeight4 * 2,
                                    ),
                                    Text(
                                      '\$1,000',
                                      style: TextStyle(
                                          fontSize: Dimensions.font16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
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
                                        SizedBox(
                                          width: Dimensions.sizedBoxWidth10 / 2,
                                        ),
                                        BoxChip(
                                          text: '-20%',
                                          pad: EdgeInsets.symmetric(
                                            horizontal: Dimensions.sizedBoxWidth4,
                                            vertical:
                                                Dimensions.sizedBoxHeight3 * 2,
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
                                      height: Dimensions.sizedBoxHeight10 * 2,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.delete_outline,
                                        color: Constants.tetiary,
                                      ),
                                      SizedBox(
                                        width: Dimensions.sizedBoxWidth10,
                                      ),
                                      Text(
                                        'REMOVE',
                                        style: TextStyle(
                                            color: Constants.tetiary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: Dimensions.font15),
                                      )
                                    ],
                                  ),
                                  onTap: (() {
                                    
                                  }),
                                ),
                              ),
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
                    onTap: () => Timer(const Duration(milliseconds: 200),
                        () => Get.toNamed(RouteHelper.getProductDetailsPage())),
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
