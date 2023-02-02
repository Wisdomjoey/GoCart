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
  static const String userFCMToken = "fcmToken";
  static const String userPin = "authPin";
  static const String userPinIsSet = "pinIsSet";

  static const String orderId = "orderId";
  static const String orderdeliveryDate = "deliveryDate";
  static const String orderStatus = "status";

  static const String amount = "amount";

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
  static Map<String, List> cats = {
    categories[0]: [
      {'img': 'assets/images/c82.jpeg', 'label': 'Burgers'},
      {'img': 'assets/images/c83.jpeg', 'label': 'Fries'},
      {'img': 'assets/images/c84.jpeg', 'label': 'Cookies'},
      {'img': 'assets/images/c85.jpeg', 'label': 'Biscuits'},
      {'img': 'assets/images/c86.jpeg', 'label': 'Fast Foods'},
      {'img': 'assets/images/c87.jpeg', 'label': 'Ice-Creams'},
      {'img': 'assets/images/c88.jpeg', 'label': 'Sweets'},
    ],
    categories[1]: [
      {'img': 'assets/images/c89.jpeg', 'label': ''},
      {'img': 'assets/images/c90.jpeg', 'label': ''},
      {'img': 'assets/images/c91.jpeg', 'label': ''},
      {'img': 'assets/images/c92.jpeg', 'label': ''},
    ],
    categories[2]: [
      {'img': 'assets/images/c1.jpeg', 'label': 'Rice & Grains'},
      {'img': 'assets/images/c2.jpeg', 'label': 'Pasta'},
      {'img': 'assets/images/c3.jpeg', 'label': 'Noodles'},
      {'img': 'assets/images/c7.jpeg', 'label': 'Breakfast'},
      {'img': 'assets/images/c8.jpeg', 'label': 'Water'},
      {'img': 'assets/images/c5.jpeg', 'label': 'Drinks'},
      {'img': 'assets/images/c4.jpeg', 'label': 'Soft Drinks'},
      {'img': 'assets/images/c10.jpeg', 'label': 'Juices'},
      {'img': 'assets/images/c6.jpeg', 'label': 'Cooking'},
      {'img': 'assets/images/c9.jpeg', 'label': 'Canned Foods'},
      {'img': 'assets/images/c11.jpeg', 'label': 'Beer'},
      {'img': 'assets/images/c12.jpeg', 'label': 'Wine'},
      {'img': 'assets/images/c15.jpeg', 'label': 'Cleaning'},
      {'img': 'assets/images/c16.jpeg', 'label': 'Baby Products'},
      {'img': 'assets/images/c13.jpeg', 'label': 'Air Freshener'},
      {'img': 'assets/images/c14.jpeg', 'label': 'Toilet Paper'},
    ],
    categories[3]: [
      {'img': 'assets/images/c17.jpeg', 'label': 'MakeUp'},
      {'img': 'assets/images/c19.jpeg', 'label': 'Fragrances'},
      {'img': 'assets/images/c18.jpeg', 'label': 'Hair Care'},
      {'img': 'assets/images/c20.jpeg', 'label': 'Feminine Care'},
      {'img': 'assets/images/c21.jpeg', 'label': 'Oral Care'},
      {'img': 'assets/images/c22.jpeg', 'label': 'Health Care'},
    ],
    categories[4]: [
      {'img': 'assets/images/c23.jpeg', 'label': 'Towels'},
      {'img': 'assets/images/c24.jpeg', 'label': 'Bedding'},
      {'img': 'assets/images/c25.jpeg', 'label': 'Furnitures'},
      {'img': 'assets/images/c26.jpeg', 'label': 'Home Tools'},
      {'img': 'assets/images/c28.jpeg', 'label': 'Cookware'},
      {'img': 'assets/images/c29.jpeg', 'label': 'Cutleries'},
      {'img': 'assets/images/c27.jpeg', 'label': 'Lighting'},
      {'img': 'assets/images/c30.jpeg', 'label': 'Stationery'},
      {'img': 'assets/images/c31.jpeg', 'label': 'Small Appliances'},
      {'img': 'assets/images/c32.jpeg', 'label': 'Large Appliances'},
    ],
    categories[5]: [
      {'img': 'assets/images/c33.jpeg', 'label': 'Smartphones'},
      {'img': 'assets/images/c35.jpeg', 'label': 'Tablets'},
      {'img': 'assets/images/c34.jpeg', 'label': 'iPads'},
      {'img': 'assets/images/c36.jpeg', 'label': 'Phone Accessories'},
      {'img': 'assets/images/c38.jpeg', 'label': 'Ear Phones'},
      {'img': 'assets/images/c58.jpeg', 'label': 'Smart Watches'},
    ],
    categories[6]: [
      {'img': 'assets/images/c39.jpeg', 'label': 'Desktops'},
      {'img': 'assets/images/c40.jpeg', 'label': 'Laptops'},
      {'img': 'assets/images/c41.jpeg', 'label': 'Monitors'},
      {'img': 'assets/images/c42.jpeg', 'label': 'Hard Drives'},
      {'img': 'assets/images/c43.jpeg', 'label': 'Drive Accessories'},
      {'img': 'assets/images/c44.jpeg', 'label': 'Flash Drives'},
      {'img': 'assets/images/c45.jpeg', 'label': 'Softwares'},
      {'img': 'assets/images/c61.jpeg', 'label': 'Printers & Accessories'},
      {'img': 'assets/images/c46.jpeg', 'label': 'Computer Accessories'},
    ],
    categories[7]: [
      {'img': 'assets/images/c47.jpeg', 'label': 'Televisions'},
      {'img': 'assets/images/c48.jpeg', 'label': 'Dvd Players'},
      {'img': 'assets/images/c49.jpeg', 'label': 'Home Theatre'},
      {'img': 'assets/images/c50.jpeg', 'label': 'Cameras'},
      {'img': 'assets/images/c51.jpeg', 'label': 'Generators'},
      {'img': 'assets/images/c52.jpeg', 'label': 'Inverters & atteries'},
      {'img': 'assets/images/c62.jpeg', 'label': 'Solar Power'},
    ],
    categories[8]: [
      {'img': 'assets/images/c53.jpeg', 'label': 'Bags'},
      {'img': 'assets/images/c54.jpeg', 'label': 'Clothing'},
      {'img': 'assets/images/c57.jpeg', 'label': 'Shoes'},
      {'img': 'assets/images/c37.jpeg', 'label': 'Watches'},
      {'img': 'assets/images/c55.jpeg', 'label': 'Women\'s Clothing'},
      {'img': 'assets/images/c56.jpeg', 'label': 'Jewelries'},
      {'img': 'assets/images/c59.jpeg', 'label': 'Backpacks'},
      {'img': 'assets/images/c60.jpeg', 'label': 'Umbrellas'},
    ],
    categories[9]: [
      {'img': 'assets/images/c63.jpeg', 'label': 'Baby Clothes'},
      {'img': 'assets/images/c64.jpeg', 'label': 'Bay Bibs'},
      {'img': 'assets/images/c65.jpeg', 'label': 'Feeding Bottle'},
      {'img': 'assets/images/c66.jpeg', 'label': 'Baby Seats'},
      {'img': 'assets/images/c95.jpg', 'label': 'Baby Backpacks'},
      {'img': 'assets/images/c94.jpeg', 'label': 'Baby Walkers'},
      {'img': 'assets/images/c93.jpeg', 'label': 'Baby Potties'},
    ],
    categories[10]: [
      {'img': 'assets/images/c67.jpeg', 'label': 'Play Station'},
      {'img': 'assets/images/c68.jpeg', 'label': 'Xbox'},
      {'img': 'assets/images/c69.jpeg', 'label': 'Nintendo'},
      {'img': 'assets/images/c70.jpeg', 'label': 'Gaming Accessories'},
    ],
    categories[11]: [
      {'img': 'assets/images/c71.jpeg', 'label': 'Exercising Equipments'},
      {'img': 'assets/images/c72.jpeg', 'label': 'Exercise Mats'},
      {'img': 'assets/images/c73.jpeg', 'label': 'Jump Ropes'},
      {'img': 'assets/images/c74.jpeg', 'label': 'Sport Clothing'},
    ],
    categories[12]: [
      {'img': 'assets/images/c75.jpeg', 'label': 'Car Accessories'},
      {'img': 'assets/images/c76.jpeg', 'label': 'Car Covers'},
      {'img': 'assets/images/c77.jpeg', 'label': 'Car Mats'},
      {'img': 'assets/images/c78.jpeg', 'label': 'Lubricants'},
      {'img': 'assets/images/c79.jpeg', 'label': 'Seat Covers'},
      {'img': 'assets/images/c80.jpeg', 'label': 'Tires'},
      {'img': 'assets/images/c81.jpeg', 'label': 'Car Mirrors'},
    ],
  };

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
