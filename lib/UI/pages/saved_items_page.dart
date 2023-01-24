import 'dart:async';

import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../PROVIDERS/cart_provider.dart';
import '../../PROVIDERS/user_provider.dart';
import '../components/home_app_bar.dart';
import '../../CONSTANTS/constants.dart';
import '../routes/route_helper.dart';
import '../utils/dimensions.dart';
import '../widgets/box_chip_widget.dart';
import '../widgets/elevated_button_widget.dart';

class SavedItemsPage extends StatefulWidget {
  const SavedItemsPage({super.key});

  @override
  State<SavedItemsPage> createState() => _SavedItemsPageState();
}

class _SavedItemsPageState extends State<SavedItemsPage> {
  getAllSavedItems(BuildContext context) async {
    List favs = Provider.of<UserProvider>(context, listen: false)
        .userData[Constants.userFavourites];

    List<Map<String, dynamic>> data = [];

    for (var element in favs) {
      await Provider.of<ProductProvider>(context, listen: false)
          .getProductData(element)
          .then((value) {
        data.add(value);
      });
    }

    return data;
  }

  bool changed = false;

  @override
  Widget build(BuildContext context) {
    String currency = Constants(context).currency().currencySymbol;

    return Scaffold(
      appBar: HomeAppBar(
        title: 'Saved Items',
        showCart: true,
        implyLeading: true,
        textSize: Dimensions.font24,
      ),
      body: FutureBuilder(
        future: getAllSavedItems(context),
        builder: (context, AsyncSnapshot snapshot) {
          List<Map<String, dynamic>> savedItems = [];
          List favs = Provider.of<UserProvider>(context)
              .userData[Constants.userFavourites];

          if (snapshot.hasData) {
            savedItems = snapshot.data;
          }

          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Constants.tetiary,
                  ),
                )
              : SingleChildScrollView(
                  child: savedItems.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Icon(
                                Icons.favorite,
                                size: Dimensions.sizedBoxWidth25 * 6,
                                color: const Color.fromARGB(255, 186, 186, 186),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.sizedBoxWidth15 * 2,
                            ),
                            Center(
                              child: Text(
                                'You don\'t have any saved items',
                                style: TextStyle(
                                    color: Constants.grey,
                                    fontSize: Dimensions.font16),
                              ),
                            )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.all(Dimensions.sizedBoxHeight10),
                              child: ListView.builder(
                                itemCount: savedItems.length,
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
                                                  height: Dimensions
                                                      .sizedBoxHeight100,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: CachedNetworkImageProvider(
                                                              savedItems[index][
                                                                      Constants
                                                                          .imgUrls]
                                                                  [0]),
                                                          fit: BoxFit.contain)),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    Dimensions.sizedBoxWidth10,
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
                                                      savedItems[index]
                                                          [Constants.name],
                                                      style: TextStyle(
                                                          fontSize: Dimensions
                                                              .font12),
                                                    ),
                                                    SizedBox(
                                                      height: Dimensions
                                                              .sizedBoxHeight4 *
                                                          2,
                                                    ),
                                                    Text(
                                                      '$currency${savedItems[index][Constants.prodNewPrice]}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              Dimensions.font16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    savedItems[index][Constants
                                                                .prodOldPrice] >
                                                            savedItems[index][
                                                                Constants
                                                                    .prodNewPrice]
                                                        ? Row(
                                                            children: [
                                                              Text(
                                                                '$currency${savedItems[index][Constants.prodOldPrice]}',
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
                                                                    '-${(((savedItems[index][Constants.prodOldPrice] - savedItems[index][Constants.prodNewPrice]) / savedItems[index][Constants.prodOldPrice]) * 100).toStringAsFixed(2)}%',
                                                                pad: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      Dimensions
                                                                          .sizedBoxWidth4,
                                                                  vertical:
                                                                      Dimensions
                                                                              .sizedBoxHeight3 *
                                                                          2,
                                                                ),
                                                                textSize:
                                                                    Dimensions
                                                                        .font14,
                                                                textWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: const Color
                                                                        .fromARGB(
                                                                    35,
                                                                    248,
                                                                    194,
                                                                    0),
                                                                textColor:
                                                                    Constants
                                                                        .tetiary,
                                                              )
                                                            ],
                                                          )
                                                        : SizedBox(
                                                            height: Dimensions
                                                                    .sizedBoxHeight4 *
                                                                2,
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
                                                  onTap: (() async {
                                                    favs.remove(
                                                        savedItems[index]
                                                            [Constants.uid]);

                                                    await Provider.of<
                                                                UserProvider>(
                                                            context,
                                                            listen: false)
                                                        .updateUserData(
                                                            {
                                                          Constants
                                                                  .userFavourites:
                                                              favs
                                                        },
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid).then(
                                                            (value) {
                                                      if (value) {
                                                        Constants(context).snackBar(
                                                            'Product removed from Saved Items',
                                                            Constants.tetiary);

                                                        setState(() {
                                                          changed = !changed;
                                                        });
                                                      }
                                                    });
                                                  }),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.delete_outline,
                                                        color:
                                                            Constants.tetiary,
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
                                                                FontWeight.w500,
                                                            fontSize: Dimensions
                                                                .font15),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    Dimensions.sizedBoxWidth148,
                                                height: Dimensions
                                                        .sizedBoxHeight10 *
                                                    4,
                                                child: ElevatedBtn(
                                                    pressed: () async {
                                                      await Provider.of<CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .addToCart(
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                              savedItems[index][
                                                                  Constants
                                                                      .uid],
                                                              savedItems[index][
                                                                  Constants
                                                                      .prodNewPrice],
                                                              savedItems[index][
                                                                  Constants
                                                                      .shopName])
                                                          .then((value) async {
                                                        favs.remove(savedItems[
                                                                index]
                                                            [Constants.uid]);

                                                        await Provider.of<
                                                                    UserProvider>(
                                                                context,
                                                                listen: false)
                                                            .updateUserData(
                                                                {
                                                              Constants
                                                                      .userFavourites:
                                                                  favs
                                                            },
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid);

                                                        setState(() {
                                                          changed = !changed;
                                                        });
                                                      });
                                                    },
                                                    text: 'ADD TO CART'),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () => Timer(
                                        const Duration(milliseconds: 200),
                                        () => Get.toNamed(
                                            RouteHelper.getProductDetailsPage(),
                                            arguments: savedItems[index])),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                );
        },
      ),
    );
  }
}
