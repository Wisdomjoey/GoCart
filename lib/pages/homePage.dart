import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolproj/pages/productDetailsPage.dart';
import 'package:schoolproj/widgets/starRatingWidget.dart';

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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('height ${Get.context!.height}');
    print('height ${Get.context!.width}');

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
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Container(
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
                          activeColor: Colors.green,
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight15 * 2,
                ),
                Container(
                  height: Dimensions.sizedBoxHeight10 * 6,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Container(
                      height: Dimensions.sizedBoxHeight10 * 4,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.sizedBoxWidth10 / 2),
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 243, 243, 243),
                          blurRadius: 5.0,
                          offset: Offset(0, 0),
                        )
                      ]),
                      child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) {
                            return _categoryList();
                          }))),
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight15 * 2,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dimensions.sizedBoxHeight10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.sizedBoxWidth10 / 2),
                        child: Text(
                          'Products',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: Dimensions.font25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.sizedBoxHeight15 * 2,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: Dimensions.sizedBoxWidth10,
                            right: Dimensions.sizedBoxWidth10,
                            bottom: Dimensions.sizedBoxHeight10),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing:
                                      Dimensions.sizedBoxHeight10 * 2,
                                  crossAxisSpacing: Dimensions.sizedBoxWidth10,
                                  childAspectRatio: 0.7),
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return _productsList(index);
                          },
                        ),
                      )
                    ],
                  ),
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

  Widget _categoryList() {
    return Container(
      height: Dimensions.sizedBoxHeight10 * 4,
      width: Dimensions.sizedBoxWidth100,
      margin: EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10 / 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
          color: Colors.white,
          border: Border.all(
              color: const Color(0XFFEDEDED), style: BorderStyle.solid)),
      child: const Center(
        child: Text('Category'),
      ),
    );
  }

  Widget _productsList(int index) {
    return Material(
      child: InkWell(
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 232, 232, 232),
                  blurRadius: 10.0,
                  offset: Offset(0, 0),
                )
              ]),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                  child: Ink(
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: index.isEven
                                ? const AssetImage('assets/images/1.jpg')
                                : const AssetImage('assets/images/build.jpg'),
                            fit: BoxFit.contain)),
                  ),
                ),
              ),
              Ink(
                padding: EdgeInsets.only(
                    left: Dimensions.sizedBoxWidth10,
                    right: Dimensions.sizedBoxWidth10,
                    bottom: Dimensions.sizedBoxHeight10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Dimensions.sizedBoxWidth4),
                        bottomRight:
                            Radius.circular(Dimensions.sizedBoxWidth4)),
                    color: Colors.white),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tractor with wide rollers and high maintainence',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: Dimensions.font13,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxHeight4,
                    ),
                    Text(
                      '\$ 8000',
                      style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: Dimensions.sizedBoxHeight4,
                    ),
                    const StarRating(),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Get.to(const ProductDetailsPage());
        },
      ),
    );
  }
}
// import 'dart:async';

// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';

// import '../utils/dimensions.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final PageController _pageController = PageController(viewportFraction: 0.9);
//   var _currentPageValue = 0.0;
//   late Timer _timer;
//   int _currentPage = 0;
//   final double _scaleFactor = 0.9;
//   final double _height = Dimensions.pageViewContainer;

//   @override
//   void initState() {
//     super.initState();

//     _pageController.addListener(() {
//       setState(() {
//         _currentPageValue = _pageController.page!;
//         _currentPage = _currentPageValue.floor();
//       });
//     });

//     _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
//       if (_currentPage < 5) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//       _pageController.animateToPage(_currentPage,
//           duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // print(Get.context!.height.toString());
//     // print(Get.context!.width.toString());

//     return Column(
//       children: [
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: Dimensions.sizedBoxHeight20,
//                 ),
//                 Container(
//                   height: Dimensions.pageViewContainer,
//                   child: PageView.builder(
//                     controller: _pageController,
//                     itemCount: 5,
//                     itemBuilder: (context, position) {
//                       return _buildPageItem(position);
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: Dimensions.sizedBoxHeight10,
//                 ),
//                 DotsIndicator(
//                   dotsCount: 5,
//                   position: _currentPageValue,
//                   decorator: DotsDecorator(
//                     activeColor: Colors.green,
//                     size: const Size.square(9.0),
//                     activeSize: const Size(18.0, 9.0),
//                     activeShape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: Dimensions.sizedBoxHeight20,
//                 ),
//                 Container(
//                   height: 60,
//                   alignment: Alignment.center,
//                   // decoration: const BoxDecoration(
//                   //   color: Colors.red
//                   // ),
//                   child: Container(
//                       height: 40,
//                       padding: const EdgeInsets.symmetric(horizontal: 5),
//                       decoration: const BoxDecoration(boxShadow: [
//                         BoxShadow(
//                           color: Color.fromARGB(255, 238, 238, 238),
//                           blurRadius: 7.0,
//                           offset: Offset(0, 0),
//                         )
//                       ]),
//                       child: ListView.builder(
//                           itemCount: 5,
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: ((context, index) {
//                             return _categoryList();
//                           }))),
//                 ),
//                 SizedBox(
//                   height: Dimensions.sizedBoxHeight30,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: Dimensions.sizedBoxHeight10,
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 5),
//                         child: Text(
//                           'Products',
//                           style: TextStyle(
//                               fontFamily: 'Roboto',
//                               fontSize: 25,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       SizedBox(
//                         height: Dimensions.sizedBoxHeight30,
//                       ),
//                       GridView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 mainAxisSpacing: 20,
//                                 childAspectRatio: 0.9),
//                         itemCount: 20,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(5),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(4),
//                                 color: Colors.blue,
//                               ),
//                               child: Column(
//                                 children: [
//                                   Container(),
//                                   Container(),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildPageItem(int position) {
//     Matrix4 matrix = Matrix4.identity();

//     if (position == _currentPageValue.floor()) {
//       var currScale = 1 - (_currentPageValue - position) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (position == _currentPageValue.floor() + 1) {
//       var currScale = _scaleFactor +
//           (_currentPageValue - position + 1) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (position == _currentPageValue.floor() - 1) {
//       var currScale = 1 - (_currentPageValue - position) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else {
//       var currScale = 0.9;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
//     }

//     return Transform(
//       transform: matrix,
//       child: Container(
//         height: Dimensions.pageViewContainer,
//         margin: EdgeInsets.only(
//             left: Dimensions.sizedBoxWidth10,
//             right: Dimensions.sizedBoxWidth10),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(Dimensions.radius5),
//             color: position.isEven
//                 ? const Color(0xFF69c5df)
//                 : const Color(0xFF9294cc),
//             image: const DecorationImage(
//                 fit: BoxFit.cover, image: AssetImage('assets/images/med.gif'))),
//       ),
//     );
//   }

//   Widget _categoryList() {
//     return Container(
//       height: 40,
//       width: 100,
//       margin: const EdgeInsets.symmetric(horizontal: 5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4),
//         color: Colors.white,
//       ),
//       child: const Center(
//         child: Text('Category'),
//       ),
//     );
//   }
// }
