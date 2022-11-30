import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolproj/utils/dimensions.dart';
import 'package:schoolproj/widgets/box_chip_widget.dart';
import 'package:schoolproj/widgets/head_section_widget.dart';
import 'package:schoolproj/widgets/txt_button_widget.dart';

import '../components/home_app_bar.dart';
import '../routes/route_helper.dart';

class OrderDetailsPage extends StatefulWidget {
  final String state;
  final String text;

  const OrderDetailsPage({super.key, required this.state, required this.text});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Order Details',
        showCart: true,
        implyLeading: true,
        textSize: Dimensions.font24,
      ),
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.sizedBoxWidth15,
                  vertical: Dimensions.sizedBoxHeight10),
              margin: EdgeInsets.only(top: Dimensions.sizedBoxHeight10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #281993076452',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.font14),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight3 * 2,
                  ),
                  Text(
                    'Placed on: 10-23-12',
                    style: TextStyle(
                        fontSize: Dimensions.font12,
                        color: const Color.fromARGB(255, 138, 138, 138)),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10 / 5,
                  ),
                  Text(
                    'No of items: 1',
                    style: TextStyle(
                        fontSize: Dimensions.font12,
                        color: const Color.fromARGB(255, 138, 138, 138)),
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight10 / 5,
                  ),
                  Text(
                    'Total: \$10',
                    style: TextStyle(
                        fontSize: Dimensions.font12,
                        color: const Color.fromARGB(255, 138, 138, 138)),
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
                borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
                animationDuration: const Duration(milliseconds: 100),
                child: InkWell(
                  splashFactory: InkRipple.splashFactory,
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.sizedBoxWidth4),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Ink(
                          padding:
                              EdgeInsets.all(Dimensions.sizedBoxWidth4 * 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BoxChip(
                                text: widget.text,
                                color: widget.state == 'closed'
                                    ? const Color.fromARGB(255, 100, 100, 100)
                                    : const Color.fromARGB(255, 107, 205, 110),
                              ),
                              SizedBox(
                                height: Dimensions.sizedBoxHeight10,
                              ),
                              Text(
                                'On 20-09',
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
                          color: const Color(0XFFEDEDED),
                        ),
                        Ink(
                          height: Dimensions.sizedBoxHeight10 * 11,
                          padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                          child: Row(
                            children: [
                              Ink(
                                width: Dimensions.sizedBoxWidth100,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/1.jpg'),
                                        fit: BoxFit.contain)),
                              ),
                              Expanded(
                                child: Ink(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'Rechargeable Hand drier with wireless charging function.',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: Dimensions.font12,
                                          )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'QTY: 1',
                                            style: TextStyle(
                                                fontSize: Dimensions.font12),
                                          ),
                                          SizedBox(
                                            height: Dimensions.sizedBoxHeight10,
                                          ),
                                          Text(
                                            '\$10',
                                            style: TextStyle(
                                                fontSize: Dimensions.font12,
                                                fontWeight: FontWeight.w600),
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
                        Ink(
                          width: double.maxFinite,
                          height: 1,
                          color: const Color(0XFFEDEDED),
                        ),
                        TxtButton(
                          text: 'BUY AGAIN',
                          pad: Dimensions.sizedBoxWidth4 * 2,
                          bgColor: const Color(0XFFF8C300),
                          color: Colors.white,
                          visualD: -4,
                          textSize: Dimensions.font12,
                          top: Dimensions.sizedBoxHeight4 * 2,
                          bottom: Dimensions.sizedBoxHeight4 * 2,
                        ),
                        Ink(
                          width: double.maxFinite,
                          height: 1,
                          color: const Color(0XFFEDEDED),
                        ),
                        TxtButton(
                          text: 'SEE STATUS HISTORY',
                          pad: Dimensions.sizedBoxWidth4 * 2,
                          color: const Color(0XFFF8C300),
                          visualD: -4,
                          textSize: Dimensions.font12,
                          top: Dimensions.sizedBoxHeight4 * 2,
                          bottom: Dimensions.sizedBoxHeight4 * 2,
                          borderColor: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Color(0XFFF8C300),
                              ),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.sizedBoxWidth4)),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Timer(const Duration(milliseconds: 200),
                        () => Get.toNamed(RouteHelper.getProductDetailsPage()));
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
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.sizedBoxWidth4),
                  color: Colors.white),
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
                    color: const Color(0XFFEDEDED),
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
                                color:
                                    const Color.fromARGB(255, 138, 138, 138)),
                          ),
                          Text(
                            '\$10',
                            style: TextStyle(fontSize: Dimensions.font12),
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
                                color:
                                    const Color.fromARGB(255, 138, 138, 138)),
                          ),
                          Text(
                            '\$10',
                            style: TextStyle(fontSize: Dimensions.font12),
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
                                color:
                                    const Color.fromARGB(255, 138, 138, 138)),
                          ),
                          Text(
                            '\$10',
                            style: TextStyle(fontSize: Dimensions.font12),
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
                                color:
                                    const Color.fromARGB(255, 138, 138, 138)),
                          ),
                          Text(
                            '\$10',
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
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.sizedBoxWidth4),
                  color: Colors.white),
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
                    color: const Color(0XFFEDEDED),
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
            SizedBox(
              height: Dimensions.sizedBoxHeight10,
            )
          ],
        ),
      ),
    );
  }
}
