import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/UI/pages/account_management_page.dart';
import 'package:GOCart/UI/pages/dashboard/add_product_page.dart';
import 'package:GOCart/UI/pages/dashboard/edit_product_page.dart';
import 'package:GOCart/UI/pages/dashboard/manage_shop_page.dart';
import 'package:GOCart/UI/pages/intro_page.dart';
import 'package:GOCart/UI/pages/password_reset_page.dart';
import 'package:GOCart/UI/pages/phone_auth_page.dart';
import 'package:GOCart/UI/pages/phone_register_page.dart';
import 'package:GOCart/UI/pages/dashboard/seller_dasboard.dart';
import 'package:GOCart/UI/pages/profile_page.dart';
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
import 'package:GOCart/UI/pages/orders_page.dart';
import 'package:GOCart/UI/pages/product_details_page.dart';
import 'package:GOCart/UI/pages/recently_searched_page.dart';
import 'package:GOCart/UI/notinuse/recently_viewed_page.dart';
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
  static const String manageShopPage = '/manage-shop';
  static const String phoneRegisterPage = '/phone-register';
  static const String phoneAuthPage = '/phone-auth';
  static const String settingsPage = '/settings';
  static const String productListPage = '/product-list';
  static const String addProductPage = '/add-product';
  static const String editProductPage = '/edit-product';
  static const String introPage = '/intro';
  static const String profilePage = '/profile';
  static const String dashboardPage = '/dashboard';
  static const String passwordResetPage = '/password-reset';

  static getCartPage() => const CartPage();
  static String getInitial() => initial;
  static getShopPage() => ShopPage();
  static getShopDetailsPage() => shopDetailsPage;
  static getHomePage() => const HomePage();
  static getIntroPage() => introPage;
  static getAccountPage() => const AccountPage();
  static getCategoriesPage() => const CategoriesPage();
  static String getDetailsPage() => detailsPage;
  static String getProfilePage() => profilePage;
  static String getOrderStatusPage() => orderStatusPage;
  static String getPhoneAuthPage() => phoneAuthPage;
  static String getProductListPage() => productListPage;
  static String getShopRegisterPage() => shopRegisterPage;
  static String getPhoneRegisterPage() => phoneRegisterPage;
  static String getOrdersPage() => ordersPage;
  static String getSettingsPage() => settingsPage;
  static String getManageShopPage() => manageShopPage;
  static String getPasswordResetPage() => passwordResetPage;
  static String getInboxPage() => inboxPage;
  static String getOrderDetailsPage() => orderDetailsPage;
  static String getRatingsViewPage() => ratingsViewPage;
  static String getProductDetailsPage() => productDetailsPage;
  static String getRecentlyViewedPage() => recentlyViewedPage;
  static String getRecentlySearchedPage() => recentlySearchedPage;
  static String getAccountManagementPage() => accountManagementPage;
  static String getSavedItemsPage() => savedItemsPage;
  static String getRegisterPage() => registerPage;
  static String getLoginPage() => loginPage;
  static String getSplashPage(String? prodId) => '$splashPage?prodId=$prodId';
  static String getDashboardPage() => dashboardPage;
  static String getAddProductPage() => addProductPage;
  static String getEditProductPage() => editProductPage;
  static String getRoutePage() => routePage;

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
        name: dashboardPage,
        page: () => const SellerDashboard()),
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
        name: passwordResetPage,
        page: () => const PasswordResetPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: addProductPage,
        page: () {
          String shopName = Get.arguments[Constants.shopName];
          String shopId = Get.arguments[Constants.shopId];

          return AddProductPage(
            shopName: shopName,
            shopId: shopId,
          );
        }),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: profilePage,
        page: () => const ProfilePage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: manageShopPage,
        page: () {
          Map<String, dynamic> shopData = Get.arguments;

          return ManageShopPage(shopData: shopData);
        }),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: editProductPage,
        page: () {
          Map<String, dynamic> data = Get.arguments;

          return EditProductPage(data: data);
        }),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: phoneAuthPage,
        page: () {
          String phone = Get.arguments;

          return PhoneAuthPage(phoneNumber: phone);
        }),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: shopDetailsPage,
        page: () {
          var shopUserId = Get.arguments;

          return ShopDetailsPage(
            shopId: shopUserId,
          );
        }),
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
        page: () {
          List data = Get.arguments;

          return DetailsPage(
            description: data[0],
            features: data[1],
            specifications: data[2],
          );
        }),
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
        name: productListPage,
        page: () {
          //   String? title = Get.parameters['title'];
          String? title = Get.arguments[0];
          bool? isSearched = Get.arguments[1];

          return ProductListPage(
            title: title!,
            isSearched: isSearched!,
          );
        }),
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
        page: () {
          List data = Get.arguments;

          return RatingViewPage(
            reviews: data[0], rating: data[1],
          );
        }),
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
        page: () {
          String? prodId = Get.parameters['prodId'];

          return SplashPage(
            prodId: prodId,
          );
        }),
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
        page: () => const PhoneRegisterPage()),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: orderDetailsPage,
        page: () {
          Map<String, dynamic> data = Get.arguments[0];
          Color color = Get.arguments[1];
          String text = Get.arguments[2];

          return OrderDetailsPage(
            color: color,
            text: text,
            data: data,
          );
        }),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: productDetailsPage,
        page: () {
          Map<String, dynamic> data = Get.arguments;

          return ProductDetailsPage(
            data: data,
          );
        }),
    GetPage(
        curve: Curves.easeInOut,
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        name: routePage,
        page: () {
          int pageId = Get.arguments;

          return RoutePage(
            pageId: pageId,
          );
        }),
  ];
}
