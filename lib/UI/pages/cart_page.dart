import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/components/details_bottom_navigation.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/widgets/box_chip_widget.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:GOCart/UI/widgets/head_section_widget.dart';
import 'package:GOCart/UI/widgets/icon_box_widget.dart';

import '../constants/constants.dart';
import '../utils/dimensions.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/emptyCart.png',
                  width: Dimensions.sizedBoxWidth100 * 3,
                ),
              ),
              SizedBox(
                height: Dimensions.sizedBoxHeight15 * 2,
              ),
              Center(
                child: Text(
                  'Cart is Empty',
                  style: TextStyle(fontSize: Dimensions.font20),
                ),
              ),
              SizedBox(
                height: Dimensions.sizedBoxHeight10,
              ),
              const Center(
                child: Text(
                  'Add products to cart to see them here',
                  style: TextStyle(color: Constants.grey),
                ),
              ),
            ],
          )
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadSedction(
                  text: 'CART SUMMARY',
                  weight: FontWeight.w500,
                  lMargin: Dimensions.sizedBoxWidth10 * 2,
                ),
                Container(
                  width: double.maxFinite,
                  color: Constants.white,
                  padding: EdgeInsets.only(
                      top: Dimensions.sizedBoxHeight15,
                      bottom: Dimensions.sizedBoxHeight10,
                      left: Dimensions.sizedBoxWidth10 * 2,
                      right: Dimensions.sizedBoxWidth10 * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Subtotal',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Dimensions.font14),
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight15,
                          ),
                          Text(
                            'Subtotal',
                            style: TextStyle(
                                fontSize: Dimensions.font12,
                                color:
                                    const Color.fromARGB(255, 137, 137, 137)),
                          ),
                        ],
                      ),
                      Text(
                        '\$ 1,000',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Dimensions.font16),
                      )
                    ],
                  ),
                ),
                HeadSedction(
                  text: 'CART (10)',
                  weight: FontWeight.w500,
                  lMargin: Dimensions.sizedBoxWidth10 * 2,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.sizedBoxWidth10,
                      right: Dimensions.sizedBoxWidth10,
                      bottom: Dimensions.sizedBoxHeight10),
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
                          margin: EdgeInsets.only(
                              bottom: Dimensions.sizedBoxHeight10),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tractor with wide rollers and high cost maintainence',
                                          style: TextStyle(
                                              fontSize: Dimensions.font12),
                                        ),
                                        SizedBox(
                                          height:
                                              Dimensions.sizedBoxHeight4 * 2,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Seller:',
                                              style: TextStyle(
                                                  fontSize: Dimensions.font12,
                                                  color: Constants.grey),
                                            ),
                                            SizedBox(
                                              width:
                                                  Dimensions.sizedBoxWidth4 / 2,
                                            ),
                                            Text(
                                              '\$1,000',
                                              style: TextStyle(
                                                  fontSize: Dimensions.font12),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              Dimensions.sizedBoxHeight4 * 2,
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
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                            SizedBox(
                                              width:
                                                  Dimensions.sizedBoxWidth10 /
                                                      2,
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
                                        Text(
                                          'In Stock',
                                          style: TextStyle(
                                              fontSize: Dimensions.font12,
                                              color: Constants.grey),
                                        ),
                                        SizedBox(
                                          height:
                                              Dimensions.sizedBoxHeight10 * 2,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      onTap: () => showDialog(
                                          context: context,
                                          builder: ((context) =>
                                              _showDialog(context))),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.sizedBoxWidth10,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconBox(
                                          icon: Icons.remove,
                                          width: Dimensions.sizedBoxWidth10 * 3,
                                          height:
                                              Dimensions.sizedBoxWidth10 * 3,
                                          color: Constants.tetiary,
                                          borderColor: Colors.transparent,
                                          iconSize: Dimensions.font24,
                                          iconColor: Constants.white,
                                          isDisabled: true,
                                          right: 0,
                                        ),
                                        SizedBox(
                                          width: Dimensions.sizedBoxWidth10 * 2,
                                        ),
                                        const Text(
                                          '1',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: Dimensions.sizedBoxWidth10 * 2,
                                        ),
                                        IconBox(
                                          icon: Icons.add,
                                          width: Dimensions.sizedBoxWidth10 * 3,
                                          height:
                                              Dimensions.sizedBoxWidth10 * 3,
                                          color: Constants.tetiary,
                                          borderColor: Colors.transparent,
                                          iconSize: Dimensions.font24,
                                          iconColor: Constants.white,
                                          isDisabled: false,
                                          right: 0,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        onTap: () => Timer(
                            const Duration(milliseconds: 100),
                            () => Get.toNamed(
                                RouteHelper.getProductDetailsPage())),
                      );
                    },
                  ),
                ),
                DetailsBottomNav(
                  leading: IconBox(
                    icon: Icons.phone,
                    height: Dimensions.sizedBoxHeight65,
                    width: Dimensions.sizedBoxWidth100 / 2,
                    borderColor: Constants.tetiary,
                    iconSize: Dimensions.sizedBoxWidth15 * 2,
                  ),
                  text: 'CHECKOUT (\$1,000)',
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10,
                ),
              ],
            ),
          );
  }

  Widget _showDialog(context) {
    // SnackBar(content: Text('content'));
    return Dialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10 * 2),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.sizedBoxWidth15 * 2,
            vertical: Dimensions.sizedBoxHeight10 * 2),
        height: Dimensions.sizedBoxHeight10 * 25,
        decoration: BoxDecoration(
            color: Constants.white,
            borderRadius: BorderRadius.circular(Dimensions.font25 / 5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Remove from cart',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: Dimensions.font20),
                ),
                GestureDetector(
                  child: const Icon(Icons.close),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10 * 2,
            ),
            Text(
              'Do you really want to remove this item from cart?',
              style: TextStyle(
                fontSize: Dimensions.font16,
              ),
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10 * 2,
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight100 / 2,
              width: double.maxFinite,
              child: const ElevatedBtn(
                text: 'SAVE FOR LATER',
                textColor: Constants.tetiary,
                isElevated: false,
                addBorder: true,
                icon: Icon(
                  Icons.favorite_border,
                  color: Constants.tetiary,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10,
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight100 / 2,
              width: double.maxFinite,
              child: const ElevatedBtn(
                text: 'REMOVE ITEM',
                icon: Icon(
                  Icons.delete_outline,
                  color: Constants.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
