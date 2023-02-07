import 'package:GOCart/PROVIDERS/cart_provider.dart';
import 'package:GOCart/PROVIDERS/global_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';
import '../utils/dimensions.dart';
import '../widgets/elevated_button_widget.dart';

class CartFoodItems extends StatefulWidget {
  final List prodData;
  final List amount;
  final String shopName;
  final String cartId;
  const CartFoodItems(
      {super.key,
      required this.prodData,
      required this.amount,
      required this.shopName,
      required this.cartId});

  @override
  State<CartFoodItems> createState() => _CartFoodItemsState();
}

class _CartFoodItemsState extends State<CartFoodItems> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool changed = false;
  bool processing = false;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    controllers = List.generate(
        widget.prodData.length, (index) => TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String currency = Constants(context).currency().currencySymbol;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10 * 2),
      child: processing
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Center(
                  child: CircularProgressIndicator(
                    color: Constants.white,
                  ),
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Dimensions.sizedBoxHeight100 * 4,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.sizedBoxWidth15 * 2,
                      vertical: Dimensions.sizedBoxHeight10 * 2),
                  decoration: BoxDecoration(
                      color: Constants.white,
                      borderRadius:
                          BorderRadius.circular(Dimensions.font25 / 5)),
                  child: SingleChildScrollView(
                    child: Form(
                      key: key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.font17),
                                children: [
                                  const TextSpan(text: 'FOOD CART '),
                                  TextSpan(
                                      text: '(${widget.shopName})',
                                      style: const TextStyle(
                                          color: Constants.grey)),
                                ]),
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight4 * 2,
                          ),
                          Text(
                            'Items:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Dimensions.font17),
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight10,
                          ),
                          ListView.builder(
                            itemCount: widget.prodData.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: Dimensions.sizedBoxHeight10),
                                width: double.maxFinite,
                                height: Dimensions.sizedBoxHeight100,
                                child: Row(
                                  children: [
                                    Container(
                                      height: Dimensions.sizedBoxHeight100,
                                      width: Dimensions.sizedBoxHeight100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  widget.prodData[index]
                                                      [Constants.imgUrls][0]),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(
                                                  Dimensions.sizedBoxWidth10 /
                                                      2),
                                              bottom: Radius.circular(
                                                  Dimensions.sizedBoxWidth10 / 2))),
                                    ),
                                    SizedBox(
                                      width: Dimensions.sizedBoxWidth15,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                Dimensions.sizedBoxHeight10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.prodData[index]
                                                      [Constants.name],
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font16),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: Dimensions
                                                          .sizedBoxHeight10 /
                                                      2,
                                                ),
                                                RichText(
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: Dimensions
                                                                .font12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        children: [
                                                      const TextSpan(
                                                          text: 'Amount: '),
                                                      TextSpan(
                                                          text: widget
                                                              .amount[index]
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: Constants
                                                                  .grey))
                                                    ])),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    Provider.of<GlobalProvider>(
                                                            context,
                                                            listen: false)
                                                        .setProcess(
                                                            Processes.waiting);

                                                    String uid = FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid;
                                                    if (widget.prodData.length -
                                                            1 <
                                                        1) {
                                                      await Provider.of<
                                                                  CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .removeFromFoodCart(
                                                              uid,
                                                              widget.prodData[
                                                                      index][
                                                                  Constants
                                                                      .uid],
                                                              widget.amount
                                                                  .reduce((value,
                                                                          element) =>
                                                                      value +
                                                                      element),
                                                              widget.shopName,
                                                              true,
                                                              null,
                                                              false)
                                                          .then((value) {
                                                        Provider.of<GlobalProvider>(
                                                                context,
                                                                listen: false)
                                                            .setProcess(
                                                                Processes
                                                                    .waiting);
                                                      }).whenComplete(() =>
                                                              Get.close(1));
                                                    } else {
                                                      await Provider.of<CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .removeFromFoodCart(
                                                              uid,
                                                              widget.prodData[index]
                                                                  [Constants
                                                                      .uid],
                                                              widget.amount[
                                                                  index],
                                                              widget.shopName,
                                                              false,
                                                              index,
                                                              false)
                                                          .then((value) => Provider.of<GlobalProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .setProcess(Processes
                                                                  .done))
                                                          .whenComplete(
                                                              () => Get.close(1));
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Constants.tetiary,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimensions
                                                          .sizedBoxWidth10 *
                                                      4,
                                                  height: Dimensions
                                                          .sizedBoxHeight10 *
                                                      4,
                                                  child: TextFormField(
                                                    controller:
                                                        controllers[index],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        labelText: widget
                                                            .amount[index]
                                                            .toString()),
                                                    onChanged: (value) {
                                                      if (value != '' &&
                                                          value !=
                                                              widget
                                                                  .amount[index]
                                                                  .toString()) {
                                                        setState(() {
                                                          changed = true;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          changed = false;
                                                        });
                                                      }
                                                    },
                                                    validator: (value) {
                                                      if (value == '') {
                                                        return Constants.err;
                                                      } else {
                                                        if (RegExp(r'^[0-9]*$')
                                                            .hasMatch(value!)) {
                                                          if (double.parse(
                                                                  value) <
                                                              widget.prodData[
                                                                      index][
                                                                  Constants
                                                                      .prodMinPrice]) {
                                                            return 'Please enter at least $currency ${widget.prodData[index][Constants.prodMinPrice]}';
                                                          }
                                                        } else {
                                                          return 'Invalid amount!';
                                                        }
                                                      }

                                                      return null;
                                                    },
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight10 * 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total:',
                                style: TextStyle(
                                    fontSize: Dimensions.font14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.amount
                                    .reduce((value, element) => value + element)
                                    .toString(),
                                style: TextStyle(
                                    fontSize: Dimensions.font14,
                                    fontWeight: FontWeight.w500,
                                    color: Constants.grey),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight15 * 2,
                          ),
                          SizedBox(
                              width: double.maxFinite,
                              height: Dimensions.sizedBoxHeight100 / 2,
                              child: ElevatedBtn(
                                disabled: changed
                                    ? (Provider.of<GlobalProvider>(context)
                                                .process ==
                                            Processes.waiting
                                        ? true
                                        : false)
                                    : true,
                                text: 'UPDATE',
                                pressed: () async {
                                  if (key.currentState!.validate()) {
                                    Provider.of<GlobalProvider>(context,
                                            listen: false)
                                        .setProcess(Processes.waiting);

                                    for (var i = 0;
                                        i < widget.amount.length;
                                        i++) {
                                      if (double.parse(
                                                  controllers[i].text.trim()) !=
                                              widget.amount[i] ||
                                          controllers[i].text != '') {
                                        await Provider.of<CartProvider>(context,
                                                listen: false)
                                            .updateFoodCartItemAmount(
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                widget.amount[i],
                                                double.parse(
                                                    controllers[i].text.trim()),
                                                widget.cartId)
                                            .then((value) {
                                          if (i == widget.amount.length - 1) {
                                            Provider.of<GlobalProvider>(context,
                                                    listen: false)
                                                .setProcess(Processes.done);
                                            Get.close(1);
                                          }
                                        });
                                      } else {
                                        if (i == widget.amount.length - 1) {
                                          Provider.of<GlobalProvider>(context,
                                                  listen: false)
                                              .setProcess(Processes.done);
                                          Get.close(1);
                                        }
                                      }
                                    }
                                  }
                                },
                                child: Provider.of<GlobalProvider>(context)
                                            .process ==
                                        Processes.waiting
                                    ? SizedBox(
                                        width: Dimensions.sizedBoxWidth10 * 2,
                                        height: Dimensions.sizedBoxWidth10 * 2,
                                        child: const CircularProgressIndicator(
                                          color: Constants.white,
                                          strokeWidth: 3,
                                        ))
                                    : Text(
                                        'UPDATE',
                                        style: TextStyle(
                                            color: Constants.white,
                                            fontSize: Dimensions.font14),
                                      ),
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
