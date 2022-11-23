import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:schoolproj/components/search.dart';
import 'package:schoolproj/pages/routePage.dart';
import 'package:schoolproj/utils/dimensions.dart';

import '../routes/route_helper.dart';

class HomeAppBar extends StatefulWidget with PreferredSizeWidget {
  final bool implyLeading;
  final bool showPopUp;
  final bool showCart;
  final bool showBottom;
  final String title;
  final double? textSize;

  HomeAppBar(
      {super.key,
      this.implyLeading = false,
      this.showPopUp = false,
      this.showCart = false,
      this.showBottom = false,
      required this.title,
      this.textSize});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.implyLeading,
      titleSpacing: widget.implyLeading ? 0 : Dimensions.sizedBoxWidth10 * 2,
      title: Text(
        widget.title,
        style: TextStyle(fontSize: widget.textSize ?? Dimensions.font20),
      ),
      actions: [
        const Search(),
        widget.showCart
            ? (Row(
                children: [
                  SizedBox(
                    width: Dimensions.sizedBoxWidth4 * 2,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.shopping_cart_outlined),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: Dimensions.font16,
                          height: Dimensions.font16,
                          margin: EdgeInsets.only(
                              top: Dimensions.sizedBoxHeight10,
                              left: Dimensions.sizedBoxWidth15),
                          decoration: BoxDecoration(
                              color: const Color(0XFFF8C300),
                              border:
                                  Border.all(color: const Color(0XFF00923F)),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.sizedBoxWidth4 * 2)),
                          child: Center(
                            child: Text(
                              '3',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.font11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ))
            : const Text(''),
        widget.showPopUp
            ? (PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      padding: const EdgeInsets.all(0),
                      onTap: (() {
                      }),
                      child: Container(
                        padding:
                            EdgeInsets.only(left: Dimensions.sizedBoxWidth15),
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 225, 225, 225))),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 0),
                          minVerticalPadding: 0.0,
                          visualDensity: const VisualDensity(vertical: -2),
                          horizontalTitleGap: Dimensions.sizedBoxWidth3,
                          leading: const Icon(Icons.home_outlined),
                          title: const Text('Home'),
                          onTap: (() =>
                              Get.toNamed(RouteHelper.getRoutePage(0))),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                        padding: const EdgeInsets.all(0),
                        onTap: (() {
                          
                        }),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: Dimensions.sizedBoxWidth15),
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(255, 225, 225, 225))),
                          ),
                          child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              minVerticalPadding: 0.0,
                              visualDensity: const VisualDensity(vertical: -2),
                              horizontalTitleGap: Dimensions.sizedBoxWidth3,
                              leading: const Icon(Icons.category_outlined),
                              title: const Text('Category'),
                          onTap: (() =>
                              Get.toNamed(RouteHelper.getRoutePage(1))),),
                        )),
                    PopupMenuItem(
                        padding: const EdgeInsets.all(0),
                        onTap: (() {
                          
                        }),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: Dimensions.sizedBoxWidth15),
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(255, 225, 225, 225))),
                          ),
                          child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              minVerticalPadding: 0.0,
                              visualDensity: const VisualDensity(vertical: -2),
                              horizontalTitleGap: Dimensions.sizedBoxWidth3,
                              leading: const Icon(Icons.shop_2_outlined),
                              title: const Text('Shops'),
                            onTap: (() =>
                                Get.toNamed(RouteHelper.getRoutePage(3))),
                          ),
                        )),
                    PopupMenuItem(
                        padding: const EdgeInsets.all(0),
                        onTap: (() {
                          
                        }),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: Dimensions.sizedBoxWidth15),
                          child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              minVerticalPadding: 0.0,
                              visualDensity: const VisualDensity(vertical: -2),
                              horizontalTitleGap: Dimensions.sizedBoxWidth3,
                              leading: const Icon(Icons.person_outline),
                              title: const Text('Account'),
                            onTap: (() =>
                                Get.toNamed(RouteHelper.getRoutePage(4))),
                          ),
                        )),
                  ];
                },
              ))
            : const Text('')
      ],
      backgroundColor: const Color(0XFF00923F),
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0XFF00923F),
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
    );
  }
}
