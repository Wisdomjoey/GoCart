import 'package:flutter/material.dart';
import 'package:schoolproj/utils/dimensions.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/images/emptyCart.png',
            width: Dimensions.sizedBoxWidth100 * 3,
          ),
        ),
        SizedBox(
          height: Dimensions.sizedBoxHeight15 * 2,
        ),
        Center(
          child: Text(
            'Cart is Empty',
            style: TextStyle(fontSize: Dimensions.font20),
          ),
        ),
        SizedBox(
          height: Dimensions.sizedBoxHeight10,
        ),
        const Center(
          child: Text(
            'Add products to cart to see them here',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
