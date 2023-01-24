import 'dart:async';

import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:GOCart/UI/widgets/list_tile_btn_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../CONSTANTS/constants.dart';
import '../../../PROVIDERS/product_provider.dart';
import '../../../PROVIDERS/shop_provider.dart';
import '../../utils/dimensions.dart';
import '../../widgets/star_rating_widget.dart';

class CheckProductsPage extends StatelessWidget {
  final String shopId;
  final String shopName;

  const CheckProductsPage(
      {super.key, required this.shopId, required this.shopName});

  @override
  Widget build(BuildContext context) {
    String currency = Constants(context).currency().currencySymbol;

    return StreamBuilder(
      stream: Provider.of<ShopProvider>(context, listen: false)
          .getAllShopProducts(shopId),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List data = [];

        if (snapshot.hasData) {
          for (var element in snapshot.data!.docs) {
            data.add(element.data());
          }
        }

        if (snapshot.hasError) {
          Constants(context).snackBar('Something went wrong!', Colors.red);

          return const Center(
            child: Text('No Products'),
          );
        }

        return snapshot.connectionState == ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(color: Constants.tetiary),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Material(
                        child: Ink(
                            decoration: BoxDecoration(
                                color: Constants.white,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.sizedBoxWidth10 / 2)),
                            child: ListTileBtn(
                              title: 'Add Products',
                              textSize: Dimensions.font17,
                              textColor:
                                  const Color.fromARGB(255, 130, 130, 130),
                              trailing: const Icon(
                                Icons.add_task,
                                color: Color.fromARGB(255, 89, 89, 89),
                              ),
                              onTap: () {
                                Timer(
                                    const Duration(milliseconds: 200),
                                    () => Get.toNamed(
                                            RouteHelper.getAddProductPage(),
                                            arguments: {
                                              Constants.shopName: shopName,
                                              Constants.shopId: shopId
                                            }));
                              },
                            )),
                      ),
                      SizedBox(
                        height: Dimensions.sizedBoxHeight15,
                      ),
                      (data.isEmpty
                          ? const Center(
                              child: Text('No products'),
                            )
                          : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing:
                                          Dimensions.sizedBoxHeight10 * 2,
                                      crossAxisSpacing:
                                          Dimensions.sizedBoxWidth10,
                                      childAspectRatio: 0.7),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Material(
                                  animationDuration:
                                      const Duration(milliseconds: 100),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxWidth4),
                                  ),
                                  elevation: 5,
                                  shadowColor:
                                      const Color.fromARGB(125, 0, 0, 0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxWidth4),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.sizedBoxWidth4),
                                        color: Constants.white,
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  Dimensions.sizedBoxWidth10),
                                              child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Ink(
                                                      height: double.maxFinite,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: CachedNetworkImageProvider(data[
                                                                          index]
                                                                      [
                                                                      Constants
                                                                          .imgUrls]
                                                                  [0]),
                                                              fit: BoxFit
                                                                  .contain)),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Container(
                                                          width: Dimensions
                                                                  .sizedBoxWidth10 *
                                                              2.5,
                                                          height: Dimensions
                                                                  .sizedBoxWidth10 *
                                                              2.5,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                          .sizedBoxWidth3),
                                                              color: Constants
                                                                  .primary
                                                                  .withAlpha(
                                                                      70)),
                                                          child: Center(
                                                            child:
                                                                PopupMenuButton(
                                                              tooltip:
                                                                  'Actions',
                                                              icon: const Icon(
                                                                Icons
                                                                    .more_horiz,
                                                                color: Colors
                                                                    .black,
                                                                size: 15,
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              itemBuilder:
                                                                  (context) {
                                                                return [
                                                                  PopupMenuItem(
                                                                      onTap:
                                                                          () {
                                                                        Timer(
                                                                            const Duration(milliseconds: 200),
                                                                            () => Get.toNamed(RouteHelper.getEditProductPage(), arguments: data[index]));
                                                                      },
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              0),
                                                                      child: Container(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                                                          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 225, 225, 225)))),
                                                                          child: const ListTileBtn(
                                                                            title:
                                                                                'Edit',
                                                                            trailing:
                                                                                Icon(
                                                                              Icons.drive_file_rename_outline_rounded,
                                                                              color: Colors.blue,
                                                                            ),
                                                                            visualD:
                                                                                -4,
                                                                          ))),
                                                                  PopupMenuItem(
                                                                      child:
                                                                          ListTileBtn(
                                                                    onTap: () {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (context) => _showDialog(
                                                                              context,
                                                                              data[index][Constants.uid]));
                                                                    },
                                                                    title:
                                                                        'Delete',
                                                                    trailing:
                                                                        const Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                    visualD: -3,
                                                                  )),
                                                                ];
                                                              },
                                                            ),
                                                          )),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                          Ink(
                                            padding: EdgeInsets.only(
                                                left:
                                                    Dimensions.sizedBoxWidth10,
                                                right:
                                                    Dimensions.sizedBoxWidth10,
                                                bottom: Dimensions
                                                    .sizedBoxHeight10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                        Dimensions
                                                            .sizedBoxWidth4),
                                                    bottomRight: Radius
                                                        .circular(Dimensions
                                                            .sizedBoxWidth4)),
                                                color: Constants.white),
                                            width: double.maxFinite,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data[index][Constants.name],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font13,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                SizedBox(
                                                  height: Dimensions
                                                      .sizedBoxHeight4,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '$currency ${data[index][Constants.prodNewPrice]}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              Dimensions.font16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Stock:',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  Dimensions
                                                                      .font12,
                                                              color: Constants
                                                                  .grey),
                                                        ),
                                                        SizedBox(
                                                          width: Dimensions
                                                              .sizedBoxWidth3,
                                                        ),
                                                        Text(
                                                          data[index][Constants
                                                                  .prodTotalStock]
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  Dimensions
                                                                      .font12),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Dimensions
                                                      .sizedBoxHeight4,
                                                ),
                                                StarRating(rating: data[index][Constants.prodRating],),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                );
                              },
                            ))
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget _showDialog(context, String prodId) {
    return Dialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10 * 2),
      child: Container(
        padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to delete this product?',
              style: TextStyle(
                  fontSize: Dimensions.font18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: Dimensions.sizedBoxWidth15 * 2,
            ),
            Row(
              children: [
                SizedBox(
                  width: Dimensions.sizedBoxWidth15,
                ),
                Expanded(
                  child: SizedBox(
                    height: Dimensions.sizedBoxHeight10 * 4,
                    width: double.maxFinite,
                    child: ElevatedBtn(
                      pressed: () async {
                        await Provider.of<ProductProvider>(context,
                                listen: false)
                            .deleteProduct(prodId)
                            .then((value) {
                          if (value) {
                            Constants(context).snackBar(
                                'Product has been deleted successfully! ✅',
                                Constants.tetiary);

                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        });
                      },
                      bgColor: Colors.green,
                      icon: const Icon(
                        Icons.task_alt,
                        color: Constants.white,
                      ),
                      child: Provider.of<ProductProvider>(context).process ==
                              Process.processing
                          ? SizedBox(
                              width: Dimensions.sizedBoxWidth10 * 2,
                              height: Dimensions.sizedBoxWidth10 * 2,
                              child: const CircularProgressIndicator(
                                color: Constants.white,
                                strokeWidth: 3,
                              ))
                          : Text(
                              'YES',
                              style: TextStyle(
                                  color: Constants.white,
                                  fontSize: Dimensions.font14),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimensions.sizedBoxWidth10 * 2,
                ),
                Expanded(
                    child: SizedBox(
                  height: Dimensions.sizedBoxHeight10 * 4,
                  width: double.maxFinite,
                  child: ElevatedBtn(
                      text: 'NO',
                      bgColor: Colors.red,
                      pressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: Constants.white,
                      )),
                )),
                SizedBox(
                  width: Dimensions.sizedBoxWidth15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
