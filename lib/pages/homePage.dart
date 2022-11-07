import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:schoolproj/components/bottomNavigation.dart';
import 'package:schoolproj/components/homeAppBar.dart';
import 'package:get/get.dart';

import '../utils/dimensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController =
      PageController(viewportFraction: 0.9, initialPage: 0);
  var _currentPageValue = 0.0;
  late Timer _timer;
  int _currentPage = 0;
  double _scaleFactor = 0.9;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 5) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      pageController.animateToPage(_currentPage,
          duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
    });

    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // print(Get.context!.height.toString());
    // print(Get.context!.width.toString());

    return Scaffold(
      appBar: HomeAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.sizedBoxHeight20,
                  ),
                  Container(
                    height: Dimensions.pageViewContainer,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: 5,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position);
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
                  ),
                  SizedBox(
                    height: Dimensions.sizedBoxHeight20,
                  ),
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    // decoration: const BoxDecoration(
                    //   color: Colors.red
                    // ),
                    child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 238, 238, 238),
                            blurRadius: 7.0,
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
                  SizedBox(height: Dimensions.sizedBoxHeight30,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.sizedBoxHeight10,),
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            'Products',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: Dimensions.sizedBoxHeight30,),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                color: Colors.blue,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }

  Widget _buildPageItem(int position) {
    Matrix4 matrix = Matrix4.identity();

    if (position == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - position) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currentPageValue.floor() + 1) {
      var currScale = _scaleFactor +
          (_currentPageValue - position + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - position) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Container(
        height: Dimensions.pageViewContainer,
        margin: EdgeInsets.only(
            left: Dimensions.sizedBoxWidth10,
            right: Dimensions.sizedBoxWidth10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius5),
            color: position.isEven
                ? const Color(0xFF69c5df)
                : const Color(0xFF9294cc),
            image: const DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/images/med.gif'))),
      ),
    );
  }

  Widget _categoryList() {
    return Container(
      height: 40,
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          border: Border.all(
              color: Color.fromARGB(255, 222, 222, 222),
              width: 1,
              style: BorderStyle.solid)),
      child: const Center(
        child: Text('Category'),
      ),
    );
  }
}
