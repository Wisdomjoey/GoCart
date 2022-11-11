import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartAppBar extends StatefulWidget with PreferredSizeWidget {
  CartAppBar({super.key});

  @override
  State<CartAppBar> createState() => _CartAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CartAppBarState extends State<CartAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: const Text('CART'),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return const [
                PopupMenuItem(
                    child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    leading: Icon(Icons.home_outlined),
                    title: Text('Home')
                )),
                PopupMenuItem(
                    child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    leading: Icon(Icons.category_outlined),
                    title: Text('Category')
                )),
                PopupMenuItem(
                    child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    leading: Icon(Icons.shop_2_outlined),
                    title: Text('Shop')
                )),
                PopupMenuItem(
                    child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    leading: Icon(Icons.person_outline),
                    title: Text('Account')
                )),
            ];
          },
        )
      ],
      backgroundColor: Colors.green,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.green),
    );
  }
}
