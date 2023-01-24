import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../CONSTANTS/constants.dart';
import '../utils/dimensions.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  final double _height = Dimensions.pageViewContainer;
  var _currentPageValue = 0.0;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Dimensions.pageViewContainer,
          child: CarouselSlider.builder(
            options: CarouselOptions(
              height: _height,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 7),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.9,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              enableInfiniteScroll: true,
              scrollDirection: Axis.horizontal,
              initialPage: 0,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPageValue = double.parse(index.toString());
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
            activeSize: Size(Dimensions.font18, Dimensions.font18 / 2),
            activeShape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(Dimensions.sizedBoxWidth10 / 2)),
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
}