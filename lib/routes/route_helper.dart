import 'package:get/get.dart';
import 'package:schoolproj/pages/RatingViewPage.dart';
import 'package:schoolproj/pages/accountPage.dart';
import 'package:schoolproj/pages/cartPage.dart';
import 'package:schoolproj/pages/categoriesPage.dart';
import 'package:schoolproj/pages/detailsPage.dart';
import 'package:schoolproj/pages/homePage.dart';
import 'package:schoolproj/pages/orderDetailsPage.dart';
import 'package:schoolproj/pages/ordersPage.dart';
import 'package:schoolproj/pages/productDetailsPage.dart';
import 'package:schoolproj/pages/routePage.dart';
import 'package:schoolproj/pages/shopPage.dart';

class RouteHelper {
  static const String initial = '/';
  static const String routePage = '/routepage';
  static const String ratingsViewPage = '/reviews-stats';
  static const String productDetailsPage = '/product-details';
  static const String detailsPage = '/product-description';
  static const String ordersPage = '/orders';
  static const String orderDetailsPage = '/order-details';

  static String getInitial() => '$initial';
  static getCartPage() => const CartPage();
  static getShopPage() => const ShopPage();
  static getHomePage() => const HomePage();
  static getAccountPage() => const AccountPage();
  static getCategoriesPage() => const CategoriesPage();
  static String getDetailsPage() => '$detailsPage';
  static String getOrdersPage() => '$ordersPage';
  static String getOrderDetailsPage(String state, String text) =>
      '$orderDetailsPage?state=$state&text=$text';
  static String getRatingsViewPage() => '$ratingsViewPage';
  static String getProductDetailsPage() => '$productDetailsPage';
  static String getRoutePage(int pageId) => '$routePage?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(name: ordersPage, page: () => const OrdersPage()),
    GetPage(name: detailsPage, page: () => const DetailsPage()),
    GetPage(name: ratingsViewPage, page: () => const RatingViewPage()),
    GetPage(
        name: orderDetailsPage,
        page: () {
          var state = Get.parameters['state'];
          var text = Get.parameters['text'];

          return OrderDetailsPage(state: state!, text: text!,);
        }),
    GetPage(name: productDetailsPage, page: () => const ProductDetailsPage()),
    GetPage(
        name: routePage,
        page: () {
          var pageId = Get.parameters['pageId'];

          return RoutePage(
            pageId: int.parse(pageId!),
          );
        }),
  ];
}
