import 'package:flutter/material.dart';

import '../components/home_app_bar.dart';
import '../constants/constants.dart';
import '../utils/dimensions.dart';

class SavedItemsPage extends StatelessWidget {
  const SavedItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Saved Items',
        showCart: true,
        implyLeading: true,
        textSize: Dimensions.font24,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.favorite,
              size: Dimensions.sizedBoxWidth25 * 6,
              color: const Color.fromARGB(255, 186, 186, 186),
            ),
          ),
          SizedBox(
            height: Dimensions.sizedBoxWidth15 * 2,
          ),
          Center(
            child: Text(
              'You don\'t have any saved items',
              style:
                  TextStyle(color: Constants.grey, fontSize: Dimensions.font16),
            ),
          ),
        ],
      ),
    );
  }
}
