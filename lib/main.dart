import 'package:GOCart/UI/pages/intro_page.dart';
import 'package:GOCart/UI/pages/shop_register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/pages/login_page.dart';
import 'package:GOCart/UI/pages/register_page.dart';
import 'package:GOCart/UI/pages/route_page.dart';
import 'package:GOCart/UI/pages/splash_page.dart';
import 'package:GOCart/UI/routes/route_helper.dart';

import 'UI/constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GO Cart',
      theme: ThemeData(
        primarySwatch: Constants.primary,
        scaffoldBackgroundColor: Constants.backgroundColor,
        // brightness: Brightness.light
      ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark
      // ),
      // themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
      home: const SplashPage(),
      // home: const RoutePage(
      //   pageId: 0,
      // ),
    );
  }
}
