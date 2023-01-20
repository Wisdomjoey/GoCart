import 'package:async/async.dart';
import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
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
  final double _height = Dimensions.pageViewContainer;
  var _currentPageValue = 0.0;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

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
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.pageViewContainer,
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            height: _height,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 7),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            viewportFraction: 0.9,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            enableInfiniteScroll: true,
                            scrollDirection: Axis.horizontal,
                            initialPage: 0,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentPageValue =
                                    double.parse(index.toString());
                              });
                            },
                          ),
                          itemCount: 5,
                          itemBuilder: (context, index, realIndex) {
                            return _buildPageItem(index);
                          },
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.sizedBoxHeight10,
                      ),
                      DotsIndicator(
                        dotsCount: 5,
                        position: _currentPageValue,
                        decorator: DotsDecorator(
                          activeColor: Constants.primary,
                          size: Size.square(Dimensions.font18 / 2),
                          activeSize:
                              Size(Dimensions.font18, Dimensions.font18 / 2),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.sizedBoxWidth10 / 2)),
                        ),
                      )
                    ],
                  ),
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
                                    arguments: Constants.categories[e]),
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
                    FutureBuilder(
                      initialData: const [],
                      future: _memoizer.runOnce(() {
                        return Provider.of<ProductProvider>(context, listen: false)
                            .getAllProducts();
                      }),
                      builder: (context, AsyncSnapshot snapshot) {
                        return snapshot.data!.isEmpty &&
                                Provider.of<ProductProvider>(context).process !=
                                    Process.processComplete
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Constants.tetiary,
                                ),
                              )
                            : (snapshot.data!.isNotEmpty
                                ? ProductBox(
                                    snapshotDocs: snapshot.data!,
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

  Widget _buildPageItem(int position) {
    return Container(
      height: Dimensions.pageViewContainer,
      margin: EdgeInsets.only(
          left: Dimensions.sizedBoxWidth10, right: Dimensions.sizedBoxWidth10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.font25 / 5),
        color:
            position.isEven ? const Color(0xFF69c5df) : const Color(0xFF9294cc),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.font25 / 5),
        child: Material(
          child: InkWell(
            splashColor: const Color.fromARGB(35, 55, 55, 55),
            child: Ink.image(
                fit: BoxFit.cover,
                image: const AssetImage('assets/images/med.gif')),
            onTap: () {},
          ),
        ),
      ),
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
