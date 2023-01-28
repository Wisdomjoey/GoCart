import 'dart:async';

import 'package:GOCart/PROVIDERS/cart_provider.dart';
import 'package:GOCart/PROVIDERS/order_provider.dart';
import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/components/details_bottom_navigation.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/widgets/box_chip_widget.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:GOCart/UI/widgets/head_section_widget.dart';
import 'package:GOCart/UI/widgets/icon_box_widget.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';
import '../../PROVIDERS/global_provider.dart';
import '../../PROVIDERS/user_provider.dart';
import '../utils/dimensions.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  getProductsData(List cart, BuildContext context) async {
    List<Map<String, dynamic>> data = [];

    for (var element in cart) {
      var snapshot = await Provider.of<ProductProvider>(context, listen: false)
          .getProductData(element[Constants.productId]);

      data.add(snapshot);
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    String currency = Constants(context).currency().currencySymbol;

    return FutureBuilder(
      future: getProductsData(
          Provider.of<CartProvider>(context, listen: false).carts, context),
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(
                  color: Constants.tetiary,
                ),
              )
            : (Provider.of<CartProvider>(context).carts.isEmpty
                // &&
                //         Provider.of<CartProvider>(context).foodCarts.isEmpty
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
                                        color: const Color.fromARGB(
                                            255, 137, 137, 137)),
                                  ),
                                ],
                              ),
                              Text(
                                '$currency ${Provider.of<CartProvider>(context).cartSubtotal}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.font16),
                              )
                            ],
                          ),
                        ),
                        HeadSedction(
                          text:
                              'CART (${Provider.of<CartProvider>(context).cartListNo})',
                          weight: FontWeight.w500,
                          lMargin: Dimensions.sizedBoxWidth10 * 2,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: Dimensions.sizedBoxWidth10,
                              right: Dimensions.sizedBoxWidth10,
                              bottom: Dimensions.sizedBoxHeight10),
                          child: ListView.builder(
                            itemCount:
                                Provider.of<CartProvider>(context).carts.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.sizedBoxWidth10 / 2),
                                      color: Constants.white),
                                  padding: EdgeInsets.all(
                                      Dimensions.sizedBoxWidth10),
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.sizedBoxHeight10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              width: double.maxFinite,
                                              height:
                                                  Dimensions.sizedBoxHeight100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          snapshot.data[index][
                                                              Constants
                                                                  .imgUrls][0]),
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
                                                  snapshot.data[index][Constants
                                                      .prodDescription],
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font12),
                                                ),
                                                SizedBox(
                                                  height: Dimensions
                                                          .sizedBoxHeight4 *
                                                      2,
                                                ),
                                                Text(
                                                  '$currency${snapshot.data[index][Constants.prodNewPrice]}',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                snapshot.data[index][Constants
                                                            .prodOldPrice] >
                                                        snapshot.data[index][
                                                            Constants
                                                                .prodNewPrice]
                                                    ? Row(
                                                        children: [
                                                          Text(
                                                            '$currency${snapshot.data[index][Constants.prodOldPrice]}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Dimensions
                                                                        .font12,
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    98,
                                                                    98,
                                                                    98),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                          ),
                                                          SizedBox(
                                                            width: Dimensions
                                                                    .sizedBoxWidth10 /
                                                                2,
                                                          ),
                                                          BoxChip(
                                                            text:
                                                                '-${(((snapshot.data[index][Constants.prodOldPrice] - snapshot.data[index][Constants.prodNewPrice]) / snapshot.data[index][Constants.prodOldPrice]) * 100).toStringAsFixed(2)}%',
                                                            pad: EdgeInsets
                                                                .symmetric(
                                                              horizontal: Dimensions
                                                                  .sizedBoxWidth4,
                                                              vertical: Dimensions
                                                                      .sizedBoxHeight3 *
                                                                  2,
                                                            ),
                                                            textSize: Dimensions
                                                                .font14,
                                                            textWeight:
                                                                FontWeight.w600,
                                                            color: const Color
                                                                    .fromARGB(
                                                                35,
                                                                248,
                                                                194,
                                                                0),
                                                            textColor: Constants
                                                                .tetiary,
                                                          )
                                                        ],
                                                      )
                                                    : SizedBox(
                                                        height: Dimensions
                                                                .sizedBoxHeight4 *
                                                            2,
                                                      ),
                                                snapshot.data[index][Constants
                                                            .prodTotalStock] >
                                                        0
                                                    ? const BoxChip(
                                                        text: 'In Stock',
                                                        color: Constants.grey,
                                                      )
                                                    : const BoxChip(
                                                        text: 'Out of Stock',
                                                        color: Constants.grey,
                                                      ),
                                                SizedBox(
                                                  height: Dimensions
                                                          .sizedBoxHeight10 *
                                                      2,
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
                                                    width: Dimensions
                                                        .sizedBoxWidth10,
                                                  ),
                                                  Text(
                                                    'REMOVE',
                                                    style: TextStyle(
                                                        color:
                                                            Constants.tetiary,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            Dimensions.font15),
                                                  )
                                                ],
                                              ),
                                              onTap: () => showDialog(
                                                  context: context,
                                                  builder: ((context) => _showDialog(
                                                      context,
                                                      snapshot.data[index]
                                                          [Constants.uid],
                                                      Provider.of<CartProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .carts[index]
                                                          [Constants.amount]))),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimensions.sizedBoxWidth10,
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconBox(
                                                  pressed: () async {
                                                    await Provider.of<CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .decreaseCartProduct(
                                                            Provider.of<CartProvider>(context, listen: false)
                                                                    .carts[index]
                                                                [Constants
                                                                    .productId],
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid,
                                                            snapshot.data[index]
                                                                [Constants
                                                                    .prodCategory],
                                                            snapshot.data[index]
                                                                [Constants.prodNewPrice],
                                                            snapshot.data[index][Constants.shopName]);
                                                  },
                                                  icon: Icons.remove,
                                                  width: Dimensions
                                                          .sizedBoxWidth10 *
                                                      3,
                                                  height: Dimensions
                                                          .sizedBoxWidth10 *
                                                      3,
                                                  color: Constants.tetiary,
                                                  borderColor:
                                                      Colors.transparent,
                                                  iconSize: Dimensions.font24,
                                                  iconColor: Constants.white,
                                                  isDisabled: Provider.of<CartProvider>(context)
                                                              .cart[Provider.of<CartProvider>(context, listen: false)
                                                                  .carts[index][
                                                              Constants
                                                                  .productId]] !=
                                                          null
                                                      ? (Provider.of<CartProvider>(context)
                                                                  .cart[Provider.of<CartProvider>(context, listen: false)
                                                                      .carts[index]
                                                                  [Constants.productId]] <
                                                              2
                                                          ? true
                                                          : false)
                                                      : false,
                                                  right: 0,
                                                ),
                                                SizedBox(
                                                  width: Dimensions
                                                          .sizedBoxWidth10 *
                                                      2,
                                                ),
                                                Text(
                                                  Provider.of<CartProvider>(
                                                          context)
                                                      .cart[Provider.of<
                                                                      CartProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .carts[index]
                                                          [Constants.productId]]
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: Dimensions
                                                          .sizedBoxWidth10 *
                                                      2,
                                                ),
                                                IconBox(
                                                  pressed: () async {
                                                    await Provider.of<CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .increaseCartProduct(
                                                            Provider.of<CartProvider>(context, listen: false)
                                                                    .carts[index]
                                                                [Constants
                                                                    .productId],
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid,
                                                            snapshot.data[index]
                                                                [Constants
                                                                    .prodCategory],
                                                            snapshot.data[index]
                                                                [Constants.shopName],
                                                            snapshot.data[index][Constants.prodNewPrice]);
                                                  },
                                                  icon: Icons.add,
                                                  width: Dimensions
                                                          .sizedBoxWidth10 *
                                                      3,
                                                  height: Dimensions
                                                          .sizedBoxWidth10 *
                                                      3,
                                                  color: Constants.tetiary,
                                                  borderColor:
                                                      Colors.transparent,
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
                                        RouteHelper.getProductDetailsPage(),
                                        arguments: snapshot.data[index])),
                              );
                            },
                          ),
                        ),
                        DetailsBottomNav(
                          // isAdded: false,
                          pressed: () async {
                            Provider.of<GlobalProvider>(context, listen: false)
                                .setProcess(Processes.waiting);

                            List<int> quantity = [];
                            List amount = [];

                            for (var element in Provider.of<CartProvider>(
                                    context,
                                    listen: false)
                                .carts) {
                              if (element[Constants.prodCategory] ==
                                  'Cooked Foods') {
                                int q = Provider.of<CartProvider>(context)
                                    .cart[element[Constants.shopName]];
                                Map<String, dynamic> cart =
                                    (Provider.of<CartProvider>(context,
                                            listen: false)
                                        .carts
                                        .where((element1) =>
                                            element1[Constants.shopName] ==
                                            element[Constants.shopName])
                                        .elementAt(0)) as Map<String, dynamic>;

                                quantity.add(q);
                                List temp = [];

                                for (var element in cart[Constants.amount]) {
                                  temp.add(element * q);
                                }

                                amount.add(temp);
                              } else {
                                int q = Provider.of<CartProvider>(context,
                                        listen: false)
                                    .cart[element[Constants.productId]];
                                Map<String, dynamic> cart = (snapshot.data
                                    .where((element1) =>
                                        element1[Constants.uid] ==
                                        element[Constants.productId])
                                    .elementAt(0)) as Map<String, dynamic>;

                                quantity.add(q);
                                amount.add(cart[Constants.prodNewPrice] * q);
                              }
                            }

                            await Provider.of<OrderProvider>(context,
                                    listen: false)
                                .createOrder(
                                    FirebaseAuth.instance.currentUser!.uid,
                                    amount,
                                    quantity,
                                    snapshot.data,
                                    context)
                                .then((value) {
                              Provider.of<GlobalProvider>(context,
                                      listen: false)
                                  .setProcess(Processes.done);
                            });
                          },
                          leading: IconBox(
                            icon: Icons.phone,
                            height: Dimensions.sizedBoxHeight65,
                            width: Dimensions.sizedBoxWidth100 / 2,
                            borderColor: Constants.tetiary,
                            iconSize: Dimensions.sizedBoxWidth15 * 2,
                          ),
                          text:
                              'PLACE ORDER ($currency${Provider.of<CartProvider>(context).cartSubtotal})',
                        ),
                        SizedBox(
                          height: Dimensions.sizedBoxHeight10,
                        ),
                      ],
                    ),
                  ));
      },
    );
  }

  Widget _showDialog(context, String prodId, double amount) {
    // SnackBar(content: Text('content'));
    List favs =
        Provider.of<UserProvider>(context).userData[Constants.userFavourites];

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
              child: ElevatedBtn(
                pressed: () async {
                  String uid = FirebaseAuth.instance.currentUser!.uid;

                  if (!favs.contains(prodId)) {
                    await Provider.of<UserProvider>(context, listen: false)
                        .updateUserData({
                      Constants.userFavourites: [...favs, prodId]
                    }, uid).then((value) async {
                      if (value) {
                        Constants(context).snackBar(
                            'Product added to Saved Items', Constants.tetiary);

                        await Provider.of<CartProvider>(context, listen: false)
                            .removeFromCart(
                                FirebaseAuth.instance.currentUser!.uid,
                                prodId,
                                amount);
                      }
                    });
                  } else {
                    Constants(context).snackBar(
                        'Product is already in your saved list', Colors.red);
                  }

                  Navigator.pop(context);
                },
                text: 'SAVE FOR LATER',
                textColor: Constants.tetiary,
                isElevated: false,
                addBorder: true,
                icon: const Icon(
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
              child: ElevatedBtn(
                text: 'REMOVE ITEM',
                pressed: () async {
                  await Provider.of<CartProvider>(context, listen: false)
                      .removeFromCart(FirebaseAuth.instance.currentUser!.uid,
                          prodId, amount)
                      .then((value) {
                    if (value) Navigator.pop(context);
                  });
                },
                icon: const Icon(
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
