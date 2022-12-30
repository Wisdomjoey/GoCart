import 'package:flutter/material.dart';

import '../components/home_app_bar.dart';
import '../constants/constants.dart';
import '../utils/dimensions.dart';

class RecentlyViewedPage extends StatelessWidget {
  const RecentlyViewedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Recently Viewed',
        showCart: true,
        implyLeading: true,
        textSize: Dimensions.font24,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/view.png',
              width: Dimensions.sizedBoxWidth100 * 3,
            ),
          ),
          SizedBox(
            height: Dimensions.sizedBoxWidth15 * 2,
          ),
          const Center(
            child: Text(
              'You haven\'t viewed any item recently',
              style: TextStyle(color: Constants.grey),
            ),
          ),
        ],
      ),
    );
  }
}
