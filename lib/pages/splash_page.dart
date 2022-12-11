import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/routes/route_helper.dart';
import 'package:GOCart/utils/dimensions.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Alignment _alignment = Alignment.topCenter;
  double _w = Dimensions.sizedBoxWidth10 * 2;
  double _h = Dimensions.sizedBoxWidth10 * 2;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 500), ((() {
      setState(() {
        _alignment = Alignment.center;
      });
    })));
    Timer(const Duration(milliseconds: 1500), ((() {
      setState(() {
        _h = Dimensions.sizedBoxWidth10 * 7;
        _w = Dimensions.sizedBoxWidth100 * 2;
      });
    })));
    // Timer(const Duration(milliseconds: 2500), ((() {
    //   setState(() {
    //     _w = 130;
    //     _h = 130;
    //   });
    // })));
    Timer(const Duration(milliseconds: 2200), ((() {
      setState(() {
        _opacity = 1.0;
      });
    })));
    Timer(const Duration(milliseconds: 4300), ((() {
      // Get.offNamed(RouteHelper.getRegisterPage());
      Get.offNamedUntil(RouteHelper.getRegisterPage(), (route) => false);
    })));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF00923F),
      body: AnimatedAlign(
        alignment: _alignment,
        curve: Curves.elasticOut,
        duration: const Duration(milliseconds: 2500),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _w,
          height: _h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(Dimensions.sizedBoxWidth10 * 3.5)),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 2000),
            opacity: _opacity,
            child: Center(
              child: Container(
                width: Dimensions.sizedBoxWidth10 * 16,
                height: Dimensions.sizedBoxWidth10 * 3.5,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/GoCart  sample.png'),
                        fit: BoxFit.contain)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
