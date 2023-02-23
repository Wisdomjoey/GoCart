import 'dart:async';

import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:GOCart/UI/pages/add_review_page.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/box_chip_widget.dart';
import 'package:GOCart/UI/widgets/head_section_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/home_app_bar.dart';
import '../../CONSTANTS/constants.dart';
import '../routes/route_helper.dart';

class OrderDetailsPage extends StatelessWidget {
  final Color color;
  final String text;
  final Map<String, dynamic> data;

  const OrderDetailsPage(
      {super.key, required this.color, required this.text, required this.data});

  @override
  Widget build(BuildContext context) {
    String currency = Constants(context).currency().currencySymbol;
    DateTime date = DateTime.parse(DateTime.fromMillisecondsSinceEpoch(int.parse(data[Constants.createdAt])).toString());

    return Scaffold(
      appBar: HomeAppBar(
        title: 'Order Details',
        showCart: true,
        implyLeading: true,
        textSize: Dimensions.font24,
      ),
      body: FutureBuilder(
        future: Future.wait([
          Provider.of<ProductProvider>(context, listen: false)
              .getProductData(data[Constants.productId]),
          Provider.of<ProductProvider>(context, listen: false)
              .fetchAllReviews(data[Constants.productId])
        ]),
        builder: (context, AsyncSnapshot<List> snapshot) {
          List revs = [];

          if (snapshot.hasData) {
            if (snapshot.data![1].isNotEmpty) {
              revs = snapshot.data![1]
                  .where((element) =>
                      element[Constants.userId] ==
                      FirebaseAuth.instance.currentUser!.uid)
                  .elementAt(0);
            }
          }

          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(color: Constants.tetiary),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.sizedBoxWidth15,
                            vertical: Dimensions.sizedBoxHeight10),
                        margin:
                            EdgeInsets.only(top: Dimensions.sizedBoxHeight10),
                        color: Constants.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order ${data[Constants.orderId]}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Dimensions.font14),
                            ),
                            SizedBox(
                              height: Dimensions.sizedBoxHeight3 * 2,
                            ),
                            Text(
                              DateFormat('d-M-y').format(date),
                              style: TextStyle(
                                  fontSize: Dimensions.font12,
                                  color:
                                      const Color.fromARGB(255, 138, 138, 138)),
                            ),
                            SizedBox(
                              height: Dimensions.sizedBoxHeight10 / 5,
                            ),
                            Text(
                              'No of items: ${data[Constants.quantity]}',
                              style: TextStyle(
                                  fontSize: Dimensions.font12,
                                  color:
                                      const Color.fromARGB(255, 138, 138, 138)),
                            ),
                            SizedBox(
                              height: Dimensions.sizedBoxHeight10 / 5,
                            ),
                            Text(
                              'Total: $currency${Constants.format.format(data[Constants.amount])}',
                              style: TextStyle(
                                  fontSize: Dimensions.font12,
                                  color:
                                      const Color.fromARGB(255, 138, 138, 138)),
                            ),
                          ],
                        ),
                      ),
                      HeadSedction(
                        text: 'ITEMS IN YOUR ORDER',
                        weight: FontWeight.w500,
                        textSize: Dimensions.font12,
                        lMargin: Dimensions.sizedBoxWidth10 * 2,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: Dimensions.sizedBoxWidth10,
                            right: Dimensions.sizedBoxWidth10),
                        child: Material(
                          borderRadius:
                              BorderRadius.circular(Dimensions.sizedBoxWidth4),
                          animationDuration: const Duration(milliseconds: 100),
                          child: InkWell(
                            splashFactory: InkRipple.splashFactory,
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.sizedBoxWidth4),
                                color: Constants.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Ink(
                                    padding: EdgeInsets.all(
                                        Dimensions.sizedBoxWidth4 * 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BoxChip(
                                          text: text,
                                          color: color,
                                        ),
                                        SizedBox(
                                          height: Dimensions.sizedBoxHeight10,
                                        ),
                                        Text(
                                          'On ${DateFormat('d-M').format(date)}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: Dimensions.font14),
                                        )
                                      ],
                                    ),
                                  ),
                                  Ink(
                                    width: double.maxFinite,
                                    height: 1,
                                    color: Constants.lightGrey,
                                  ),
                                  Ink(
                                    height: Dimensions.sizedBoxHeight10 * 11,
                                    padding: EdgeInsets.all(
                                        Dimensions.sizedBoxWidth10),
                                    child: Row(
                                      children: [
                                        Ink(
                                          width: Dimensions.sizedBoxWidth100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          data[Constants
                                                              .imgUrl]),
                                                  fit: BoxFit.contain)),
                                        ),
                                        SizedBox(
                                          width: Dimensions.sizedBoxWidth10,
                                        ),
                                        Expanded(
                                          child: Ink(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(data[Constants.name],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font12,
                                                    )),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'QTY: ${data[Constants.quantity]}',
                                                      style: TextStyle(
                                                          fontSize: Dimensions
                                                              .font12),
                                                    ),
                                                    SizedBox(
                                                      height: Dimensions
                                                          .sizedBoxHeight10,
                                                    ),
                                                    Text(
                                                      '$currency${Constants.format.format(data[Constants.amount])}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              Dimensions.font12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Timer(
                                  const Duration(milliseconds: 200),
                                  () => Get.toNamed(
                                      RouteHelper.getProductDetailsPage(),
                                      arguments: snapshot.data![0]));
                            },
                          ),
                        ),
                      ),
                      HeadSedction(
                        text: 'PAYMENT',
                        weight: FontWeight.w500,
                        textSize: Dimensions.font12,
                        lMargin: Dimensions.sizedBoxWidth10 * 2,
                      ),
                      Container(
                        padding: EdgeInsets.all(Dimensions.sizedBoxWidth4 * 2),
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.sizedBoxWidth10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.sizedBoxWidth4),
                            color: Constants.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment Method',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.font14),
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight4 * 2,
                                ),
                                Text(
                                  'Cash On Delivery',
                                  style: TextStyle(fontSize: Dimensions.font12),
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight4 * 2,
                                ),
                              ],
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 1,
                              color: Constants.lightGrey,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight10,
                                ),
                                Text(
                                  'Payment Details',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.font14),
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Items total: ',
                                      style: TextStyle(
                                          fontSize: Dimensions.font12,
                                          color: const Color.fromARGB(
                                              255, 138, 138, 138)),
                                    ),
                                    Text(
                                      '$currency${Constants.format.format(data[Constants.amount] * data[Constants.quantity])}',
                                      style: TextStyle(
                                          fontSize: Dimensions.font12),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight10 / 2,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Shipping Fees: ',
                                      style: TextStyle(
                                          fontSize: Dimensions.font12,
                                          color: const Color.fromARGB(
                                              255, 138, 138, 138)),
                                    ),
                                    Text(
                                      '$currency${Constants.format.format(snapshot.data![0][Constants.deliveryPrice])}',
                                      style: TextStyle(
                                          fontSize: Dimensions.font12),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight10 / 2,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Promotion Discount: ',
                                      style: TextStyle(
                                          fontSize: Dimensions.font12,
                                          color: const Color.fromARGB(
                                              255, 138, 138, 138)),
                                    ),
                                    Text(
                                      '${currency}0',
                                      style: TextStyle(
                                          fontSize: Dimensions.font12),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Total: ',
                                      style: TextStyle(
                                          fontSize: Dimensions.font12,
                                          color: const Color.fromARGB(
                                              255, 138, 138, 138)),
                                    ),
                                    Text(
                                      '$currency${Constants.format.format((data[Constants.amount] * data[Constants.quantity]) + snapshot.data![0][Constants.deliveryPrice])}',
                                      style: TextStyle(
                                          fontSize: Dimensions.font12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      HeadSedction(
                        text: 'DELIVERY',
                        weight: FontWeight.w500,
                        textSize: Dimensions.font12,
                        lMargin: Dimensions.sizedBoxWidth10 * 2,
                      ),
                      Container(
                        padding: EdgeInsets.all(Dimensions.sizedBoxWidth4 * 2),
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.sizedBoxWidth10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.sizedBoxWidth4),
                            color: Constants.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivery Option',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.font14),
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight4 * 2,
                                ),
                                Text(
                                  'Door Delivery',
                                  style: TextStyle(fontSize: Dimensions.font12),
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight4 * 2,
                                ),
                              ],
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 1,
                              color: Constants.lightGrey,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight10,
                                ),
                                Text(
                                  'Shipping Address',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.font14),
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight10,
                                ),
                                Text(
                                  'Yaba College of Technology',
                                  style: TextStyle(fontSize: Dimensions.font12),
                                ),
                                Text(
                                  'Lagos Yaba-Yabatech',
                                  style: TextStyle(fontSize: Dimensions.font12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      text == 'DELIVERED' && revs.isEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight15,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                      Dimensions.sizedBoxWidth4 * 2),
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    height: Dimensions.sizedBoxHeight100 / 2,
                                    child: ElevatedBtn(
                                      pressed: () => Get.to(() => AddReviewPage(
                                            prodData: data,
                                          )),
                                      text: 'Add Review',
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: Dimensions.sizedBoxHeight10,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
