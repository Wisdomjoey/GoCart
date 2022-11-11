import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _activePage = 0;
  final GlobalKey<CurvedNavigationBarState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
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
        setState(() {
          _activePage = index;
        });
      },
      letIndexChange: (index) => true,
    );
  }
}
