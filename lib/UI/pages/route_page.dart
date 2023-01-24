import 'package:GOCart/PROVIDERS/auth_provider.dart';
import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:GOCart/UI/components/account_app_bar.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/navigation_icon_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../PREFS/preferences.dart';
import '../components/home_app_bar.dart';
import '../../CONSTANTS/constants.dart';

class RoutePage extends StatefulWidget {
  final int pageId;

  const RoutePage({super.key, this.pageId = 0});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  int _activePage = 0;
  bool _allowPageId = true;
  bool isSeller = false;

  final GlobalKey<CurvedNavigationBarState> _globalKey = GlobalKey();

  late List _pages;

  getUserData() async {
    await Preferences().getBoolData(Constants.userIsSeller).then((value) async {
      isSeller = value!;

      await Preferences()
          .getBoolData(Constants.userIsSeller)
          .then((value1) async {
        isSeller = value1!;
        _pages[4] = RouteHelper.getAccountPage(isSeller);
      });
      // print(value);
    });
  }

  late PreferredSizeWidget page;
  late List<PreferredSizeWidget> page1;

  @override
  void initState() {
    Future.delayed(Duration.zero, (() {
      Provider.of<AuthProvider>(context, listen: false).setLoginStatus();

      if (!Provider.of<AuthProvider>(context, listen: false).loginStatus) {
        Constants(context).snackBar('You are not logged in', Colors.red);
        Get.offAllNamed(RouteHelper.getLoginPage());
      }
    }));

    page = HomeAppBar(
      logo: Container(
        width: Dimensions.sizedBoxWidth10 * 9,
        height: Dimensions.sizedBoxHeight100 / 2,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/GoCart  sample4.png'))),
      ),
    );

    _pages = [
      RouteHelper.getHomePage(),
      RouteHelper.getCategoriesPage(),
      RouteHelper.getCartPage(),
      RouteHelper.getShopPage(),
      RouteHelper.getAccountPage(isSeller),
    ];

    getUserData();

    page1 = [
      HomeAppBar(
        logo: Container(
          width: Dimensions.sizedBoxWidth10 * 9,
          height: Dimensions.sizedBoxHeight100 / 2,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/GoCart  sample4.png'))),
        ),
      ),
      HomeAppBar(
        title: 'Category',
        textSize: Dimensions.font24,
        icon: const Icon(Icons.list_alt_outlined),
      ),
      HomeAppBar(
        title: 'Cart',
        textSize: Dimensions.font24,
        icon: const Icon(Icons.shopping_cart_outlined),
      ),
      HomeAppBar(
        title: 'Shops',
        textSize: Dimensions.font24,
        icon: const Icon(Icons.store_outlined),
      ),
      AccountAppBar()
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _allowPageId
          ? (widget.pageId == 4 ? AccountAppBar() : page1[widget.pageId])
          : page,
      body: _pages[_allowPageId ? widget.pageId : _activePage],
      // extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        key: _globalKey,
        index: _allowPageId ? widget.pageId : _activePage,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Constants.primary,
        height: Dimensions.sizedBoxHeight65,
        items: const [
          NavigationIcon(icon: Icon(Icons.home_outlined), text: 'Home'),
          NavigationIcon(icon: Icon(Icons.list_alt_outlined), text: 'Category'),
          NavigationIcon(
              icon: Icon(Icons.shopping_cart_outlined), text: 'Cart'),
          NavigationIcon(icon: Icon(Icons.store_outlined), text: 'Shops'),
          NavigationIcon(icon: Icon(Icons.person_outline), text: 'Account'),
        ],
        items2: const [
          Icon(
            Icons.home,
            color: Constants.white,
          ),
          Icon(
            Icons.list_alt,
            color: Constants.white,
          ),
          Icon(
            Icons.shopping_cart,
            color: Constants.white,
          ),
          Icon(
            Icons.store,
            color: Constants.white,
          ),
          Icon(
            Icons.person,
            color: Constants.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _activePage = index;
            _allowPageId = false;
            // if (index == 4) {
            //   page = AccountAppBar();
            // } else {
            //   page = HomeAppBar(title: 'GO-CART');
            // }
            switch (index) {
              case 0:
                page = HomeAppBar(
                  logo: Container(
                    width: Dimensions.sizedBoxWidth10 * 9,
                    height: Dimensions.sizedBoxHeight100 / 2,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/GoCart  sample4.png'))),
                  ),
                );
                break;
              case 1:
                page = HomeAppBar(
                  title: 'Category',
                  textSize: Dimensions.font24,
                  icon: const Icon(Icons.list_alt_outlined),
                );
                break;
              case 2:
                page = HomeAppBar(
                  title: 'Cart',
                  textSize: Dimensions.font24,
                  icon: const Icon(Icons.shopping_cart_outlined),
                );
                break;
              case 3:
                page = HomeAppBar(
                  title: 'Shops',
                  textSize: Dimensions.font24,
                  icon: const Icon(Icons.store_outlined),
                );
                break;
              case 4:
                page = AccountAppBar();
                break;
              default:
                page = HomeAppBar(
                  logo: Container(
                    width: Dimensions.sizedBoxWidth10 * 9,
                    height: Dimensions.sizedBoxHeight100 / 2,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/GoCart  sample4.png'))),
                  ),
                );
            }
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
