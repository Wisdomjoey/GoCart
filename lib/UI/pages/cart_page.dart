import 'dart:async';

import 'package:GOCart/PROVIDERS/cart_provider.dart';
import 'package:GOCart/PROVIDERS/order_provider.dart';
import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:GOCart/PROVIDERS/shop_provider.dart';
import 'package:GOCart/UI/components/cart_food_items.dart';
import 'package:GOCart/UI/pages/order_complete_page.dart';
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

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  getProductsD(List foodCart, BuildContext context) async {
    List data = [];
    List<List> fdata = [];

    for (var i = 0; i < foodCart.length; i++) {
      for (var element in foodCart[i][Constants.productId]) {
        await Provider.of<ProductProvider>(context, listen: false)
            .getProductData(element)
            .then((value) => data.add(value));
      }
      fdata.add(data);
      data = [];
    }

    return fdata;
  }

  @override
  Widget build(BuildContext context) {
    String currency = Constants(context).currency().currencySymbol;
    List foodCart = Provider.of<CartProvider>(context).foodCarts;
    List<Map<String, dynamic>> prodData =
        Provider.of<CartProvider>(context).prodData;
    List fProdData = Provider.of<CartProvider>(context).fProdData;

    return (Provider.of<CartProvider>(context).carts.isEmpty && foodCart.isEmpty
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
        : FutureBuilder(
            future: getProductsD(foodCart, context),
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: Constants.tetiary))
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
                                      'Summary',
                                      style: TextStyle(
                                          fontSize: Dimensions.font12,
                                          color: const Color.fromARGB(
                                              255, 137, 137, 137)),
                                    ),
                                  ],
                                ),
                                Text(
                                  '$currency ${Constants.format.format(Provider.of<CartProvider>(context).cartSubtotal)}',
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
                            child: Column(
                              children: [
                                foodCart.isEmpty
                                    ? Container()
                                    : ListView.builder(
                                        itemCount: foodCart.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(Dimensions
                                                              .sizedBoxWidth10 /
                                                          2),
                                                  color: Constants.white),
                                              padding: EdgeInsets.all(
                                                  Dimensions.sizedBoxWidth10),
                                              margin: EdgeInsets.only(
                                                  bottom: Dimensions
                                                      .sizedBoxHeight10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          width:
                                                              double.maxFinite,
                                                          height: Dimensions
                                                              .sizedBoxHeight100,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(((Provider.of<ShopProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .shops
                                                                      .where((element) =>
                                                                          element[Constants.shopName] ==
                                                                          foodCart[index][Constants
                                                                              .shopName])
                                                                      .elementAt(
                                                                          0)) as Map)[Constants.imgUrls][0]),
                                                                  fit: BoxFit.contain)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Dimensions
                                                            .sizedBoxWidth10,
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'FOOD',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .font16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: Dimensions
                                                                      .sizedBoxHeight4 *
                                                                  2,
                                                            ),
                                                            Text(
                                                              foodCart[index][
                                                                  Constants
                                                                      .shopName],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .font12),
                                                            ),
                                                            SizedBox(
                                                              height: Dimensions
                                                                      .sizedBoxHeight4 *
                                                                  2,
                                                            ),
                                                            Text(
                                                              '$currency${Constants.format.format(foodCart[index][Constants.amount].reduce((value, element) => value + element))}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .font16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions
                                                        .sizedBoxHeight10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: GestureDetector(
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .delete_outline,
                                                                color: Constants
                                                                    .tetiary,
                                                              ),
                                                              SizedBox(
                                                                width: Dimensions
                                                                    .sizedBoxWidth10,
                                                              ),
                                                              Text(
                                                                'REMOVE',
                                                                style: TextStyle(
                                                                    color: Constants
                                                                        .tetiary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .font15),
                                                              )
                                                            ],
                                                          ),
                                                          onTap: () => showDialog(
                                                              context: context,
                                                              builder: ((context) => _showDialog(
                                                                  context,
                                                                  null,
                                                                  foodCart[
                                                                          index]
                                                                      [Constants
                                                                          .amount],
                                                                  false,
                                                                  foodCart[
                                                                          index]
                                                                      [Constants
                                                                          .shopName]))),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Dimensions
                                                            .sizedBoxWidth10,
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            IconBox(
                                                              pressed:
                                                                  () async {
                                                                await Provider.of<CartProvider>(context, listen: false).decreaseCartProduct(
                                                                    null,
                                                                    FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid,
                                                                    'Cooked Foods',
                                                                    foodCart[index]
                                                                            [
                                                                            Constants
                                                                                .amount]
                                                                        .reduce((value,
                                                                                element) =>
                                                                            value +
                                                                            element),
                                                                    foodCart[
                                                                            index]
                                                                        [
                                                                        Constants
                                                                            .shopName]);
                                                              },
                                                              icon:
                                                                  Icons.remove,
                                                              width: Dimensions
                                                                      .sizedBoxWidth10 *
                                                                  3,
                                                              height: Dimensions
                                                                      .sizedBoxWidth10 *
                                                                  3,
                                                              color: Constants
                                                                  .tetiary,
                                                              borderColor: Colors
                                                                  .transparent,
                                                              iconSize:
                                                                  Dimensions
                                                                      .font24,
                                                              iconColor:
                                                                  Constants
                                                                      .white,
                                                              isDisabled: Provider.of<CartProvider>(
                                                                              context)
                                                                          .cart[foodCart[
                                                                              index]
                                                                          [
                                                                          Constants
                                                                              .shopName]] !=
                                                                      null
                                                                  ? (Provider.of<CartProvider>(context).cart[foodCart[index]
                                                                              [
                                                                              Constants.shopName]] <
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
                                                                  .cart[foodCart[
                                                                          index]
                                                                      [Constants
                                                                          .shopName]]
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              width: Dimensions
                                                                      .sizedBoxWidth10 *
                                                                  2,
                                                            ),
                                                            IconBox(
                                                              pressed:
                                                                  () async {
                                                                await Provider.of<CartProvider>(context, listen: false).increaseCartProduct(
                                                                    null,
                                                                    FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid,
                                                                    'Cooked Foods',
                                                                    foodCart[
                                                                            index]
                                                                        [
                                                                        Constants
                                                                            .shopName],
                                                                    foodCart[index]
                                                                            [
                                                                            Constants
                                                                                .amount]
                                                                        .reduce((value,
                                                                                element) =>
                                                                            value +
                                                                            element));
                                                              },
                                                              icon: Icons.add,
                                                              width: Dimensions
                                                                      .sizedBoxWidth10 *
                                                                  3,
                                                              height: Dimensions
                                                                      .sizedBoxWidth10 *
                                                                  3,
                                                              color: Constants
                                                                  .tetiary,
                                                              borderColor: Colors
                                                                  .transparent,
                                                              iconSize:
                                                                  Dimensions
                                                                      .font24,
                                                              iconColor:
                                                                  Constants
                                                                      .white,
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
                                            onTap: () => showDialog(
                                                context: context,
                                                builder: ((context) =>
                                                    CartFoodItems(
                                                      prodData:
                                                          snapshot.data[index],
                                                      amount: foodCart[index]
                                                          [Constants.amount],
                                                      shopName: foodCart[index]
                                                          [Constants.shopName],
                                                      cartId: foodCart[index]
                                                          [Constants.uid],
                                                    ))).whenComplete(() async =>
                                                await Provider.of<CartProvider>(
                                                        context,
                                                        listen: false)
                                                    .getFoodCart(FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid)),
                                            // onTap: () => showDialog(
                                            //     context: context,
                                            //     builder: ((context) =>
                                            //         _showFoodCartItems(
                                            //             snapshot.data[index],
                                            //             foodCart[index]
                                            //                 [Constants.amount],
                                            //             context,
                                            //             foodCart[index][Constants
                                            //                 .shopName]))).then(
                                            //     (value) => setState(
                                            //           () {},
                                            //         )),
                                          );
                                        },
                                      ),
                                Provider.of<CartProvider>(context).carts.isEmpty
                                    ? Container()
                                    : ListView.builder(
                                        itemCount:
                                            Provider.of<CartProvider>(context)
                                                .carts
                                                .length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(Dimensions
                                                              .sizedBoxWidth10 /
                                                          2),
                                                  color: Constants.white),
                                              padding: EdgeInsets.all(
                                                  Dimensions.sizedBoxWidth10),
                                              margin: EdgeInsets.only(
                                                  bottom: Dimensions
                                                      .sizedBoxHeight10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          width:
                                                              double.maxFinite,
                                                          height: Dimensions
                                                              .sizedBoxHeight100,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: CachedNetworkImageProvider(
                                                                      prodData[index]
                                                                              [
                                                                              Constants.imgUrls]
                                                                          [0]),
                                                                  fit: BoxFit
                                                                      .contain)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Dimensions
                                                            .sizedBoxWidth10,
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              prodData[index][
                                                                  Constants
                                                                      .name],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .font12),
                                                            ),
                                                            SizedBox(
                                                              height: Dimensions
                                                                      .sizedBoxHeight4 *
                                                                  2,
                                                            ),
                                                            Text(
                                                              '$currency${Constants.format.format(prodData[index][Constants.prodNewPrice])}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .font16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            prodData[index][Constants
                                                                        .prodOldPrice] >
                                                                    prodData[
                                                                            index]
                                                                        [
                                                                        Constants
                                                                            .prodNewPrice]
                                                                ? Row(
                                                                    children: [
                                                                      Text(
                                                                        '$currency${Constants.format.format(prodData[index][Constants.prodOldPrice])}',
                                                                        style: TextStyle(
                                                                            fontSize: Dimensions
                                                                                .font12,
                                                                            color: const Color.fromARGB(
                                                                                255,
                                                                                98,
                                                                                98,
                                                                                98),
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            decoration: TextDecoration.lineThrough),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            Dimensions.sizedBoxWidth10 /
                                                                                2,
                                                                      ),
                                                                      BoxChip(
                                                                        text:
                                                                            '-${(((prodData[index][Constants.prodOldPrice] - prodData[index][Constants.prodNewPrice]) / prodData[index][Constants.prodOldPrice]) * 100).toStringAsFixed(2)}%',
                                                                        pad: EdgeInsets
                                                                            .symmetric(
                                                                          horizontal:
                                                                              Dimensions.sizedBoxWidth4,
                                                                          vertical:
                                                                              Dimensions.sizedBoxHeight3 * 2,
                                                                        ),
                                                                        textSize:
                                                                            Dimensions.font14,
                                                                        textWeight:
                                                                            FontWeight.w600,
                                                                        color: const Color.fromARGB(
                                                                            35,
                                                                            248,
                                                                            194,
                                                                            0),
                                                                        textColor:
                                                                            Constants.tetiary,
                                                                      )
                                                                    ],
                                                                  )
                                                                : SizedBox(
                                                                    height:
                                                                        Dimensions.sizedBoxHeight4 *
                                                                            2,
                                                                  ),
                                                            prodData[index][Constants
                                                                        .prodTotalStock] >
                                                                    0
                                                                ? const BoxChip(
                                                                    text:
                                                                        'In Stock',
                                                                    color:
                                                                        Constants
                                                                            .grey,
                                                                  )
                                                                : const BoxChip(
                                                                    text:
                                                                        'Out of Stock',
                                                                    color:
                                                                        Constants
                                                                            .grey,
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
                                                  SizedBox(
                                                    height: Dimensions
                                                        .sizedBoxHeight10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: GestureDetector(
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .delete_outline,
                                                                color: Constants
                                                                    .tetiary,
                                                              ),
                                                              SizedBox(
                                                                width: Dimensions
                                                                    .sizedBoxWidth10,
                                                              ),
                                                              Text(
                                                                'REMOVE',
                                                                style: TextStyle(
                                                                    color: Constants
                                                                        .tetiary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .font15),
                                                              )
                                                            ],
                                                          ),
                                                          onTap: () => showDialog(
                                                              context: context,
                                                              builder: ((context) => _showDialog(
                                                                  context,
                                                                  prodData[index][Constants.uid],
                                                                  [
                                                                    Provider.of<CartProvider>(context, listen: false)
                                                                            .carts
                                                                            .isEmpty
                                                                        ? 0
                                                                        : Provider.of<CartProvider>(context,
                                                                                listen: false)
                                                                            .carts[index][Constants.amount]
                                                                  ],
                                                                  true,
                                                                  null))),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Dimensions
                                                            .sizedBoxWidth10,
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            IconBox(
                                                              pressed:
                                                                  () async {
                                                                Provider.of<GlobalProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .setProcess(
                                                                        Processes
                                                                            .waiting);

                                                                await Provider.of<
                                                                            CartProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .decreaseCartProduct(
                                                                        Provider.of<CartProvider>(context, listen: false).carts[index]
                                                                            [
                                                                            Constants
                                                                                .productId],
                                                                        FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .uid,
                                                                        prodData[index][Constants
                                                                            .prodCategory],
                                                                        prodData[index][Constants
                                                                            .prodNewPrice],
                                                                        prodData[index]
                                                                            [Constants.shopName])
                                                                    .then((value) => Provider.of<GlobalProvider>(context, listen: false).setProcess(Processes.done));
                                                              },
                                                              icon:
                                                                  Icons.remove,
                                                              width: Dimensions
                                                                      .sizedBoxWidth10 *
                                                                  3,
                                                              height: Dimensions
                                                                      .sizedBoxWidth10 *
                                                                  3,
                                                              color: Constants
                                                                  .tetiary,
                                                              borderColor: Colors
                                                                  .transparent,
                                                              iconSize:
                                                                  Dimensions
                                                                      .font24,
                                                              iconColor:
                                                                  Constants
                                                                      .white,
                                                              isDisabled: Provider.of<GlobalProvider>(
                                                                              context)
                                                                          .process ==
                                                                      Processes
                                                                          .waiting
                                                                  ? true
                                                                  : (Provider.of<CartProvider>(context).cart[Provider.of<CartProvider>(context, listen: false).carts[index][Constants
                                                                              .productId]] !=
                                                                          null
                                                                      ? (Provider.of<CartProvider>(context).cart[Provider.of<CartProvider>(context, listen: false).carts[index][Constants.productId]] <
                                                                              2
                                                                          ? true
                                                                          : false)
                                                                      : false),
                                                              right: 0,
                                                            ),
                                                            SizedBox(
                                                              width: Dimensions
                                                                      .sizedBoxWidth10 *
                                                                  2,
                                                            ),
                                                            Provider.of<GlobalProvider>(
                                                                            context)
                                                                        .process ==
                                                                    Processes
                                                                        .waiting
                                                                ? SizedBox(
                                                                    width: Dimensions
                                                                        .sizedBoxWidth10,
                                                                    height: Dimensions
                                                                        .sizedBoxWidth10,
                                                                    child:
                                                                        const CircularProgressIndicator(
                                                                      color: Colors
                                                                          .black,
                                                                      strokeWidth:
                                                                          1,
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    Provider.of<CartProvider>(
                                                                            context)
                                                                        .cart[Provider.of<CartProvider>(context,
                                                                                listen: false)
                                                                            .carts[index][Constants.productId]]
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            Dimensions.font15),
                                                                  ),
                                                            SizedBox(
                                                              width: Dimensions
                                                                      .sizedBoxWidth10 *
                                                                  2,
                                                            ),
                                                            IconBox(
                                                              pressed:
                                                                  () async {
                                                                Provider.of<GlobalProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .setProcess(
                                                                        Processes
                                                                            .waiting);

                                                                await Provider.of<
                                                                            CartProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .increaseCartProduct(
                                                                        Provider.of<CartProvider>(context, listen: false).carts[index]
                                                                            [
                                                                            Constants
                                                                                .productId],
                                                                        FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .uid,
                                                                        prodData[index][Constants
                                                                            .prodCategory],
                                                                        prodData[index][Constants
                                                                            .shopName],
                                                                        prodData[index]
                                                                            [Constants.prodNewPrice])
                                                                    .then((value) => Provider.of<GlobalProvider>(context, listen: false).setProcess(Processes.done));
                                                              },
                                                              icon: Icons.add,
                                                              width: Dimensions
                                                                      .sizedBoxWidth10 *
                                                                  3,
                                                              height: Dimensions
                                                                      .sizedBoxWidth10 *
                                                                  3,
                                                              color: Constants
                                                                  .tetiary,
                                                              borderColor: Colors
                                                                  .transparent,
                                                              iconSize:
                                                                  Dimensions
                                                                      .font24,
                                                              iconColor:
                                                                  Constants
                                                                      .white,
                                                              isDisabled: Provider.of<GlobalProvider>(
                                                                              context)
                                                                          .process ==
                                                                      Processes
                                                                          .waiting
                                                                  ? true
                                                                  : false,
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
                                                const Duration(
                                                    milliseconds: 100),
                                                () => Get.toNamed(
                                                    RouteHelper
                                                        .getProductDetailsPage(),
                                                    arguments:
                                                        prodData[index])),
                                          );
                                        },
                                      ),
                              ],
                            ),
                          ),
                          DetailsBottomNav(
                            // isAdded: false,
                            pressed: () async {
                              List data = prodData;

                              Provider.of<GlobalProvider>(context,
                                      listen: false)
                                  .setProcess(Processes.waiting);

                              List<int> quantity = [];
                              List amount = [];

                              for (var element in Provider.of<CartProvider>(
                                      context,
                                      listen: false)
                                  .carts) {
                                int q = Provider.of<CartProvider>(context,
                                        listen: false)
                                    .cart[element[Constants.productId]];
                                Map<String, dynamic> cart = (prodData
                                    .where((element1) =>
                                        element1[Constants.uid] ==
                                        element[Constants.productId])
                                    .elementAt(0));

                                quantity.add(q);
                                amount.add(cart[Constants.prodNewPrice] * q);
                              }

                              await Provider.of<OrderProvider>(context,
                                      listen: false)
                                  .createOrder(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      amount,
                                      quantity,
                                      prodData.isEmpty ? null : prodData,
                                      fProdData.isEmpty ? null : fProdData,
                                      fProdData.isNotEmpty
                                          ? ((Provider.of<ShopProvider>(context,
                                                      listen: false)
                                                  .shops
                                                  .where((element) =>
                                                      element[
                                                          Constants.shopName] ==
                                                      foodCart[0]
                                                          [Constants.shopName])
                                                  .elementAt(0))
                                              as Map)[Constants.imgUrls][0]
                                          : null,
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .userData[Constants.userPhone])
                                  .then((value) async {
                                if (value) {
                                  Provider.of<GlobalProvider>(context,
                                          listen: false)
                                      .setProcess(Processes.done);

                                  for (var element in data) {
                                    await Provider.of<UserProvider>(context,
                                            listen: false)
                                        .addToInbox(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            element[Constants.imgUrls][0],
                                            'You placed an order on this product',
                                            'Order');
                                  }
                                  Get.to(() => const OrderCompletePage());
                                }
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
                                'PLACE ORDER ($currency${Constants.format.format(Provider.of<CartProvider>(context).cartSubtotal)})',
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight10,
                          ),
                        ],
                      ),
                    );
            }));
  }

  Widget _showDialog(
      context, String? prodId, List amount, bool showSaved, String? shopName) {
    // SnackBar(content: Text('content'));
    List favs =
        Provider.of<UserProvider>(context).userData[Constants.userFavourites];

    return Dialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10 * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.sizedBoxWidth15 * 2,
                vertical: Dimensions.sizedBoxHeight10 * 2),
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
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font20),
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
                showSaved
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Dimensions.sizedBoxHeight100 / 2,
                            width: double.maxFinite,
                            child: ElevatedBtn(
                              pressed: () async {
                                Provider.of<GlobalProvider>(context,
                                        listen: false)
                                    .setProcess(Processes.waiting);
                                String uid =
                                    FirebaseAuth.instance.currentUser!.uid;

                                if (!favs.contains(prodId)) {
                                  await Provider.of<UserProvider>(context,
                                          listen: false)
                                      .updateUserData({
                                    Constants.userFavourites: [...favs, prodId]
                                  }, uid).then((value) async {
                                    if (value) {
                                      await Provider.of<CartProvider>(context,
                                              listen: false)
                                          .removeFromCart(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              prodId!,
                                              amount[0],
                                              false)
                                          .whenComplete(() => Constants(context)
                                              .snackBar(
                                                  'Product added to Saved Items',
                                                  Constants.tetiary));
                                    }
                                  });
                                } else {
                                  Constants(context).snackBar(
                                      'Product is already in your saved list',
                                      Colors.red);
                                }
                                Provider.of<GlobalProvider>(context,
                                        listen: false)
                                    .setProcess(Processes.done);

                                Navigator.pop(context);
                              },
                              text: 'SAVE FOR LATER',
                              textColor: Constants.tetiary,
                              isElevated: false,
                              addBorder: true,
                              disabled: Provider.of<GlobalProvider>(context)
                                          .process ==
                                      Processes.waiting
                                  ? true
                                  : false,
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Constants.tetiary,
                              ),
                              child: Provider.of<GlobalProvider>(context)
                                          .process ==
                                      Processes.waiting
                                  ? SizedBox(
                                      width: Dimensions.sizedBoxWidth10 * 2,
                                      height: Dimensions.sizedBoxWidth10 * 2,
                                      child: const CircularProgressIndicator(
                                        color: Constants.tetiary,
                                        strokeWidth: 3,
                                      ))
                                  : Text(
                                      'SAVE FOR LATER',
                                      style: TextStyle(
                                          color: Constants.tetiary,
                                          fontSize: Dimensions.font14),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.sizedBoxHeight10,
                          )
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: Dimensions.sizedBoxHeight100 / 2,
                  width: double.maxFinite,
                  child: ElevatedBtn(
                    text: 'REMOVE ITEM',
                    pressed: showSaved
                        ? () async {
                            Provider.of<GlobalProvider>(context, listen: false)
                                .setProcess(Processes.waiting);

                            await Provider.of<CartProvider>(context,
                                    listen: false)
                                .removeFromCart(
                                    FirebaseAuth.instance.currentUser!.uid,
                                    prodId!,
                                    amount[0],
                                    true)
                                .then((value) {
                              Provider.of<GlobalProvider>(context,
                                      listen: false)
                                  .setProcess(Processes.done);

                              if (value) Navigator.pop(context);
                            });
                          }
                        : (() async {
                            await Provider.of<CartProvider>(context,
                                    listen: false)
                                .removeFromFoodCart(
                                    FirebaseAuth.instance.currentUser!.uid,
                                    null,
                                    amount.reduce(
                                        (value, element) => value + element),
                                    shopName!,
                                    true,
                                    null,
                                    true,
                                    true)
                                .whenComplete(() {
                              Provider.of<GlobalProvider>(context,
                                      listen: false)
                                  .setProcess(Processes.done);

                              Navigator.pop(context);
                            });
                          }),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Constants.white,
                    ),
                    disabled: Provider.of<GlobalProvider>(context).process ==
                            Processes.waiting
                        ? true
                        : false,
                    child: Provider.of<GlobalProvider>(context).process ==
                            Processes.waiting
                        ? SizedBox(
                            width: Dimensions.sizedBoxWidth10 * 2,
                            height: Dimensions.sizedBoxWidth10 * 2,
                            child: const CircularProgressIndicator(
                              color: Constants.white,
                              strokeWidth: 3,
                            ))
                        : Text(
                            'REMOVE ITEM',
                            style: TextStyle(
                                color: Constants.white,
                                fontSize: Dimensions.font14),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
