import 'dart:async';

import 'package:GOCart/PROVIDERS/auth_provider.dart';
import 'package:GOCart/PROVIDERS/global_provider.dart';
import 'package:GOCart/UI/pages/local_auth_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';
import '../../PREFS/preferences.dart';
import '../../PROVIDERS/shop_provider.dart';
import '../../PROVIDERS/user_provider.dart';

class SplashPage extends StatefulWidget {
  final String? prodId;

  const SplashPage({super.key, this.prodId});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Alignment _alignment = Alignment.topCenter;
  double _w = Dimensions.sizedBoxWidth10 * 2;
  double _h = Dimensions.sizedBoxWidth10 * 2;
  double _opacity = 0.0;

  late bool _isLoggedIn;
  late Timer timer1;
  late Timer timer2;
  late Timer timer3;
  late Timer timer4;

  @override
  void initState() {
    timer1 = Timer(const Duration(milliseconds: 500), ((() {
      setState(() {
        _alignment = Alignment.center;
      });
    })));
    timer2 = Timer(const Duration(milliseconds: 1500), ((() {
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
    timer3 = Timer(const Duration(milliseconds: 2200), ((() {
      setState(() {
        _opacity = 1.0;
      });
    })));
    timer4 = Timer(const Duration(milliseconds: 4300), ((() async {
      await (Connectivity().checkConnectivity()).then((value) async {
        if (value == ConnectivityResult.wifi ||
            value == ConnectivityResult.mobile) {
          if (widget.prodId != null) {
            Provider.of<GlobalProvider>(context, listen: false)
                .setLink(widget.prodId, context);
          }

          _isLoggedIn =
              FirebaseAuth.instance.currentUser == null ? false : true;

          if (_isLoggedIn) {
            await Provider.of<ShopProvider>(context, listen: false)
                .fetchAllShops()
                .whenComplete(() async {
              if (mounted) {
                await Provider.of<UserProvider>(context, listen: false)
                    .initializeUserData(FirebaseAuth.instance.currentUser!.uid)
                    .whenComplete(() async {
                  if (mounted) {
                    await Preferences()
                        .getListData(Constants.prefsSearchHistory)
                        .then((value2) {
                      if (mounted) {
                        Map userData =
                            Provider.of<UserProvider>(context, listen: false)
                                .userData;

                        if (value2 != null) {
                          Provider.of<GlobalProvider>(context, listen: false)
                              .setHistory(value2);
                        }

                        if (userData[Constants.userIsPhoneVerified]) {
                          if (userData[Constants.userPinIsSet]) {
                            Get.off(() => const LocalAuthPage());
                          } else {
                            Map<String, dynamic>? prodData =
                                Provider.of<GlobalProvider>(context,
                                        listen: false)
                                    .prodData;

                            if (prodData != null) {
                              Get.offNamedUntil(
                                  RouteHelper.getProductDetailsPage(),
                                  arguments: prodData,
                                  (route) => false);
                            } else {
                              Get.offNamedUntil(
                                  RouteHelper.getRoutePage(),
                                  arguments: 0,
                                  (route) => false);
                            }
                          }
                        } else {
                          Get.offNamedUntil(RouteHelper.getPhoneRegisterPage(),
                              (route) => false);
                        }
                      }
                    });
                  }
                });
              }
            });
            // Get.offNamedUntil(RouteHelper.getPhoneRegisterPage(), (route) => false);
          } else {
            await Provider.of<AuthProvider>(context, listen: false)
                .initialize(Status.uninitialized);
            if (await Preferences()
                    .getBoolData(Constants.prefsUserIsRegistered) ==
                true) {
              Get.offNamedUntil(RouteHelper.getLoginPage(), (route) => false);
            } else {
              Get.offNamedUntil(RouteHelper.getIntroPage(), (route) => false);
            }
          }
        } else {
          Constants(context)
              .snackBar('You are not conneted to the internet', Colors.red);

          Timer(
              const Duration(seconds: 2),
              (() =>
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop')));
        }
      });
      // Get.offUntil(MaterialPageRoute(builder: ((context) => const LocalAuthPage())), (route) => false);
    })));

    super.initState();
  }

  @override
  void dispose() {
    timer1.cancel();
    timer2.cancel();
    timer3.cancel();
    timer4.cancel();

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
