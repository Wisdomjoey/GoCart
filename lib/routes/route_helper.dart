import 'package:get/get.dart';
import 'package:schoolproj/pages/cartPage.dart';
import 'package:schoolproj/pages/homePage.dart';
import 'package:schoolproj/pages/routePage.dart';

class RouteHelper {
  static const String initial = '/';
  static const String cartPage = '/cart';
  static const String routePage = '/routepage';

  static String getInitial() => '$initial';
  static String getCartPage() => '$cartPage';
  static String getRoutePage(int pageId) => '$routePage?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(name: cartPage, page: () => const CartPage()),
    GetPage(
        name: routePage,
        page: () {
          var pageId = Get.parameters['pageId'];

          return RoutePage(pageId: int.parse(pageId!),);
        }),
  ];
}
