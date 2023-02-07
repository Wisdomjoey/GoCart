import 'package:GOCart/UI/components/home_slider.dart';
import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/components/product_box.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';
import '../utils/dimensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    // print('height ${Get.context!.height}');
    // print('height ${Get.context!.width}');
    // Future.delayed(Duration.zero, (() {
    //   List products = getProducts();
    // }));
    // getProducts();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 * 2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.sizedBoxHeight15),
                  decoration: const BoxDecoration(color: Constants.white),
                  child: const HomeSlider(),
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight15 * 2,
                ),
                // Container(
                //   height: Dimensions.sizedBoxHeight10 * 6,
                //   alignment: Alignment.center,
                //   decoration: const BoxDecoration(color: Constants.white),
                //   child: Container(
                //       height: Dimensions.sizedBoxHeight10 * 4,
                //       padding: EdgeInsets.symmetric(
                //           horizontal: Dimensions.sizedBoxWidth10 / 2),
                //       child: ListView.builder(
                //           itemCount: 5,
                //           scrollDirection: Axis.horizontal,
                //           itemBuilder: ((context, index) {
                //             return GestureDetector(
                //               child: _categoryList(Constants.categories[index]),
                //               onTap: () => Get.toNamed(
                //                   RouteHelper.getProductListPage(),
                //                   arguments: Constants.categories[index]),
                //             );
                //           }))),
                // ),
                Container(
                  height: Dimensions.sizedBoxHeight10 * 6,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Constants.white),
                  child: Container(
                    height: Dimensions.sizedBoxHeight10 * 4,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.sizedBoxWidth10 / 2),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [0, 1, 2, 3, 4]
                          .map((e) => GestureDetector(
                                child: _categoryList(Constants.categories[e]),
                                onTap: () => Get.toNamed(
                                    RouteHelper.getProductListPage(),
                                    arguments: [
                                      Constants.categories[e],
                                      false
                                    ]),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10 * 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Constants.white,
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.sizedBoxWidth10 / 2,
                          vertical: Dimensions.sizedBoxWidth15),
                      child: Text(
                        'Products',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: Dimensions.font25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxHeight10 * 2,
                    ),
                    // products.isNotEmpty ? ProductBox(
                    //   snapshotDocs: products,
                    // ) : const CircularProgressIndicator(color: Constants.tetiary,)
                    StreamBuilder(
                      // initialData: QuerySnapshot<Object>,
                      stream:
                          Provider.of<ProductProvider>(context, listen: false)
                              .getAllProducts(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        List data = [];

                        if (snapshot.hasData) {
                          for (var element in snapshot.data!.docs) {
                            var data1 = element.data() as Map;

                            // setState(() {
                            if (data1[Constants.prodCategory] !=
                                'Cooked Foods') {
                              data.add(data1);
                            }
                          }
                        }

                        if (snapshot.hasError) {
                          Constants(context)
                              .snackBar('An error occured', Colors.red);
                        }

                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Constants.tetiary,
                                ),
                              )
                            : (data.isNotEmpty && !snapshot.hasError
                                ? ProductBox(
                                    snapshotDocs: data,
                                  )
                                : const Center(
                                    child: Text('No Product'),
                                  ));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _categoryList(String text) {
    return Container(
      height: Dimensions.sizedBoxHeight10 * 4,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
      margin: EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10 / 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
          color: const Color.fromARGB(255, 248, 248, 248),
          border:
              Border.all(color: Constants.lightGrey, style: BorderStyle.solid)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: Dimensions.font15),
        ),
      ),
    );
  }
}
