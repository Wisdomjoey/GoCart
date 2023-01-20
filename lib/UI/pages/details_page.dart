import 'package:flutter/material.dart';
import 'package:GOCart/UI/components/home_app_bar.dart';
import 'package:GOCart/UI/utils/dimensions.dart';

import '../../CONSTANTS/constants.dart';

class DetailsPage extends StatelessWidget {
  final String description;
  final List features;
  final List specifications;
  
  const DetailsPage({super.key, required this.description, required this.features, required this.specifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Product Details',
        textSize: Dimensions.font23,
        implyLeading: true,
        showPopUp: true,
        showCart: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              color: Constants.white,
              margin: EdgeInsets.only(top: Dimensions.sizedBoxHeight10),
              padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10,
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: Dimensions.font12),
                  ),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Constants.white,
                  borderRadius:
                      BorderRadius.circular(Dimensions.sizedBoxWidth4)),
              margin: EdgeInsets.all(Dimensions.sizedBoxWidth10),
              padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Key Features',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: features
                        .map((e) => Text(
                              '- $e',
                              style: TextStyle(fontSize: Dimensions.font12),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Constants.white,
                  borderRadius: BorderRadius.circular(4)),
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
              padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Specifications',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: specifications
                        .map((e) => (Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '- $e',
                                  style: TextStyle(
                                      fontSize: Dimensions.font12),
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight10 / 2,
                                )
                              ],
                            )))
                        .toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
