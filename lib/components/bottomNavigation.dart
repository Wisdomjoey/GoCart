import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.green,
      height: 60,
      items: const [
        Icon(Icons.home_outlined),
        Icon(Icons.category_outlined),
        Icon(Icons.shopping_cart_outlined),
        Icon(Icons.shop_2_outlined),
        Icon(Icons.person_outline),
      ],
      items2: const [
        Icon(Icons.home),
        Icon(Icons.category),
        Icon(Icons.shopping_cart),
        Icon(Icons.shop_2),
        Icon(Icons.person),
      ],
    );
  }
}
