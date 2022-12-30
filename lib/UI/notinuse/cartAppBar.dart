import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/components/search.dart';
import 'package:GOCart/UI/routes/route_helper.dart';

import '../constants/constants.dart';

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
      title: const Text(
        'Details',
        style: TextStyle(fontSize: 25),
      ),
      actions: [
        const Search(),
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                padding: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.only(left: 15),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 225, 225, 225))),
                  ),
                  child: const ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      minVerticalPadding: 0.0,
                      visualDensity: VisualDensity(vertical: -2),
                      horizontalTitleGap: 3.0,
                      leading: Icon(Icons.home_outlined),
                      title: Text('Home')),
                ),
                // onTap: (() => Get.toNamed(RouteHelper.getRoutePage(0))),
              ),
              PopupMenuItem(
                padding: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.only(left: 15),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 225, 225, 225))),
                  ),
                  child: const ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      minVerticalPadding: 0.0,
                      visualDensity: VisualDensity(vertical: -2),
                      horizontalTitleGap: 3.0,
                      leading: Icon(Icons.category_outlined),
                      title: Text('Category')),
                ),
                // onTap: (() => Get.toNamed(RouteHelper.getRoutePage(1)))
              ),
              PopupMenuItem(
                padding: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.only(left: 15),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 225, 225, 225))),
                  ),
                  child: const ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      minVerticalPadding: 0.0,
                      visualDensity: VisualDensity(vertical: -2),
                      horizontalTitleGap: 3.0,
                      leading: Icon(Icons.shop_2_outlined),
                      title: Text('Shop')),
                ),
                // onTap: (() => Get.toNamed(RouteHelper.getRoutePage(2)))
              ),
              PopupMenuItem(
                padding: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: const ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      minVerticalPadding: 0.0,
                      visualDensity: VisualDensity(vertical: -2),
                      horizontalTitleGap: 3.0,
                      leading: Icon(Icons.person_outline),
                      title: Text('Account')),
                ),
                // onTap: (() => Get.toNamed(RouteHelper.getRoutePage(3)))
              ),
            ];
          },
        ),
      ],
      backgroundColor: Constants.secondary,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Constants.secondary),
    );
  }
}
