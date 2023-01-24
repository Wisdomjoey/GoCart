import 'package:GOCart/PROVIDERS/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/components/search.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';
import '../routes/route_helper.dart';

class HomeAppBar extends StatefulWidget with PreferredSizeWidget {
  final bool implyLeading;
  final bool showPopUp;
  final bool showCart;
  final String? title;
  final Widget? logo;
  final Widget? icon;
  final double? textSize;

  HomeAppBar(
      {super.key,
      this.implyLeading = false,
      this.showPopUp = false,
      this.showCart = false,
      this.title,
      this.textSize,
      this.logo,
      this.icon});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.implyLeading,
      leading: widget.icon ??
          (widget.implyLeading
              ? IconButton(
                  splashRadius: 24,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                )
              : const Text('')),
      titleSpacing: widget.implyLeading
          ? 0
          : (widget.icon != null ? 0 : -(Dimensions.sizedBoxWidth10 * 4)),
      title: widget.logo ??
          Text(
            widget.title!,
            style: TextStyle(fontSize: widget.textSize ?? Dimensions.font20),
          ),
      actions: [
        const Search(),
        widget.showCart
            ? (Row(
                children: [
                  IconButton(
                    splashRadius: 24,
                    tooltip: 'Cart',
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.shopping_cart_outlined),
                        Align(
                          alignment: Alignment.topRight,
                          child:
                              Provider.of<CartProvider>(context).cartListNo < 1
                                  ? Container()
                                  : Container(
                                      width: Dimensions.font16,
                                      height: Dimensions.font16,
                                      margin: EdgeInsets.only(
                                          // top: Dimensions.sizedBoxHeight10,
                                          left: Dimensions.sizedBoxWidth15),
                                      decoration: BoxDecoration(
                                          color: Constants.tetiary,
                                          border: Border.all(
                                              color: Constants.secondary),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.sizedBoxWidth4 * 2)),
                                      child: Center(
                                        child: Text(
                                          Provider.of<CartProvider>(context)
                                              .cartListNo
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.white,
                                              fontSize: Dimensions.font11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                        )
                      ],
                    ),
                    onPressed: () {
                      Get.toNamed(RouteHelper.getRoutePage(), arguments: 2);
                    },
                  ),
                ],
              ))
            : const Text(''),
        widget.showPopUp
            ? (PopupMenuButton(
                splashRadius: 24,
                tooltip: 'Menu',
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      padding: const EdgeInsets.all(0),
                      onTap: (() {}),
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
                          onTap: (() {
                            // Get.toNamed(RouteHelper.getRoutePage(0));
                            Get.offAllNamed(RouteHelper.getRoutePage(),
                                arguments: 0);
                          }),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                        padding: const EdgeInsets.all(0),
                        onTap: (() {}),
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
                            onTap: (() => Get.offAllNamed(
                                RouteHelper.getRoutePage(),
                                arguments: 1)),
                          ),
                        )),
                    PopupMenuItem(
                        padding: const EdgeInsets.all(0),
                        onTap: (() {}),
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
                            onTap: (() => Get.offAllNamed(
                                RouteHelper.getRoutePage(),
                                arguments: 3)),
                          ),
                        )),
                    PopupMenuItem(
                        padding: const EdgeInsets.all(0),
                        onTap: (() {}),
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
                            onTap: (() => Get.offAllNamed(
                                RouteHelper.getRoutePage(),
                                arguments: 4)),
                          ),
                        )),
                  ];
                },
              ))
            : const Text('')
      ],
      backgroundColor: Constants.secondary,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Constants.secondary,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
    );
  }
}
