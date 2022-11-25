import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:schoolproj/components/accountAppBar.dart';
import 'package:schoolproj/routes/route_helper.dart';
import 'package:schoolproj/utils/dimensions.dart';
import 'package:schoolproj/widgets/navigationIconWidget.dart';

import '../components/homeAppBar.dart';

class RoutePage extends StatefulWidget {
  final int pageId;

  const RoutePage({super.key, this.pageId = 0});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  int _activePage = 0;
  bool _allowPageId = true;
  PreferredSizeWidget page = HomeAppBar(title: 'GO-CART');
  final GlobalKey<CurvedNavigationBarState> _globalKey = GlobalKey();

  final List<dynamic> _pages = [
    RouteHelper.getHomePage(),
    RouteHelper.getCategoriesPage(),
    RouteHelper.getCartPage(),
    RouteHelper.getShopPage(),
    RouteHelper.getAccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _allowPageId ? (widget.pageId == 4 ? AccountAppBar() : page) : page,
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: _pages[_allowPageId ? widget.pageId : _activePage],
      bottomNavigationBar: CurvedNavigationBar(
        key: _globalKey,
        index: _allowPageId ? widget.pageId : _activePage,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.green,
        height: Dimensions.sizedBoxHeight65,
        items: const [
          NavigationIcon(icon: Icon(Icons.home_outlined), text: 'Home'),
          NavigationIcon(icon: Icon(Icons.list_alt_outlined), text: 'Category'),
          NavigationIcon(
              icon: Icon(Icons.shopping_cart_outlined), text: 'Cart'),
          NavigationIcon(icon: Icon(Icons.shop_2_outlined), text: 'Shops'),
          NavigationIcon(icon: Icon(Icons.person_outline), text: 'Account'),
        ],
        items2: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.list_alt,
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
          setState(() {
            _activePage = index;
            _allowPageId = false;
            if (index == 4) {
              page = AccountAppBar();
            } else {
              page = HomeAppBar(title: 'GO-CART');
            }
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
