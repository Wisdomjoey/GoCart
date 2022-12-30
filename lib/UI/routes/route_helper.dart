import 'package:GOCart/UI/pages/account_management_page.dart';
import 'package:GOCart/UI/pages/intro_page.dart';
import 'package:GOCart/UI/pages/phone_auth_page.dart';
import 'package:GOCart/UI/pages/phone_register_page.dart';
import 'package:GOCart/UI/pages/settings_page.dart';
import 'package:GOCart/UI/pages/shop_register_page.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/pages/login_page.dart';
import 'package:GOCart/UI/pages/product_list_page.dart';
import 'package:GOCart/UI/pages/rating_view_page.dart';
import 'package:GOCart/UI/pages/account_page.dart';
import 'package:GOCart/UI/pages/cart_page.dart';
import 'package:GOCart/UI/pages/categories_page.dart';
import 'package:GOCart/UI/pages/details_page.dart';
import 'package:GOCart/UI/pages/home_page.dart';
import 'package:GOCart/UI/pages/inbox_page.dart';
import 'package:GOCart/UI/pages/order_details_page.dart';
import 'package:GOCart/UI/pages/order_status_page.dart';
import 'package:GOCart/UI/pages/orders_page.dart';
import 'package:GOCart/UI/pages/product_details_page.dart';
import 'package:GOCart/UI/pages/recently_searched_page.dart';
import 'package:GOCart/UI/pages/recently_viewed_page.dart';
import 'package:GOCart/UI/pages/register_page.dart';
import 'package:GOCart/UI/pages/route_page.dart';
import 'package:GOCart/UI/pages/saved_items_page.dart';
import 'package:GOCart/UI/pages/shop_page.dart';
import 'package:GOCart/UI/pages/shop_details_page.dart';
import 'package:GOCart/UI/pages/splash_page.dart';

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
  static const String accountManagementPage = '/account-management';
  static const String orderStatusPage = '/order-status';
  static const String orderDetailsPage = '/order-details';
  static const String shopDetailsPage = '/shop-details';
  static const String loginPage = '/login';
  static const String splashPage = '/splash';
  static const String registerPage = '/register';
  static const String shopRegisterPage = '/shop-register';
  static const String phoneRegisterPage = '/phone-register';
  static const String phoneAuthPage = '/phone-auth';
  static const String settingsPage = '/settings';
  static const String productListPage = '/product-list';
  static const String introPage = '/intro';

  static String getInitial() => initial;
  static getCartPage() => const CartPage();
  static getShopPage() => const ShopPage();
  static getShopDetailsPage() => shopDetailsPage;
  static getHomePage() => const HomePage();
  static getIntroPage() => introPage;
  static getAccountPage() => const AccountPage();
  static getCategoriesPage() => const CategoriesPage();
  static String getDetailsPage() => detailsPage;
  static String getOrderStatusPage() => orderStatusPage;
  static String getPhoneAuthPage() => phoneAuthPage;
  static String getProductListPage() => productListPage;
  static String getShopRegisterPage() => shopRegisterPage;
  static String getPhoneRegisterPage() => phoneRegisterPage;
  static String getOrdersPage() => ordersPage;
  static String getSettingsPage() => settingsPage;
  static String getInboxPage() => inboxPage;
  static String getOrderDetailsPage(String state, String text) =>
      '$orderDetailsPage?state=$state&text=$text';
  static String getRatingsViewPage() => ratingsViewPage;
  static String getProductDetailsPage() => productDetailsPage;
  static String getRecentlyViewedPage() => recentlyViewedPage;
  static String getRecentlySearchedPage() => recentlySearchedPage;
  static String getAccountManagementPage() => accountManagementPage;
  static String getSavedItemsPage() => savedItemsPage;
  static String getRegisterPage() => registerPage;
  static String getLoginPage() => loginPage;
  static String getSplashPage() => splashPage;
  static String getRoutePage(int pageId) => '$routePage?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: initial,
        page: () => const HomePage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: ordersPage,
        page: () => const OrdersPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: phoneAuthPage,
        page: () => const PhoneAuthPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: shopDetailsPage,
        page: () => const ShopDetailsPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: shopRegisterPage,
        page: () => const ShopRegisterPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: inboxPage,
        page: () => const InboxPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: detailsPage,
        page: () => const DetailsPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: settingsPage,
        page: () => const SettingsPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: orderStatusPage,
        page: () => const OrderStatusPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: productListPage,
        page: () => const ProductListPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: savedItemsPage,
        page: () => const SavedItemsPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: recentlyViewedPage,
        page: () => const RecentlyViewedPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: accountManagementPage,
        page: () => const AccountManagementPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: recentlySearchedPage,
        page: () => const RecentlySearchedPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: ratingsViewPage,
        page: () => const RatingViewPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: loginPage,
        page: () => const LoginPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: splashPage,
        page: () => const SplashPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: introPage,
        page: () => const IntroPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: registerPage,
        page: () => const RegisterPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: phoneRegisterPage,
        page: () => PhoneRegisterPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: orderDetailsPage,
        page: () {
          var state = Get.parameters['state'];
          var text = Get.parameters['text'];

          return OrderDetailsPage(
            state: state!,
            text: text!,
          );
        }),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: productDetailsPage,
        page: () => const ProductDetailsPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: routePage,
        page: () {
          var pageId = Get.parameters['pageId'];

          return RoutePage(
            pageId: int.parse(pageId!),
          );
        }),
  ];
}
