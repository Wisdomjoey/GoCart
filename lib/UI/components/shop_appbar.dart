import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../CONSTANTS/constants.dart';
import '../utils/dimensions.dart';

class ShopAppbar extends StatefulWidget with PreferredSizeWidget {
  const ShopAppbar({super.key});

  @override
  State<ShopAppbar> createState() => _ShopAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + Dimensions.sizedBoxHeight10 * 5);
}

class _ShopAppbarState extends State<ShopAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // leading: const Icon(Icons.store_outlined),
      title: Text(
        'Shops',
        style: TextStyle(fontSize: Dimensions.font24),
      ),
      bottom: PreferredSize(
        preferredSize: Size(double.maxFinite, Dimensions.sizedBoxHeight10 * 5),
        child: Container(
          width: double.maxFinite,
          height: Dimensions.sizedBoxHeight10 * 4,
          margin: EdgeInsets.all(Dimensions.sizedBoxWidth10),
          decoration: BoxDecoration(
              color: Constants.white,
              borderRadius:
                  BorderRadius.circular(Dimensions.sizedBoxWidth10 * 4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Constants.grey,
                  size: 24,
                ),
                splashRadius: 24,
                padding: EdgeInsets.all(0),
                tooltip: 'Search',
                onPressed: () {},
              ),
              Expanded(child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              )),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Constants.grey,
                  size: 24,
                ),
                splashRadius: 24,
                padding: EdgeInsets.all(0),
                tooltip: 'Search',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Constants.secondary,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Constants.secondary,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
    );
  }
}
