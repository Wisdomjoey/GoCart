import 'dart:async';

import 'package:GOCart/PROVIDERS/shop_provider.dart';
import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/widgets/box_chip_widget.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';
import '../../PROVIDERS/global_provider.dart';
import '../../PROVIDERS/order_provider.dart';
import '../routes/route_helper.dart';
import '../utils/dimensions.dart';
import '../widgets/elevated_button_widget.dart';

class OrderItemBox extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const OrderItemBox({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const Center(
            child: Text('No Orders Available'),
          )
        : ListView.builder(
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

              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.sizedBoxWidth10,
                        right: Dimensions.sizedBoxWidth10,
                        bottom: Dimensions.sizedBoxHeight10),
                    child: Material(
                      borderRadius:
                          BorderRadius.circular(Dimensions.sizedBoxWidth4),
                      animationDuration: const Duration(milliseconds: 100),
                      child: InkWell(
                        onLongPress: data[index][Constants.orderStatus] ==
                                'processing'
                            ? () => showDialog(
                                context: context,
                                builder: (context) => _showDialog(
                                      context,
                                      data[index][Constants.orderId],
                                      data[index][Constants.imgUrl],
                                      data[index][Constants.name],
                                      data[index][Constants.amount],
                                      data[index][Constants.uid],
                                      data[index][Constants.shopName],
                                      data[index][Constants.productId],
                                    )).then((value) => Navigator.pop(context))
                            : null,
                        onTap: () {
                          if (data[index]['isCooked'] == false) {
                            Timer(
                                const Duration(milliseconds: 200),
                                () => Get.toNamed(
                                    RouteHelper.getOrderDetailsPage(),
                                    arguments: [data[index], color, text]));
                          }
                        },
                        child: Ink(
                          height: Dimensions.sizedBoxHeight10 * 11,
                          padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.sizedBoxWidth4),
                            color: Constants.white,
                          ),
                          child: Row(
                            children: [
                              Ink(
                                width: Dimensions.sizedBoxWidth100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            data[index][Constants.imgUrl]),
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data[index][Constants.name],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: Dimensions.font12,
                                              )),
                                          SizedBox(
                                            height: Dimensions.sizedBoxHeight3,
                                          ),
                                          Text(
                                              'Order ${data[index][Constants.orderId]}',
                                              style: TextStyle(
                                                fontSize: Dimensions.font12,
                                              ))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                      ),
                    ),
                  ),
                  data[index][Constants.orderStatus] == 'processing' &&
                          index == data.length - 1
                      ? Column(
                          children: [
                            SizedBox(
                              height: Dimensions.sizedBoxHeight10 * 2,
                            ),
                            const Text(
                                'Long press on the item to update it\'s status')
                          ],
                        )
                      : Container()
                ],
              );
            },
          );
  }

  Widget _showDialog(context, String orderId, String imgUrl, String name,
      double price, String orderUid, String shopName, String prodId) {
    String currency = Constants(context).currency().currencySymbol;
    String val = 'Delivered';

    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          insetPadding:
              EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
          child: Container(
            padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Order Id: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimensions.font16),
                          children: [
                            TextSpan(
                              text: orderId,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ]),
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
                  height: Dimensions.sizedBoxHeight10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Dimensions.sizedBoxWidth100,
                      height: Dimensions.sizedBoxWidth100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(imgUrl),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      width: Dimensions.sizedBoxWidth10,
                    ),
                    Expanded(
                      child: Text(name,
                          style: TextStyle(
                            fontSize: Dimensions.font12,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Price: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimensions.font14),
                          children: [
                            TextSpan(
                              text:
                                  '$currency${Constants.format.format(price)}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ]),
                    ),
                    Row(
                      children: [
                        Text(
                          'Status:',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Dimensions.font16),
                        ),
                        SizedBox(
                          width: Dimensions.sizedBoxWidth10 / 2,
                        ),
                        const BoxChip(
                          text: 'PROCESSING',
                          color: Constants.tetiary,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton(
                      items: const [
                        DropdownMenuItem(
                            value: 'Delivered', child: Text('Delivered')),
                        DropdownMenuItem(
                            value: 'Cancelled', child: Text('Cancelled')),
                      ],
                      value: val,
                      onChanged: (dynamic value) {
                        setState(
                          () {
                            val = value;
                          },
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.sizedBoxHeight4),
                      width: Dimensions.sizedBoxWidth100,
                      child: ElevatedBtn(
                        pressed: () async {
                          Provider.of<GlobalProvider>(context, listen: false)
                              .setProcess(Processes.waiting);

                          await Provider.of<OrderProvider>(context,
                                  listen: false)
                              .updateOrderStatus(
                                  val == 'Delivered'
                                      ? Constants.delivered
                                      : Constants.cancelled,
                                  orderUid,
                                  val == 'Delivered'
                                      ? ((Provider.of<ShopProvider>(context,
                                              listen: false)
                                          .shops
                                          .where((element) =>
                                              element[Constants.shopName] ==
                                              shopName)
                                          .elementAt(0)) as Map)[Constants.uid]
                                      : null,
                                  price)
                              .whenComplete(() async {
                            await Provider.of<UserProvider>(context,
                                    listen: false)
                                .addToInbox(
                                    FirebaseAuth.instance.currentUser!.uid,
                                    imgUrl,
                                    'Your order on this product has been $val',
                                    'Order')
                                .whenComplete(() {
                              Provider.of<GlobalProvider>(context,
                                      listen: false)
                                  .setProcess(Processes.done);
                              Navigator.pop(context);
                            });
                          });
                        },
                        text: 'Update',
                        disabled:
                            Provider.of<GlobalProvider>(context).process ==
                                    Processes.waiting
                                ? true
                                : false,
                        child: Provider.of<GlobalProvider>(context).process ==
                                Processes.waiting
                            ? SizedBox(
                                width: Dimensions.sizedBoxWidth10 * 1.5,
                                height: Dimensions.sizedBoxWidth10 * 1.5,
                                child: const CircularProgressIndicator(
                                  color: Constants.white,
                                  strokeWidth: 3,
                                ))
                            : Text(
                                'Update',
                                style: TextStyle(
                                    color: Constants.white,
                                    fontSize: Dimensions.font14),
                              ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10,
                ),
                const Text(
                    'Have you recieved this order? If so please update order status'),
              ],
            ),
          ),
        );
      },
    );
  }
}
