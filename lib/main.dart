import 'package:GOCart/PROVIDERS/auth_provider.dart';
import 'package:GOCart/PROVIDERS/cart_provider.dart';
import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:GOCart/PROVIDERS/shop_provider.dart';
import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:GOCart/UI/pages/intro_page.dart';
import 'package:GOCart/UI/pages/shop_register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/pages/login_page.dart';
import 'package:GOCart/UI/pages/register_page.dart';
import 'package:GOCart/UI/pages/route_page.dart';
import 'package:GOCart/UI/pages/splash_page.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:provider/provider.dart';

import 'CONSTANTS/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ShopProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: GetMaterialApp(
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
      ),
    );
  }
}
