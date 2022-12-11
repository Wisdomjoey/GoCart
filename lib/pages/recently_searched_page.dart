import 'package:flutter/material.dart';

import '../components/home_app_bar.dart';
import '../utils/dimensions.dart';

class RecentlySearchedPage extends StatelessWidget {
  const RecentlySearchedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Recently Searched',
        showCart: true,
        implyLeading: true,
        textSize: Dimensions.font24,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/searched.png',
              width: Dimensions.sizedBoxWidth100 * 3,
            ),
          ),
          SizedBox(
            height: Dimensions.sizedBoxWidth15 * 2,
          ),
          const Center(
            child: Text(
              'Your search history is shown here',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
