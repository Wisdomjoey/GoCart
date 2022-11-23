import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/images/shop.png',
            width: Dimensions.sizedBoxWidth100 * 3,
          ),
        ),
        SizedBox(
          height: Dimensions.sizedBoxWidth15 * 2,
        ),
        const Center(
          child: Text(
            'No Shops At The Moment',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
