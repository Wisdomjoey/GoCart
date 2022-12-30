import 'dart:async';

import 'package:GOCart/UI/components/product_box.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:GOCart/UI/widgets/star_rating_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../components/search.dart';
import '../constants/constants.dart';
import '../routes/route_helper.dart';
import '../utils/dimensions.dart';

class ShopDetailsPage extends StatefulWidget {
  const ShopDetailsPage({super.key});

  @override
  State<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
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
                      autoPlayInterval: const Duration(seconds: 7),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.horizontal,
                      initialPage: 0,
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index, realIndex) {
                      return _buildPageItem();
                    },
                  ),
                  Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(81, 0, 0, 0),
                      borderRadius:
                          BorderRadius.circular(Dimensions.sizedBoxWidth10),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: double.maxFinite,
                          height: Dimensions.sizedBoxHeight10 * 7.5,
                          padding: EdgeInsets.only(
                              top: Dimensions.sizedBoxHeight15,
                              bottom: Dimensions.sizedBoxHeight15,
                              left: Dimensions.sizedBoxWidth10 * 6,
                              right: Dimensions.sizedBoxWidth15),
                          color: const Color.fromARGB(179, 31, 31, 31),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Mr. Kola Shop',
                                style: TextStyle(
                                    color: Constants.tetiary,
                                    fontSize: Dimensions.font24,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Stationaries',
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
                          const Icon(Icons.shopping_cart_outlined),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: Dimensions.font15,
                              height: Dimensions.font15,
                              margin: EdgeInsets.only(
                                  // top: Dimensions.sizedBoxHeight10,
                                  left: Dimensions.sizedBoxWidth15),
                              decoration: BoxDecoration(
                                  color: Constants.tetiary,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.sizedBoxWidth4 * 2)),
                              child: Center(
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                      color: Constants.white,
                                      fontSize: Dimensions.font11,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        Get.toNamed(RouteHelper.getRoutePage(2));
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
                          padding:
                              EdgeInsets.only(left: Dimensions.sizedBoxWidth15),
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Constants.white)),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            minVerticalPadding: 0.0,
                            visualDensity: const VisualDensity(vertical: -2),
                            horizontalTitleGap: Dimensions.sizedBoxWidth3,
                            leading: const Icon(Icons.home_outlined),
                            title: const Text('Home'),
                            onTap: (() {
                              // Get.toNamed(RouteHelper.getRoutePage(0));
                              Get.offAllNamed(RouteHelper.getRoutePage(0));
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
                                      color:
                                          Constants.white)),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              minVerticalPadding: 0.0,
                              visualDensity: const VisualDensity(vertical: -2),
                              horizontalTitleGap: Dimensions.sizedBoxWidth3,
                              leading: const Icon(Icons.category_outlined),
                              title: const Text('Category'),
                              onTap: (() =>
                                  Get.offAllNamed(RouteHelper.getRoutePage(1))),
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
                                      color:
                                          Constants.white)),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              minVerticalPadding: 0.0,
                              visualDensity: const VisualDensity(vertical: -2),
                              horizontalTitleGap: Dimensions.sizedBoxWidth3,
                              leading: const Icon(Icons.shop_2_outlined),
                              title: const Text('Shops'),
                              onTap: (() =>
                                  Get.offAllNamed(RouteHelper.getRoutePage(3))),
                            ),
                          )),
                      PopupMenuItem(
                          padding: const EdgeInsets.all(0),
                          onTap: (() {}),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: Dimensions.sizedBoxWidth15),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              minVerticalPadding: 0.0,
                              visualDensity: const VisualDensity(vertical: -2),
                              horizontalTitleGap: Dimensions.sizedBoxWidth3,
                              leading: const Icon(Icons.person_outline),
                              title: const Text('Account'),
                              onTap: (() =>
                                  Get.offAllNamed(RouteHelper.getRoutePage(4))),
                            ),
                          )),
                    ];
                  },
                ),
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimensions.sizedBoxHeight15 * 2,
                    ),
                    Text(
                      'FOOD',
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 75, 75, 75)),
                    ),
                    ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.maxFinite,
                          height: Dimensions.sizedBoxHeight10 * 13,
                          margin: EdgeInsets.only(
                              bottom: Dimensions.sizedBoxHeight10 * 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.sizedBoxWidth4),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(
                                Dimensions.sizedBoxWidth4),
                            color: Constants.white,
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Ink(
                                    height: Dimensions.sizedBoxWidth10 * 13,
                                    width: Dimensions.sizedBoxWidth10 * 13,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(
                                                Dimensions.sizedBoxWidth4),
                                            topLeft: Radius.circular(
                                                Dimensions.sizedBoxWidth4)),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/med.gif'),
                                            fit: BoxFit.cover)),
                                  ),
                                  Expanded(
                                    child: Ink(
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                      padding: EdgeInsets.all(
                                          Dimensions.sizedBoxWidth10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                                Dimensions.sizedBoxWidth4),
                                            bottomRight: Radius.circular(
                                                Dimensions.sizedBoxWidth4)),
                                      ),
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
                                              Text(
                                                'Tractor with wide rollers and high cost maintainence',
                                                style: TextStyle(
                                                    fontSize:
                                                        Dimensions.font13),
                                              ),
                                              SizedBox(
                                                height:
                                                    Dimensions.sizedBoxHeight10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Sales:',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: Dimensions
                                                                .font12,
                                                            color:
                                                                Constants.grey),
                                                      ),
                                                      SizedBox(
                                                        width: Dimensions
                                                            .sizedBoxWidth3,
                                                      ),
                                                      Text(
                                                        '213',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: Dimensions
                                                                .font12),
                                                      ),
                                                    ],
                                                  ),
                                                  const StarRating(),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Dimensions
                                                        .sizedBoxHeight10 /
                                                    2,
                                              ),
                                              Text(
                                                '\$ 250 - ~',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        Dimensions.font18),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                Dimensions.sizedBoxHeight10 * 2,
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Ink(
                                                    width: double.maxFinite,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          size:
                                                              Dimensions.font12,
                                                          color: Constants.grey,
                                                        ),
                                                        SizedBox(
                                                          width: Dimensions
                                                              .sizedBoxWidth3,
                                                        ),
                                                        Expanded(
                                                          child: Ink(
                                                            width: double
                                                                .maxFinite,
                                                            child: Text(
                                                              '3rd block Bakasi hall, yabatech',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      Dimensions
                                                                          .font12,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimensions
                                                          .sizedBoxWidth10 /
                                                      2,
                                                ),
                                                Expanded(
                                                  child: Ink(
                                                    width: double.maxFinite,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.storefront,
                                                          size:
                                                              Dimensions.font12,
                                                          color: Constants.grey,
                                                        ),
                                                        SizedBox(
                                                          width: Dimensions
                                                              .sizedBoxWidth3,
                                                        ),
                                                        Text(
                                                          'Mr Kola Shop',
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                    const Duration(milliseconds: 200),
                                    (() => showDialog(
                                        context: context,
                                        builder: (context) =>
                                            _showDialog(context))));
                              },
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight15 * 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PRODUCTS',
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 75, 75, 75)),
                    ),
                    const ProductBox(
                      left: 0,
                      right: 0,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageItem() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/med.gif'), fit: BoxFit.cover)),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Food Cart',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: Dimensions.font18),
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
            const TextField(
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.attach_money,
                  color: Constants.tetiary,
                ),
                label: Text('Amount'),
                errorText: 'Please enter at least \$ 10',
              ),
              cursorColor: Constants.tetiary,
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight15 * 2,
            ),
            SizedBox(
                width: double.maxFinite,
                height: Dimensions.sizedBoxHeight100 / 2,
                child: const ElevatedBtn(
                  text: 'ADD TO FOOD CART',
                  icon: Icon(Icons.add_shopping_cart_outlined),
                ))
          ],
        ),
      ),
    );
  }
}
