import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:schoolproj/utils/dimensions.dart';
import 'package:schoolproj/widgets/iconBoxWidget.dart';

class DetailsBottomNav extends StatefulWidget {
  const DetailsBottomNav({super.key});

  @override
  State<DetailsBottomNav> createState() => _DetailsBottomNavState();
}

class _DetailsBottomNavState extends State<DetailsBottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.sizedBoxHeight4 * 2,
          horizontal: Dimensions.sizedBoxWidth10 * 2),
      height: Dimensions.sizedBoxHeight65,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: Color(0XFFEDEDED), style: BorderStyle.solid)),
          color: Colors.white),
      child: Row(
        children: [
          Container(
            child: Row(
              children: const [
                IconBox(
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                IconBox(
                  icon: Icons.list_alt_outlined,
                  text: 'Category',
                ),
                IconBox(
                  icon: Icons.phone,
                  text: 'Phone',
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFF8C300),
                ),
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.add_shopping_cart_rounded),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'ADD TO CART',
                        style: TextStyle(fontSize: Dimensions.font14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
