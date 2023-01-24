import 'package:GOCart/PROVIDERS/shop_provider.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';
import '../utils/dimensions.dart';

class ShopPage extends StatelessWidget {
  ShopPage({super.key});

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Provider.of<ShopProvider>(context).shops.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/shop.png',
                  width: Dimensions.sizedBoxWidth100 * 3,
                ),
              ),
              SizedBox(
                height: Dimensions.sizedBoxWidth15 * 2,
              ),
              const Center(
                child: Text(
                  'No Shops At The Moment',
                  style: TextStyle(color: Constants.grey),
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: Provider.of<ShopProvider>(context).shops.length,
            itemBuilder: ((context, index) {
              List likes = Provider.of<ShopProvider>(context).shops[index]
                  [Constants.likes];

              return Container(
                padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
                margin:
                    EdgeInsets.only(bottom: Dimensions.sizedBoxHeight10 * 2),
                child: Material(
                  borderRadius:
                      BorderRadius.circular(Dimensions.sizedBoxWidth10),
                  elevation: 7,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(Dimensions.sizedBoxWidth10),
                    child: Ink(
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.sizedBoxWidth10),
                      ),
                      child: Stack(
                        children: [
                          Ink(
                            height: Dimensions.sizedBoxHeight10 * 17,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      Provider.of<ShopProvider>(context)
                                          .shops[index][Constants.imgUrls][0]),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.sizedBoxWidth10),
                            ),
                          ),
                          Container(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(63, 0, 0, 0),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.sizedBoxWidth10),
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: Dimensions.sizedBoxHeight10 * 6,
                                width: double.maxFinite,
                                padding: EdgeInsets.only(
                                    left: Dimensions.sizedBoxWidth10,
                                    right: Dimensions.sizedBoxWidth15),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(212, 31, 31, 31),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            Dimensions.sizedBoxWidth10),
                                        bottomRight: Radius.circular(
                                            Dimensions.sizedBoxWidth10))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      splashRadius:
                                          Dimensions.sizedBoxWidth15 * 2,
                                      icon: Icon(
                                        likes.contains(uid)
                                            ? Icons.star_rounded
                                            : Icons.star_border_rounded,
                                        color: const Color.fromARGB(
                                            255, 196, 196, 196),
                                      ),
                                      onPressed: () async {
                                        // setState(() async {
                                        if (likes.contains(uid)) {
                                          List like = Provider.of<ShopProvider>(
                                                  context,
                                                  listen: false)
                                              .shops[index][Constants.likes];

                                          like.remove(uid);

                                          await Provider.of<ShopProvider>(
                                                  context,
                                                  listen: false)
                                              .likeShop(
                                                  {Constants.likes: like},
                                                  Provider.of<ShopProvider>(
                                                              context,
                                                              listen: false)
                                                          .shops[index]
                                                      [Constants.uid]);
                                        } else {
                                          await Provider.of<ShopProvider>(
                                                  context,
                                                  listen: false)
                                              .likeShop(
                                                  {
                                                Constants.likes: [
                                                  ...Provider.of<ShopProvider>(
                                                              context,
                                                              listen: false)
                                                          .shops[index]
                                                      [Constants.likes],
                                                  uid
                                                ]
                                              },
                                                  Provider.of<ShopProvider>(
                                                              context,
                                                              listen: false)
                                                          .shops[index]
                                                      [Constants.uid]);
                                        }
                                        // });
                                      },
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          Provider.of<ShopProvider>(context)
                                              .shops[index][Constants.shopName],
                                          style: TextStyle(
                                              color: Constants.white,
                                              fontSize: Dimensions.font18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height:
                                              Dimensions.sizedBoxHeight10 / 2,
                                        ),
                                        Text(
                                          'Check out ptoducts >',
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 196, 196, 196),
                                              fontSize: Dimensions.font11),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () => Get.toNamed(RouteHelper.getShopDetailsPage(),
                        arguments:
                            Provider.of<ShopProvider>(context, listen: false)
                                .shops[index][Constants.uid]),
                  ),
                ),
              );
            }),
          );
  }
}
