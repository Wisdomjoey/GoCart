import 'dart:async';

import 'package:GOCart/PREFS/preferences.dart';
import 'package:GOCart/PROVIDERS/auth_provider.dart';
import 'package:GOCart/PROVIDERS/cart_provider.dart';
import 'package:GOCart/PROVIDERS/shop_provider.dart';
import 'package:GOCart/UI/pages/local_authPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';

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

  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, (() {
      Provider.of<AuthProvider>(context, listen: false).setLoginStatus();

      _isLoggedIn =
          Provider.of<AuthProvider>(context, listen: false).loginStatus;
    }));

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
    Timer(const Duration(milliseconds: 4300), ((() async {
      // Get.offNamed(RouteHelper.getRegisterPage());
      if (_isLoggedIn) {
        await Provider.of<CartProvider>(context, listen: false)
            .getCart(FirebaseAuth.instance.currentUser!.uid)
            .then((value) async {
          await Provider.of<CartProvider>(context, listen: false)
              .getFoodCart(FirebaseAuth.instance.currentUser!.uid)
              .then((value) async {
            await Provider.of<ShopProvider>(context, listen: false)
                .fetchAllShops()
                .then((value) {
              Get.offNamed(RouteHelper.getRoutePage(), arguments: 0);
            });
          });
        });
        // Get.offNamedUntil(RouteHelper.getPhoneRegisterPage(), (route) => false);
      } else {
        await Provider.of<AuthProvider>(context, listen: false)
            .initialize(Status.uninitialized);
        Get.offNamed(RouteHelper.getIntroPage());
      }
      // Get.offUntil(MaterialPageRoute(builder: ((context) => const LocalAuthPage())), (route) => false);
    })));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.secondary,
      body: AnimatedAlign(
        alignment: _alignment,
        curve: Curves.elasticOut,
        duration: const Duration(milliseconds: 2500),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _w,
          height: _h,
          decoration: BoxDecoration(
              color: Constants.white,
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
