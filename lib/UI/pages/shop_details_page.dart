import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:GOCart/PROVIDERS/shop_provider.dart';
import 'package:GOCart/UI/components/product_box.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:GOCart/UI/widgets/star_rating_widget.dart';

import '../../CONSTANTS/constants.dart';
import '../../PROVIDERS/cart_provider.dart';
import '../components/search.dart';
import '../routes/route_helper.dart';
import '../utils/dimensions.dart';

class ShopDetailsPage extends StatefulWidget {
  final String shopId;

  const ShopDetailsPage({super.key, required this.shopId});

  @override
  State<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  getShopData() async {
    return await Provider.of<ShopProvider>(context, listen: false)
        .getShopData(widget.shopId);
  }

  @override
  Widget build(BuildContext context) {
    // var data = getShopData();
    // print(data);
    // Future.delayed(Duration(s: 100), (() => getShopProducts()));

    return Scaffold(
      body: FutureBuilder(
        future: getShopData(),
        builder: (context, AsyncSnapshot snapshot) {
          var data = {};

          if (snapshot.hasData) {
            data = snapshot.data;
          }

          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(color: Constants.tetiary),
                )
              : (snapshot.data != null
                  ? NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverAppBar(
                            collapsedHeight: Dimensions.sizedBoxHeight10 * 7.5,
                            expandedHeight: Dimensions.sizedBoxHeight100 * 2.5,
                            pinned: true,
                            automaticallyImplyLeading: true,
                            iconTheme: const IconThemeData(
                                color: Color.fromARGB(255, 228, 228, 228)),
                            flexibleSpace: Stack(
                              children: [
                                CarouselSlider.builder(
                                  options: CarouselOptions(
                                    height: Dimensions.sizedBoxHeight320,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 7),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    viewportFraction: 1,
                                    enableInfiniteScroll: false,
                                    scrollDirection: Axis.horizontal,
                                    initialPage: 0,
                                  ),
                                  itemCount: data[Constants.imgUrls].length,
                                  itemBuilder: (context, index, realIndex) {
                                    return _buildPageItem(
                                        data[Constants.imgUrls][index]);
                                  },
                                ),
                                Container(
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(81, 0, 0, 0),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxWidth10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        width: double.maxFinite,
                                        height:
                                            Dimensions.sizedBoxHeight10 * 7.5,
                                        padding: EdgeInsets.only(
                                            top: Dimensions.sizedBoxHeight15,
                                            bottom: Dimensions.sizedBoxHeight15,
                                            left:
                                                Dimensions.sizedBoxWidth10 * 6,
                                            right: Dimensions.sizedBoxWidth15),
                                        color: const Color.fromARGB(
                                            179, 31, 31, 31),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data[Constants.shopName],
                                              style: TextStyle(
                                                  color: Constants.tetiary,
                                                  fontSize: Dimensions.font24,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              data[Constants.prodCategory][0],
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 214, 214, 214),
                                                  fontSize: Dimensions.font17,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        )),
                                  ),
                                )
                              ],
                            ),
                            backgroundColor: Colors.transparent,
                            systemOverlayStyle: const SystemUiOverlayStyle(
                                statusBarColor: Color.fromARGB(179, 31, 31, 31),
                                statusBarBrightness: Brightness.light,
                                statusBarIconBrightness: Brightness.light),
                            actions: [
                              const Search(),
                              Row(
                                children: [
                                  IconButton(
                                    splashRadius: 24,
                                    tooltip: 'Cart',
                                    icon: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const Icon(
                                            Icons.shopping_cart_outlined),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Provider.of<CartProvider>(
                                                          context)
                                                      .cartListNo <
                                                  1
                                              ? Container()
                                              : Container(
                                                  width: Dimensions.font15,
                                                  height: Dimensions.font15,
                                                  margin: EdgeInsets.only(
                                                      // top: Dimensions.sizedBoxHeight10,
                                                      left: Dimensions
                                                          .sizedBoxWidth15),
                                                  decoration: BoxDecoration(
                                                      color: Constants.tetiary,
                                                      border: Border.all(
                                                          color: Colors
                                                              .transparent),
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                                  .sizedBoxWidth4 *
                                                              2)),
                                                  child: Center(
                                                    child: Text(
                                                      Provider.of<CartProvider>(
                                                              context)
                                                          .cartListNo
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Constants.white,
                                                          fontSize:
                                                              Dimensions.font11,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      Get.toNamed(RouteHelper.getRoutePage(),
                                          arguments: 2);
                                    },
                                  ),
                                ],
                              ),
                              PopupMenuButton(
                                splashRadius: 24,
                                tooltip: 'Menu',
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      padding: const EdgeInsets.all(0),
                                      onTap: (() {}),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: Dimensions.sizedBoxWidth15),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 225, 225, 225))),
                                        ),
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 0),
                                          minVerticalPadding: 0.0,
                                          visualDensity:
                                              const VisualDensity(vertical: -2),
                                          horizontalTitleGap:
                                              Dimensions.sizedBoxWidth3,
                                          leading:
                                              const Icon(Icons.home_outlined),
                                          title: const Text('Home'),
                                          onTap: (() {
                                            // Get.toNamed(RouteHelper.getRoutePage(0));
                                            Get.offAllNamed(
                                                RouteHelper.getRoutePage(),
                                                arguments: 0);
                                          }),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                        padding: const EdgeInsets.all(0),
                                        onTap: (() {}),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: Dimensions.sizedBoxWidth15),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 225, 225, 225))),
                                          ),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0, horizontal: 0),
                                            minVerticalPadding: 0.0,
                                            visualDensity: const VisualDensity(
                                                vertical: -2),
                                            horizontalTitleGap:
                                                Dimensions.sizedBoxWidth3,
                                            leading: const Icon(
                                                Icons.category_outlined),
                                            title: const Text('Category'),
                                            onTap: (() => Get.offAllNamed(
                                                RouteHelper.getRoutePage(),
                                                arguments: 1)),
                                          ),
                                        )),
                                    PopupMenuItem(
                                        padding: const EdgeInsets.all(0),
                                        onTap: (() {}),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: Dimensions.sizedBoxWidth15),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 225, 225, 225))),
                                          ),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0, horizontal: 0),
                                            minVerticalPadding: 0.0,
                                            visualDensity: const VisualDensity(
                                                vertical: -2),
                                            horizontalTitleGap:
                                                Dimensions.sizedBoxWidth3,
                                            leading: const Icon(
                                                Icons.shop_2_outlined),
                                            title: const Text('Shops'),
                                            onTap: (() => Get.offAllNamed(
                                                RouteHelper.getRoutePage(),
                                                arguments: 3)),
                                          ),
                                        )),
                                    PopupMenuItem(
                                        padding: const EdgeInsets.all(0),
                                        onTap: (() {}),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: Dimensions.sizedBoxWidth15),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0, horizontal: 0),
                                            minVerticalPadding: 0.0,
                                            visualDensity: const VisualDensity(
                                                vertical: -2),
                                            horizontalTitleGap:
                                                Dimensions.sizedBoxWidth3,
                                            leading: const Icon(
                                                Icons.person_outline),
                                            title: const Text('Account'),
                                            onTap: (() => Get.offAllNamed(
                                                RouteHelper.getRoutePage(),
                                                arguments: 4)),
                                          ),
                                        )),
                                  ];
                                },
                              ),
                            ],
                          ),
                        ];
                      },
                      body: StreamBuilder(
                        stream:
                            Provider.of<ShopProvider>(context, listen: false)
                                .getAllShopProducts(widget.shopId),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
                          List products = [];
                          List foodProducts = [];

                          if (snapshot1.hasData) {
                            for (var element in snapshot1.data!.docs) {
                              var data1 = element.data() as Map;

                              // setState(() {
                              if (data1[Constants.prodCategory] ==
                                  'Cooked Foods') {
                                foodProducts.add(data1);
                              } else {
                                products.add(data1);
                              }
                              // });
                            }
                          }

                          if (snapshot.hasError) {
                            Constants(context).snackBar(
                                'There was a problem loading this data',
                                Colors.red);

                            return const Center(
                              child: Text('No products in this shop'),
                            );
                          }

                          return snapshot1.connectionState ==
                                  ConnectionState.waiting
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: Constants.tetiary),
                                )
                              : SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Container(
                                    padding: EdgeInsets.all(
                                        Dimensions.sizedBoxWidth15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            foodProducts.isEmpty
                                                ? Container()
                                                : Column(
                                                    children: [
                                                      SizedBox(
                                                        height: Dimensions
                                                                .sizedBoxHeight10 *
                                                            2,
                                                      ),
                                                      Text(
                                                        'FOOD',
                                                        style: TextStyle(
                                                            fontSize: Dimensions
                                                                .font20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                75,
                                                                75,
                                                                75)),
                                                      ),
                                                      ListView.builder(
                                                        itemCount:
                                                            foodProducts.length,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            width: double
                                                                .maxFinite,
                                                            height: Dimensions
                                                                    .sizedBoxHeight10 *
                                                                13,
                                                            margin: EdgeInsets.only(
                                                                bottom: Dimensions
                                                                        .sizedBoxHeight10 *
                                                                    2),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                          .sizedBoxWidth4),
                                                            ),
                                                            child: Material(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                          .sizedBoxWidth4),
                                                              color: Constants
                                                                  .white,
                                                              child: InkWell(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Ink(
                                                                      height:
                                                                          Dimensions.sizedBoxWidth10 *
                                                                              13,
                                                                      width:
                                                                          Dimensions.sizedBoxWidth10 *
                                                                              13,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.only(
                                                                              bottomLeft: Radius.circular(Dimensions
                                                                                  .sizedBoxWidth4),
                                                                              topLeft: Radius.circular(Dimensions
                                                                                  .sizedBoxWidth4)),
                                                                          image: DecorationImage(
                                                                              image: CachedNetworkImageProvider(data[Constants.imgUrls][0]),
                                                                              fit: BoxFit.cover)),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Ink(
                                                                        width: double
                                                                            .maxFinite,
                                                                        height:
                                                                            double.maxFinite,
                                                                        padding:
                                                                            EdgeInsets.all(Dimensions.sizedBoxWidth10),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius: BorderRadius.only(
                                                                              topRight: Radius.circular(Dimensions.sizedBoxWidth4),
                                                                              bottomRight: Radius.circular(Dimensions.sizedBoxWidth4)),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  'Tractor with wide rollers and high cost maintainence',
                                                                                  style: TextStyle(fontSize: Dimensions.font13),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: Dimensions.sizedBoxHeight10,
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          'Sales:',
                                                                                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.font12, color: Constants.grey),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: Dimensions.sizedBoxWidth3,
                                                                                        ),
                                                                                        Text(
                                                                                          '213',
                                                                                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.font12),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    StarRating(
                                                                                      rating: foodProducts[index][Constants.prodRating],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: Dimensions.sizedBoxHeight10 / 2,
                                                                                ),
                                                                                Text(
                                                                                  '\$ 250 - ~',
                                                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.font18),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: Dimensions.sizedBoxHeight10 * 2,
                                                                            ),
                                                                            Expanded(
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Ink(
                                                                                      width: double.maxFinite,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.location_on_outlined,
                                                                                            size: Dimensions.font12,
                                                                                            color: Constants.grey,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: Dimensions.sizedBoxWidth3,
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Ink(
                                                                                              width: double.maxFinite,
                                                                                              child: Text(
                                                                                                '3rd block Bakasi hall, yabatech',
                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.font12, color: Colors.grey),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: Dimensions.sizedBoxWidth10 / 2,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Ink(
                                                                                      width: double.maxFinite,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.storefront,
                                                                                            size: Dimensions.font12,
                                                                                            color: Constants.grey,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: Dimensions.sizedBoxWidth3,
                                                                                          ),
                                                                                          Text(
                                                                                            'Mr Kola Shop',
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.font12, color: Constants.grey),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                onTap: () {
                                                                  Timer(
                                                                      const Duration(
                                                                          milliseconds:
                                                                              200),
                                                                      (() => showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              _showDialog(context))));
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  )
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              Dimensions.sizedBoxHeight10 * 2,
                                        ),
                                        products.isNotEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'PRODUCTS',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Dimensions.font20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 75, 75, 75)),
                                                  ),
                                                  ProductBox(
                                                    left: 0,
                                                    right: 0,
                                                    snapshotDocs: products,
                                                  ),
                                                ],
                                              )
                                            : (products.isEmpty &&
                                                    foodProducts.isEmpty
                                                ? const Center(
                                                    child: Text(
                                                        'No products in this shop'),
                                                  )
                                                : Container()),
                                      ],
                                    ),
                                  ),
                                );
                        },
                      ),
                    )
                  : const Text('Shop data not found'));
        },
      ),
    );
  }

  Widget _buildPageItem(String imgUrl) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(imgUrl), fit: BoxFit.cover)),
    );
  }

  Widget _showDialog(context) {
    return Dialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10 * 2),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.sizedBoxWidth15,
            vertical: Dimensions.sizedBoxHeight15),
        height: Dimensions.sizedBoxHeight10 * 27,
        decoration: BoxDecoration(
            color: Constants.white,
            borderRadius: BorderRadius.circular(Dimensions.font25 / 5)),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Food Cart',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.font18),
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
              const Text(
                  'Do you want to add this item to your food cart? If so enter the amount you would love to purchase'),
              SizedBox(
                height: Dimensions.sizedBoxHeight10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                autofocus: true,
                validator: (value) {
                  if (value == '') {
                    return Constants.err;
                  } else {
                    if (RegExp(r'^[0-9]*$').hasMatch(value!)) {
                      if (int.parse(value) < 10) {
                        return 'Please enter at least \$ 10';
                      }
                    } else {
                      return 'Invalid amount!';
                    }
                  }

                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.attach_money,
                    color: Constants.tetiary,
                  ),
                  labelText: 'Amount',
                  helperText: 'Please enter at least \$ 10',
                ),
                cursorColor: Constants.tetiary,
              ),
              SizedBox(
                height: Dimensions.sizedBoxHeight15 * 2,
              ),
              SizedBox(
                  width: double.maxFinite,
                  height: Dimensions.sizedBoxHeight100 / 2,
                  child: ElevatedBtn(
                    text: 'ADD TO FOOD CART',
                    icon: const Icon(Icons.add_shopping_cart_outlined),
                    pressed: () {
                      if (key.currentState!.validate()) {}
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
