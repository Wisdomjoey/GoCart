import 'dart:io';

import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:GOCart/PROVIDERS/shop_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../UI/utils/dimensions.dart';
import '../UI/widgets/elevated_button_widget.dart';

class Constants {
  final BuildContext context;

  Constants(this.context);

  static const backgroundColor = Color.fromARGB(255, 243, 243, 243);
  static const primary = Colors.green;
  static const secondary = Color(0XFF00923F);
  static const tetiary = Color(0XFFF8C300);
  static const lightGrey = Color(0XFFEDEDED);
  static const white = Colors.white;
  static const grey = Colors.grey;
  static const formFillColor = Color.fromARGB(255, 242, 242, 242);

  static const List<String> categories = [
    'Snacks',
    'Cooked Foods',
    'Groceries',
    'Health & Beauty',
    'Home & Office',
    'Phones & Tablets',
    'Computing',
    'Electronics',
    'Fashion',
    'Baby Products',
    'Gaming',
    'Sporting Goods',
    'Automobile'
  ];
  static const List<String> suggestions = [
    'Snacks',
    'Groceries',
    'Health & Beauty',
    'Home & Office',
    'Phones & Tablets',
    'Computing',
    'Electronics',
    'Fashion',
    'Baby Products',
    'Gaming',
    'Sporting Goods',
    'Automobile'
  ];
  static const List<String> shopCategory = [
    'Provision Store',
    'Stationary Store',
    'Snacks Shops',
    'Medical Store',
    'Canteens',
  ];
  static const List<String> shopCategoryV = [
    'Provisions',
    'Stationaries',
    'Snacks',
    'Pharmacy',
    'Canteens',
  ];

  static const String err = 'Field cannot be empty';

  static const String collectionUsers = "users";
  static const String collectionShops = "shops";
  static const String collectionOrders = "orders";
  static const String collectionReviews = "reviews";
  static const String collectionCart = "cart";
  static const String collectionInbox = "inbox";
  static const String collectionFoodCart = "foodCart";
  static const String collectionProducts = "products";

  static const String prefsUserFullName = "user-fullName";
  static const String prefsUserFirstName = "firstName";
  static const String prefsUserLastName = "lastName";
  static const String prefsUserSigned = "isSigned";
  static const String prefsUserPhoneVerified = "phoneVerified";
  static const String prefsUserEmail = "user-email";
  static const String prefsUserIsSeller = "userIsSeller";
  static const String prefsCartData = "cart-data";
  static const String prefsSearchHistory = "search-history";

  static const String uid = "uid";
  static const String shopId = "shopId";
  static const String productId = "productId";
  static const String userId = "userId";
  static const String createdAt = "createdAt";
  static const String updatedAt = "updatedAt";
  static const String shopName = "shopName";
  static const String sales = "sales";
  static const String imgUrls = "imgUrls";
  static const String imgUrl = "imgUrl";
  static const String name = "name";
  static const String likes = "likes";
  static const String month = "month";
  static const String subtotal = "subtotal";
  static const String quantity = "quantity";
  static const String newOrder = "new";
  static const String processing = "processing";
  static const String closed = "closed";
  static const String cancelled = "cancelled";
  static const String deliveryPrice = "deliveryPrice";

  static const String shopAddress = "shopAddress";
  static const String shopTags = "shopTags";

  static const String inboxMessage = "message";
  static const String inboxSubject = "subject";

  static const String prodDescription = "description";
  static const String prodOldPrice = "oldPrice";
  static const String prodTotalSales = "totalSales";
  static const String prodCategory = "category";
  static const String prodSpecifications = "specifications";
  static const String prodKeyFeatures = "keyFeatures";
  static const String prodNewPrice = "newPrice";
  static const String prodMinPrice = "minPrice";
  static const String prodTags = "tags";
  static const String prodTotalStock = "totalStock";
  static const String prodRating = "rating";
  static const String reviewStarNo = "starNo";
  static const String reviewTitle = "title";
  static const String reviewBody = "body";

  static const String userFirstName = "firstName";
  static const String userLastName = "lastName";
  static const String userIsSeller = "isSeller";
  static const String userIsPhoneVerified = "isPhoneVerified";
  static const String userIsEmailVerified = "isEmailVerified";
  static const String userUserName = "userName";
  static const String userEmail = "email";
  static const String userPhone = "phone";
  static const String userSavedItems = "savedItems";
  static const String userFavourites = "favourites";

  static const String orderId = "orderId";
  static const String orderdeliveryDate = "deliveryDate";
  static const String orderStatus = "status";

  static const String amount = "amount";

  NumberFormat currency() {
    // Locale locale = Localizations.localeOf(context);

    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');

    return format;
  }

  Widget buildPageItem(int position, String imgUrl1, String prodId,
      String shopId, int imgLength) {
    return Stack(alignment: Alignment.topRight, children: [
      Container(
        height: Dimensions.pageViewContainer,
        margin: EdgeInsets.only(right: Dimensions.sizedBoxWidth10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.font25 / 5),
          color: position.isEven
              ? const Color(0xFF69c5df)
              : const Color(0xFF9294cc),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.font25 / 5),
          child: Material(
            child: InkWell(
              splashColor: const Color.fromARGB(35, 55, 55, 55),
              child: Ink.image(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(imgUrl1)),
              onTap: () {},
            ),
          ),
        ),
      ),
      Container(
        width: Dimensions.sizedBoxWidth10 * 4,
        height: Dimensions.sizedBoxWidth10 * 4,
        margin: EdgeInsets.only(
            top: Dimensions.sizedBoxWidth10,
            right: Dimensions.sizedBoxWidth10 * 2),
        decoration: BoxDecoration(
            color: white.withAlpha(200),
            borderRadius:
                BorderRadius.circular(Dimensions.sizedBoxWidth100 / 2)),
        child: IconButton(
            onPressed: (() {
              showDialog(
                  context: context,
                  builder: (context) =>
                      showDialogC(context, imgUrl1, prodId, shopId, imgLength));
            }),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
      )
    ]);
  }

  Widget showDialogC(BuildContext context, String url, String prodId,
      String shopId, int imgLength) {
    return Dialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10 * 2),
      child: Container(
        padding: EdgeInsets.all(Dimensions.sizedBoxWidth15),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to delete this image?',
              style: TextStyle(
                  fontSize: Dimensions.font18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: Dimensions.sizedBoxWidth15 * 2,
            ),
            Row(
              children: [
                SizedBox(
                  width: Dimensions.sizedBoxWidth15,
                ),
                Expanded(
                  child: SizedBox(
                    height: Dimensions.sizedBoxHeight10 * 4,
                    width: double.maxFinite,
                    child: ElevatedBtn(
                      pressed: () async {
                        if (imgLength - 1 < 1) {
                          snackBar('Product should have at least one image!',
                              Colors.red);
                        } else {
                          if (shopId == '') {
                            await Provider.of<ProductProvider>(context,
                                    listen: false)
                                .deleteImg(prodId, url)
                                .then((value) {
                              if (value) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            });
                          } else {
                            await Provider.of<ShopProvider>(context,
                                    listen: false)
                                .deleteImg(shopId, url)
                                .then((value) {
                              if (value) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            });
                          }
                        }
                      },
                      bgColor: Colors.green,
                      icon: const Icon(
                        Icons.task_alt,
                        color: white,
                      ),
                      child: Provider.of<ProductProvider>(context).process ==
                              Process.processing
                          ? SizedBox(
                              width: Dimensions.sizedBoxWidth10 * 2,
                              height: Dimensions.sizedBoxWidth10 * 2,
                              child: const CircularProgressIndicator(
                                color: Constants.white,
                                strokeWidth: 3,
                              ))
                          : Text(
                              'YES',
                              style: TextStyle(
                                  color: Constants.white,
                                  fontSize: Dimensions.font14),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimensions.sizedBoxWidth10 * 2,
                ),
                Expanded(
                    child: SizedBox(
                  height: Dimensions.sizedBoxHeight10 * 4,
                  width: double.maxFinite,
                  child: ElevatedBtn(
                      text: 'NO',
                      bgColor: Colors.red,
                      pressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: white,
                      )),
                )),
                SizedBox(
                  width: Dimensions.sizedBoxWidth15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  snackBar(String message, Color color) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
      duration: const Duration(seconds: 5),
      borderRadius: Dimensions.sizedBoxWidth4,
      margin: EdgeInsets.only(
          bottom: Dimensions.sizedBoxHeight15,
          right: Dimensions.sizedBoxWidth10,
          left: Dimensions.sizedBoxWidth10),
    ));
  }
}