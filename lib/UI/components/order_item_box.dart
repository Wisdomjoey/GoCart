import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/widgets/box_chip_widget.dart';

import '../../CONSTANTS/constants.dart';
import '../routes/route_helper.dart';
import '../utils/dimensions.dart';

class OrderItemBox extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const OrderItemBox(
      {super.key,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        String text = '';
        Color color = Constants.tetiary;

        switch (data[index][Constants.orderStatus]) {
          case 'new':
            text = 'PENDING';
            color = Colors.blue;
            break;
          case 'processing':
            text = 'PROCESSING';
            color = Constants.tetiary;
            break;
          case 'delivered':
            text = 'DELIVERED';
            color = Constants.primary;
            break;
          case 'cancelled':
            text = 'CANCELLED';
            color = const Color.fromARGB(255, 100, 100, 100);
            break;
          default:
        }

        return Container(
          padding: EdgeInsets.only(
              left: Dimensions.sizedBoxWidth10,
              right: Dimensions.sizedBoxWidth10,
              bottom: Dimensions.sizedBoxHeight10),
          child: Material(
            borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
            animationDuration: const Duration(milliseconds: 100),
            child: InkWell(
              child: Ink(
                height: Dimensions.sizedBoxHeight10 * 11,
                padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.sizedBoxWidth4),
                  color: Constants.white,
                ),
                child: Row(
                  children: [
                    Ink(
                      width: Dimensions.sizedBoxWidth100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(data[index][Constants.imgUrl]),
                              fit: BoxFit.contain)),
                    ),
                    Expanded(
                      child: Ink(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    data[index][Constants.name],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: Dimensions.font12,
                                    )),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight3,
                                ),
                                Text('Order ${data[index][Constants.orderId]}',
                                    style: TextStyle(
                                      fontSize: Dimensions.font12,
                                    ))
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BoxChip(
                                  text: text,
                                  color: color,
                                ),
                                SizedBox(
                                  height: Dimensions.sizedBoxHeight3,
                                ),
                                Text('On 30-06',
                                    style: TextStyle(
                                        fontSize: Dimensions.font12,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Timer(
                    const Duration(milliseconds: 200),
                    () => Get.toNamed(
                        RouteHelper.getOrderDetailsPage(), arguments: [data[index], color, text]));
              },
            ),
          ),
        );
      },
    );
  }
}
