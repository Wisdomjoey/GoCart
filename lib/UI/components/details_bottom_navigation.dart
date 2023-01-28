import 'package:GOCart/PROVIDERS/cart_provider.dart';
import 'package:GOCart/PROVIDERS/global_provider.dart';
import 'package:GOCart/UI/widgets/icon_box_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/elevated_button_widget.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';
import '../../PROVIDERS/user_provider.dart';

class DetailsBottomNav extends StatefulWidget {
  final Widget? leading;
  final Widget? child;
  final String text;
  final Icon? icon;
  final VoidCallback? pressed;
  final String? prodId;
  final String? shopName;
  final String? category;
  final double? amount;

  const DetailsBottomNav(
      {super.key,
      this.leading,
      required this.text,
      this.icon,
      this.pressed,
      this.prodId,
      this.shopName,
      this.amount,
      this.category,
      this.child});

  @override
  State<DetailsBottomNav> createState() => _DetailsBottomNavState();
}

class _DetailsBottomNavState extends State<DetailsBottomNav> {
  @override
  Widget build(BuildContext context) {
    bool added = Provider.of<CartProvider>(context).cart[widget.prodId] != null
        ? (Provider.of<CartProvider>(context).cart[widget.prodId] > 0
            ? true
            : false)
        : false;

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.sizedBoxHeight4 * 2,
          horizontal: Dimensions.sizedBoxWidth10 * 2),
      height: Dimensions.sizedBoxHeight65,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: Constants.lightGrey, style: BorderStyle.solid)),
          color: Constants.white),
      child: Row(
        children: [
          widget.leading!,
          Expanded(
            child: !added
                ? ElevatedBtn(
                    pressed: widget.pressed ??
                        (Provider.of<GlobalProvider>(context).process ==
                                Processes.waiting
                            ? null
                            : () async {
                                List favs = Provider.of<UserProvider>(context,
                                        listen: false)
                                    .userData[Constants.userFavourites];
                                Provider.of<GlobalProvider>(context,
                                        listen: false)
                                    .setProcess(Processes.waiting);

                                setState(() {
                                  added = !added;
                                });

                                await Provider.of<CartProvider>(context,
                                        listen: false)
                                    .addToCart(
                                        FirebaseAuth.instance.currentUser!.uid,
                                        widget.prodId!,
                                        widget.amount!,
                                        widget.shopName!)
                                    .then((value) async {
                                  favs.remove(widget.prodId!);

                                  await Provider.of<UserProvider>(context,
                                          listen: false)
                                      .updateUserData(
                                          {Constants.userFavourites: favs},
                                          FirebaseAuth.instance.currentUser!
                                              .uid).then((value) {
                                    Provider.of<GlobalProvider>(context,
                                            listen: false)
                                        .setProcess(Processes.done);
                                  });
                                });
                              }),
                    text: widget.text,
                    icon: widget.icon,
                    child: Provider.of<GlobalProvider>(context).process ==
                            Processes.waiting
                        ? SizedBox(
                            width: Dimensions.sizedBoxWidth10 * 2,
                            height: Dimensions.sizedBoxWidth10 * 2,
                            child: const CircularProgressIndicator(
                              color: Constants.white,
                              strokeWidth: 3,
                            ))
                        : Text(
                            widget.text,
                            style: TextStyle(
                                color: Constants.white,
                                fontSize: Dimensions.font14),
                          ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconBox(
                        pressed: (() async {
                          Provider.of<GlobalProvider>(context, listen: false)
                              .setProcess(Processes.waiting);

                          await Provider.of<CartProvider>(context,
                                  listen: false)
                              .decreaseCartProduct(
                                  widget.prodId!,
                                  FirebaseAuth.instance.currentUser!.uid,
                                  widget.category!,
                                  widget.amount!,
                                  widget.shopName!)
                              .then((value) {
                            Provider.of<GlobalProvider>(context, listen: false)
                                .setProcess(Processes.done);
                          });
                        }),
                        isDisabled:
                            Provider.of<GlobalProvider>(context).process ==
                                    Processes.waiting
                                ? true
                                : false,
                        width: Dimensions.sizedBoxHeight65 -
                            (Dimensions.sizedBoxHeight4 * 4),
                        height: Dimensions.sizedBoxHeight65 -
                            (Dimensions.sizedBoxHeight4 * 4),
                        iconSize: Dimensions.font24,
                        color: Constants.tetiary,
                        iconColor: Colors.white,
                        icon: Icons.remove,
                      ),
                      Provider.of<GlobalProvider>(context).process ==
                              Processes.waiting
                          ? SizedBox(
                              width: Dimensions.sizedBoxWidth10,
                              height: Dimensions.sizedBoxWidth10,
                              child: const CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 1,
                              ),
                            )
                          : Text(
                              Provider.of<CartProvider>(context)
                                  .cart[widget.prodId]
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Dimensions.font16),
                            ),
                      IconBox(
                        pressed: (() async {
                          Provider.of<GlobalProvider>(context, listen: false)
                              .setProcess(Processes.waiting);

                          await Provider.of<CartProvider>(context,
                                  listen: false)
                              .increaseCartProduct(
                                  widget.prodId!,
                                  FirebaseAuth.instance.currentUser!.uid,
                                  widget.category!,
                                  widget.shopName!,
                                  widget.amount!)
                              .then((value) {
                            Provider.of<GlobalProvider>(context, listen: false)
                                .setProcess(Processes.done);
                          });
                        }),
                        isDisabled:
                            Provider.of<GlobalProvider>(context).process ==
                                    Processes.waiting
                                ? true
                                : false,
                        width: Dimensions.sizedBoxHeight65 -
                            (Dimensions.sizedBoxHeight4 * 4),
                        height: Dimensions.sizedBoxHeight65 -
                            (Dimensions.sizedBoxHeight4 * 4),
                        iconSize: Dimensions.font24,
                        color: Constants.tetiary,
                        iconColor: Colors.white,
                        icon: Icons.add,
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
