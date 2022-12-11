import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/pages/login_page.dart';
import 'package:GOCart/pages/register_page.dart';
import 'package:GOCart/pages/route_page.dart';
import 'package:GOCart/pages/splash_page.dart';
import 'package:GOCart/routes/route_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color.fromARGB(255, 243, 243, 243),
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
