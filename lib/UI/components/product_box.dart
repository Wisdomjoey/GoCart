import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CONSTANTS/constants.dart';
import '../routes/route_helper.dart';
import '../utils/dimensions.dart';
import '../widgets/star_rating_widget.dart';

class ProductBox extends StatelessWidget {
  final double? left;
  final double? right;
  final double? bottom;
  final List snapshotDocs;

  const ProductBox(
      {super.key,
      this.left,
      this.right,
      this.bottom,
      required this.snapshotDocs});

  @override
  Widget build(BuildContext context) {
    String currency = Constants(context).currency().currencySymbol;

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
        itemCount: snapshotDocs.length,
        itemBuilder: (context, index) {
          return _productsList(index, snapshotDocs[index], currency);
        },
      ),
    );
  }

  Widget _productsList(int index, Map<String, dynamic> product, String currency) {
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
            color: Constants.white,
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
                            image: CachedNetworkImageProvider(
                                product[Constants.imgUrls][0]),
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
                    color: Constants.white),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product[Constants.name],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: Dimensions.font13,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxHeight4,
                    ),
                    Text(
                      '$currency ${Constants.format.format(product[Constants.prodNewPrice])}',
                      style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxHeight4,
                    ),
                    StarRating(
                      rating: product[Constants.prodRating],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Timer(
              const Duration(milliseconds: 200),
              () => Get.toNamed(RouteHelper.getProductDetailsPage(),
                  arguments: product));
        },
      ),
    );
  }
}
