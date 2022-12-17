import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/route_helper.dart';
import '../utils/dimensions.dart';
import '../widgets/star_rating_widget.dart';

class ProductBox extends StatelessWidget {
  final double? left;
  final double? right;
  final double? bottom;
  const ProductBox({super.key, this.left, this.right, this.bottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: left ?? Dimensions.sizedBoxWidth10,
          right: right ?? Dimensions.sizedBoxWidth10,
          bottom: bottom ?? Dimensions.sizedBoxHeight10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: Dimensions.sizedBoxHeight10 * 2,
            crossAxisSpacing: Dimensions.sizedBoxWidth10,
            childAspectRatio: 0.7),
        itemCount: 20,
        itemBuilder: (context, index) {
          return _productsList(index);
        },
      ),
    );
  }

  Widget _productsList(int index) {
    return Material(
      animationDuration: const Duration(milliseconds: 100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
      ),
      elevation: 5,
      shadowColor: const Color.fromARGB(125, 0, 0, 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                  child: Ink(
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: index.isEven
                                ? const AssetImage('assets/images/1.jpg')
                                : const AssetImage('assets/images/build.jpg'),
                            fit: BoxFit.contain)),
                  ),
                ),
              ),
              Ink(
                padding: EdgeInsets.only(
                    left: Dimensions.sizedBoxWidth10,
                    right: Dimensions.sizedBoxWidth10,
                    bottom: Dimensions.sizedBoxHeight10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Dimensions.sizedBoxWidth4),
                        bottomRight:
                            Radius.circular(Dimensions.sizedBoxWidth4)),
                    color: Colors.white),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tractor with wide rollers and high maintainence',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: Dimensions.font13,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxHeight4,
                    ),
                    Text(
                      '\$ 8000',
                      style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxHeight4,
                    ),
                    const StarRating(),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Timer(const Duration(milliseconds: 200),
              () => Get.toNamed(RouteHelper.getProductDetailsPage()));
        },
      ),
    );
  }
}
