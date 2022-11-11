import 'package:get/get.dart';
import 'package:schoolproj/pages/cartPage.dart';
import 'package:schoolproj/pages/homePage.dart';

class RouteHelper {
  static const String initial = '/';
  static const String cartPage = '/cart';

  static String getInitial() => '$initial';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(name: cartPage, page: () => const CartPage()),
  ];
}
