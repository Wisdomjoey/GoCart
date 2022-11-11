import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:schoolproj/components/cartAppBar.dart';
import 'package:schoolproj/pages/accountPage.dart';
import 'package:schoolproj/pages/cartPage.dart';
import 'package:schoolproj/pages/categoriesPage.dart';
import 'package:schoolproj/pages/homePage.dart';
import 'package:schoolproj/pages/shopPage.dart';

import '../components/bottomNavigation.dart';
import '../components/homeAppBar.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  int _activePage = 0;
  PreferredSizeWidget page = HomeAppBar();
  final GlobalKey<CurvedNavigationBarState> _globalKey = GlobalKey();

    List<dynamic> _pages = [
        HomePage(),
        CategoriesPage(),
        CartPage(),
        ShopPage(),
        AccountPage()
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: page,
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: _pages[_activePage],
      bottomNavigationBar: CurvedNavigationBar(
        key: _globalKey,
        index: 0,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.green,
        height: 60,
        items: const [
            Icon(Icons.home_outlined),
            Icon(Icons.category_outlined),
            Icon(Icons.shopping_cart_outlined),
            Icon(Icons.shop_2_outlined),
            Icon(Icons.person_outline),
        ],
        items2: const [
            Icon(
            Icons.home,
            color: Colors.white,
            ),
            Icon(
            Icons.category,
            color: Colors.white,
            ),
            Icon(
            Icons.shopping_cart,
            color: Colors.white,
            ),
            Icon(
            Icons.shop_2,
            color: Colors.white,
            ),
            Icon(
            Icons.person,
            color: Colors.white,
            ),
        ],
        onTap: (index) {
            if (index == 2) {
                page = CartAppBar();
            } else {
                page = HomeAppBar();
            }

            setState(() {
            _activePage = index;
            });
        },
        letIndexChange: (index) => true,
        ),
    );
  }
}
