import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:GOCart/UI/components/review_box_con.dart';
import 'package:GOCart/UI/components/details_bottom_navigation.dart';
import 'package:GOCart/UI/components/home_app_bar.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/list_tile_btn_widget.dart';
import 'package:GOCart/UI/widgets/head_section_widget.dart';
import 'package:GOCart/UI/widgets/icon_box_widget.dart';
import 'package:GOCart/UI/widgets/star_rating_widget.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';
import '../../PROVIDERS/cart_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ProductDetailsPage({super.key, required this.data});

  Widget _buildPageItem(String imgUrl, int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimensions.sizedBoxWidth10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => Scaffold(
                    body: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.sizedBoxHeight100 / 2),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          InteractiveViewer(
                            child: SizedBox(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: Hero(
                                  tag: 'preview$index',
                                  child: Image(
                                    image: CachedNetworkImageProvider(imgUrl),
                                  )),
                            ),
                          ),
                          IconButton(
                              onPressed: (() => Navigator.of(context).pop()),
                              icon: Icon(
                                Icons.close,
                                size: Dimensions.sizedBoxWidth15 * 2,
                              )),
                        ],
                      ),
                    ),
                  ))));
        },
        child: Ink(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.font25 / 5),
            color: Constants.white,
            // image: const DecorationImage(
            //     image: AssetImage('assets/images/emptyCart.png'),
            //     fit: BoxFit.contain)
          ),
          child: Hero(
            tag: 'preview$index',
            child: Image(
              image: CachedNetworkImageProvider(imgUrl),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showDialog(context, double deliveryPrice, String currency) {
    return Dialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
      child: Container(
        padding: EdgeInsets.all(Dimensions.sizedBoxWidth10 * 2),
        // height: Dimensions.sizedBoxHeight230,
        decoration: BoxDecoration(
            color: Constants.white,
            borderRadius: BorderRadius.circular(Dimensions.font25 / 5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DELIVERY DETAILS',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: Dimensions.font17),
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
              'IN-CAMPUS DELIVERY',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.font14,
                  color: Constants.grey),
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10,
            ),
            Text(
              'Delivery time starts from the time you place your order. Delivery time ranges from 30mins after order has been placed to 1hr. If you are unreachable, order will be cancelled',
              style: TextStyle(fontSize: Dimensions.font15),
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10 * 2,
            ),
            Text(
              'DELIVERY FEE DETAILS',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.font14,
                  color: Constants.grey),
            ),
            SizedBox(
              height: Dimensions.sizedBoxHeight10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Delivery Amount',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: Dimensions.font14),
                ),
                Text(
                  '$currency $deliveryPrice',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: Dimensions.font14),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> details = getProdDetails();
    // List reviews = getReviews();
    String currency = Constants(context).currency().currencySymbol;

    return Scaffold(
      appBar: HomeAppBar(
        title: 'Details',
        textSize: Dimensions.font24,
        implyLeading: true,
        showPopUp: true,
        showCart: true,
      ),
      body: FutureBuilder(
        initialData: const <QueryDocumentSnapshot>[],
        future: Provider.of<ProductProvider>(context, listen: false)
            .fetchAllReviews(data[Constants.uid]),
        builder: (context, AsyncSnapshot snapshot1) {
          List favs = Provider.of<UserProvider>(context)
              .userData[Constants.userFavourites];

          return snapshot1.connectionState != ConnectionState.done
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Constants.tetiary,
                  ),
                )
              : SingleChildScrollView(
                  child: (data.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: Dimensions.sizedBoxHeight320,
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.sizedBoxHeight10),
                              child: CarouselSlider.builder(
                                options: CarouselOptions(
                                  height: Dimensions.sizedBoxHeight320,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 7),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  viewportFraction: 0.8,
                                  enableInfiniteScroll: false,
                                  scrollDirection: Axis.horizontal,
                                  padEnds: false,
                                  initialPage: 0,
                                ),
                                itemCount: data[Constants.imgUrls].length,
                                itemBuilder: (context, index, realIndex) {
                                  return _buildPageItem(
                                      data[Constants.imgUrls][index],
                                      index,
                                      context);
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.sizedBoxWidth10 * 2,
                                  vertical: Dimensions.sizedBoxHeight10),
                              width: double.maxFinite,
                              color: Constants.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[Constants.name],
                                    style: TextStyle(
                                      fontSize: Dimensions.font17,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.sizedBoxHeight10,
                                  ),
                                  Text(
                                    '$currency ${data[Constants.prodNewPrice]}',
                                    style: TextStyle(
                                        fontSize: Dimensions.font24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: Dimensions.sizedBoxHeight10 / 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          StarRating(
                                            rating: data[Constants.prodRating],
                                          ),
                                          SizedBox(
                                            width:
                                                Dimensions.sizedBoxWidth10 / 2,
                                          ),
                                          Text(
                                            '(${snapshot1.data.length} ratings)',
                                            style: const TextStyle(
                                                color: Color(0xFF4CAF50)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {},
                                            child: const Icon(
                                              Icons.share,
                                              color: Constants.tetiary,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimensions.sizedBoxWidth25,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              String uid = FirebaseAuth
                                                  .instance.currentUser!.uid;

                                              if (!favs.contains(
                                                  data[Constants.uid])) {
                                                await Provider.of<UserProvider>(
                                                        context,
                                                        listen: false)
                                                    .updateUserData({
                                                  Constants.userFavourites: [
                                                    ...favs,
                                                    data[Constants.uid]
                                                  ]
                                                }, uid).then((value) async {
                                                  if (value) {
                                                    String cartId = ((Provider
                                                            .of<CartProvider>(
                                                                context,
                                                                listen: false)
                                                        .carts
                                                        .where((element) =>
                                                            element[Constants
                                                                .productId] ==
                                                            data[Constants.uid])
                                                        .elementAt(
                                                            0)) as Map<String,
                                                        dynamic>)[Constants.uid];

                                                    Constants(context).snackBar(
                                                        'Product added to Saved Items',
                                                        Constants.tetiary);

                                                    await Provider.of<
                                                                CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .removeFromCart(
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid,
                                                            data[Constants.uid],
                                                            cartId,
                                                            data[Constants
                                                                .prodNewPrice]);
                                                  }
                                                });
                                              } else {
                                                favs.remove(
                                                    data[Constants.uid]);

                                                await Provider.of<UserProvider>(
                                                        context,
                                                        listen: false)
                                                    .updateUserData({
                                                  Constants.userFavourites: favs
                                                }, uid).then((value) async {
                                                  if (value) {
                                                    Constants(context).snackBar(
                                                        'Product removed from Saved Items',
                                                        Constants.tetiary);
                                                  }
                                                });
                                              }
                                            },
                                            child: Icon(
                                              favs.contains(data[Constants.uid])
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_border_outlined,
                                              color: Constants.tetiary,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const HeadSedction(
                                text: 'DELIVERY AND RETURNS INFO'),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.sizedBoxWidth10 * 2,
                                  vertical: Dimensions.sizedBoxHeight10),
                              width: double.maxFinite,
                              color: Constants.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IconBox(
                                        icon: Icons.delivery_dining_outlined,
                                        right: Dimensions.sizedBoxWidth10,
                                        iconSize: Dimensions.font23,
                                        isClickable: false,
                                        iconColor: Constants.grey,
                                        borderColor: const Color.fromARGB(
                                            156, 158, 158, 158),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'In-Campus Delivery',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                GestureDetector(
                                                  child: Text(
                                                    'Details',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                        fontSize:
                                                            Dimensions.font12),
                                                  ),
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            _showDialog(
                                                                context,
                                                                data[Constants
                                                                    .deliveryPrice],
                                                                currency));
                                                  },
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  Dimensions.sizedBoxHeight3,
                                            ),
                                            Text(
                                              'Delivery $currency ${data[Constants.deliveryPrice]}',
                                              style: TextStyle(
                                                  fontSize: Dimensions.font12),
                                            ),
                                            Text(
                                              'Delivery within 30mins - 1hr',
                                              style: TextStyle(
                                                  fontSize: Dimensions.font12),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.sizedBoxHeight15,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IconBox(
                                        icon: Icons.history,
                                        right: Dimensions.sizedBoxWidth10,
                                        iconColor: Constants.grey,
                                        iconSize: Dimensions.font23,
                                        isClickable: false,
                                        borderColor: const Color.fromARGB(
                                            156, 158, 158, 158),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: const [
                                                Text(
                                                  'Return Policy',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  Dimensions.sizedBoxHeight3,
                                            ),
                                            Text(
                                              'Free return within 1hour after puchase and delivery, product would not be accepted after 1hour of successful delivery.',
                                              style: TextStyle(
                                                  fontSize: Dimensions.font12),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const HeadSedction(text: 'PRODUCT DETAILS'),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.sizedBoxWidth10),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Constants.white,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.sizedBoxWidth10 / 2)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Material(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxWidth10 / 2),
                                    color: Constants.white,
                                    child: ListTileBtn(
                                      title: 'Description',
                                      textSize: Dimensions.font16,
                                      visualD: -3,
                                      weight: FontWeight.w500,
                                      page: RouteHelper.getDetailsPage(),
                                      args: [
                                        data[Constants.prodDescription],
                                        data[Constants.prodKeyFeatures],
                                        data[Constants.prodSpecifications]
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Container(
                                      height: 1,
                                      color: Constants.lightGrey,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(
                                        Dimensions.sizedBoxWidth10),
                                    child:
                                        Text(data[Constants.prodDescription]),
                                  )
                                ],
                              ),
                            ),
                            const HeadSedction(
                                text: 'VERIFIED CUSTOMER FEEDBACK'),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.sizedBoxWidth10),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Constants.white,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.font25 / 5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Material(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.sizedBoxWidth10 / 2),
                                    color: Constants.white,
                                    child: ListTileBtn(
                                      page: RouteHelper.getRatingsViewPage(),
                                      args: snapshot1.data,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Product Rating & Reviews',
                                            style: TextStyle(
                                                fontSize: Dimensions.font16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: Dimensions.sizedBoxHeight10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1.5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions.font12 /
                                                                6),
                                                    border: Border.all(
                                                        color: const Color
                                                                .fromARGB(
                                                            108, 248, 194, 0))),
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        data[Constants
                                                                .prodRating]
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Constants
                                                                .tetiary,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: Dimensions
                                                                .font12),
                                                      ),
                                                      Text(
                                                        '/5',
                                                        style: TextStyle(
                                                            color: Constants
                                                                .tetiary,
                                                            fontSize: Dimensions
                                                                .font12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '(${snapshot1.data.length} ratings)',
                                                style: TextStyle(
                                                    fontSize:
                                                        Dimensions.font12),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Container(
                                      height: 1,
                                      color: Constants.lightGrey,
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.sizedBoxWidth10),
                                      child: Column(
                                        children: List.generate(
                                            snapshot1.data.length, (index) {
                                          return Column(
                                            children: [
                                              ReviewBoxCon(
                                                  date: snapshot1.data[index]
                                                      [Constants.updatedAt],
                                                  topic: snapshot1.data[index]
                                                      [Constants.reviewTitle],
                                                  review: snapshot1.data[index]
                                                      [Constants.reviewBody],
                                                  name: snapshot1.data[index]
                                                      [Constants.name]),
                                              index < snapshot1.data.length - 2
                                                  ? const Divider(
                                                      color:
                                                          Constants.lightGrey,
                                                    )
                                                  : Container()
                                            ],
                                          );
                                        }),
                                        // snapshot1.data.map((e) {
                                        //   return Column(
                                        //     children: [
                                        //       ReviewBoxCon(
                                        //           date: snapshot1.data[
                                        //               snapshot1.data
                                        //                   .indexOf(e)],
                                        //           topic: e[
                                        //               Constants.reviewTitle],
                                        //           review:
                                        //               e[Constants.reviewBody],
                                        //           name: e[Constants.name]),
                                        //       snapshot1.data[snapshot1.data
                                        //                   .indexOf(e)] <
                                        //               snapshot1.data.length -
                                        //                   2
                                        //           ? const Divider(
                                        //               color:
                                        //                   Constants.lightGrey,
                                        //             )
                                        //           : Container()
                                        //     ],
                                        //   );
                                        // }).toList(),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.sizedBoxHeight10,
                            )
                          ],
                        )
                      : const Center(
                          child: Text('Product Not Found'),
                        )),
                );
        },
      ),
      bottomNavigationBar: DetailsBottomNav(
        isAdded: true,
        prodId: data[Constants.uid],
        amount: data[Constants.prodNewPrice],
        shopName: data[Constants.shopName],
        category: data[Constants.prodCategory],
        leading: Row(
          children: const [
            IconBox(
              icon: Icons.home_outlined,
            ),
            IconBox(
              icon: Icons.list_alt_outlined,
            ),
            IconBox(
              icon: Icons.phone,
            )
          ],
        ),
        text: 'ADD TO CART',
        icon: const Icon(Icons.add_shopping_cart_rounded),
      ),
    );
  }
}
