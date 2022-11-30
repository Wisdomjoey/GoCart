import 'package:get/get.dart';
import 'package:schoolproj/pages/rating_view_page.dart';
import 'package:schoolproj/pages/account_page.dart';
import 'package:schoolproj/pages/cart_page.dart';
import 'package:schoolproj/pages/categories_page.dart';
import 'package:schoolproj/pages/details_page.dart';
import 'package:schoolproj/pages/home_page.dart';
import 'package:schoolproj/pages/inbox_page.dart';
import 'package:schoolproj/pages/order_details_page.dart';
import 'package:schoolproj/pages/order_status_page.dart';
import 'package:schoolproj/pages/orders_page.dart';
import 'package:schoolproj/pages/product_details_page.dart';
import 'package:schoolproj/pages/recently_searched_age.dart';
import 'package:schoolproj/pages/recently_viewed_page.dart';
import 'package:schoolproj/pages/route_page.dart';
import 'package:schoolproj/pages/saved_items_page.dart';
import 'package:schoolproj/pages/shop_page.dart';

class RouteHelper {
  static const String initial = '/';
  static const String routePage = '/routepage';
  static const String ratingsViewPage = '/reviews-stats';
  static const String productDetailsPage = '/product-details';
  static const String detailsPage = '/product-description';
  static const String ordersPage = '/orders';
  static const String inboxPage = '/inbox';
  static const String savedItemsPage = '/saved-items';
  static const String recentlyViewedPage = '/recently-viewed';
  static const String recentlySearchedPage = '/recently-searched';
  static const String orderStatusPage = '/order-status';
  static const String orderDetailsPage = '/order-details';

  static String getInitial() => initial;
  static getCartPage() => const CartPage();
  static getShopPage() => const ShopPage();
  static getHomePage() => const HomePage();
  static getAccountPage() => const AccountPage();
  static getCategoriesPage() => const CategoriesPage();
  static String getDetailsPage() => detailsPage;
  static String getOrderStatusPage() => orderStatusPage;
  static String getOrdersPage() => ordersPage;
  static String getInboxPage() => inboxPage;
  static String getOrderDetailsPage(String state, String text) =>
      '$orderDetailsPage?state=$state&text=$text';
  static String getRatingsViewPage() => ratingsViewPage;
  static String getProductDetailsPage() => productDetailsPage;
  static String getRecentlyViewedPage() => recentlyViewedPage;
  static String getRecentlySearchedPage() => recentlySearchedPage;
  static String getSavedItemsPage() => savedItemsPage;
  static String getRoutePage(int pageId) => '$routePage?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(name: ordersPage, page: () => const OrdersPage()),
    GetPage(name: inboxPage, page: () => const InboxPage()),
    GetPage(name: detailsPage, page: () => const DetailsPage()),
    GetPage(name: orderStatusPage, page: () => const OrderStatusPage()),
    GetPage(name: savedItemsPage, page: () => const SavedItemsPage()),
    GetPage(name: recentlyViewedPage, page: () => const RecentlyViewedPage()),
    GetPage(
        name: recentlySearchedPage, page: () => const RecentlySearchedPage()),
    GetPage(name: ratingsViewPage, page: () => const RatingViewPage()),
    GetPage(
        name: orderDetailsPage,
        page: () {
          var state = Get.parameters['state'];
          var text = Get.parameters['text'];

          return OrderDetailsPage(
            state: state!,
            text: text!,
          );
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
