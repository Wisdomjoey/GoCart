import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/PROVIDERS/shop_provider.dart';
import 'package:GOCart/UI/pages/dashboard/check_orders_page.dart';
import 'package:GOCart/UI/pages/dashboard/check_products_page.dart';
import 'package:GOCart/UI/pages/dashboard/dashboard_page.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/list_tile_btn_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({super.key});

  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  int index = 0;
  Map<String, dynamic> shopData = {};

  late List<Widget> pages;

  List<bool> anchors = [true, false, false];

  @override
  void initState() {
    super.initState();

    shopData = (Provider.of<ShopProvider>(context, listen: false).shops.where(
        (element) =>
            element[Constants.userId] ==
            FirebaseAuth.instance.currentUser!.uid)).elementAt(0) as Map<String, dynamic>;

    pages = [
      DashboardPage(
        shopId: shopData[Constants.uid],
      ),
      CheckOrdersPage(
        shopName: shopData[Constants.shopName],
      ),
      CheckProductsPage(
        shopId: shopData[Constants.uid],
        shopName: shopData[Constants.shopName],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(fontSize: Dimensions.font24),
        ),
        actions: [
          IconButton(
              onPressed: (() {
                Get.toNamed(RouteHelper.getManageShopPage(), arguments: shopData);
              }),
              tooltip: 'Manage Shop',
              icon: Stack(alignment: Alignment.center, children: [
                const Icon(
                  Icons.storefront,
                  color: Constants.lightGrey,
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.sizedBoxHeight15,
                      left: Dimensions.sizedBoxHeight15),
                  child: const Icon(
                    Icons.settings,
                    size: 15,
                    color: Constants.lightGrey,
                  ),
                )
              ]))
        ],
        backgroundColor: Constants.secondary,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(84, 0, 146, 63),
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
      ),
      body: pages[index],
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: double.maxFinite,
                  height: Dimensions.sizedBoxHeight100 * 2,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/med.gif'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: Dimensions.sizedBoxHeight10,
                ),
                ListTileBtn(
                  title: 'Dashboard',
                  textSize: Dimensions.font16,
                  textColor: anchors[0] == true
                      ? Constants.tetiary
                      : const Color.fromARGB(255, 89, 89, 89),
                  visualD: 0,
                  selected: anchors[0],
                  trailing: Icon(
                    Icons.dashboard,
                    color: anchors[0] == true
                        ? Constants.tetiary
                        : const Color.fromARGB(255, 89, 89, 89),
                  ),
                  hr: Dimensions.sizedBoxWidth10 * 2,
                  onTap: () {
                    if (index != 0) {
                      setState(() {
                        anchors[index] = false;
                        anchors[0] = true;
                        index = 0;
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
                ListTileBtn(
                  title: 'Orders',
                  textSize: Dimensions.font16,
                  textColor: anchors[1] == true
                      ? Constants.tetiary
                      : const Color.fromARGB(255, 89, 89, 89),
                  visualD: 0,
                  selected: anchors[1],
                  trailing: Icon(
                    Icons.receipt_long,
                    color: anchors[1] == true
                        ? Constants.tetiary
                        : const Color.fromARGB(255, 89, 89, 89),
                  ),
                  hr: Dimensions.sizedBoxWidth10 * 2,
                  onTap: () {
                    if (index != 1) {
                      setState(() {
                        anchors[index] = false;
                        anchors[1] = true;
                        index = 1;
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
                ListTileBtn(
                  title: 'Products',
                  textSize: Dimensions.font16,
                  textColor: anchors[2] == true
                      ? Constants.tetiary
                      : const Color.fromARGB(255, 89, 89, 89),
                  visualD: 0,
                  selected: true,
                  trailing: Icon(
                    Icons.category,
                    color: anchors[2] == true
                        ? Constants.tetiary
                        : const Color.fromARGB(255, 89, 89, 89),
                  ),
                  hr: Dimensions.sizedBoxWidth10 * 2,
                  onTap: () {
                    if (index != 2) {
                      setState(() {
                        anchors[index] = false;
                        anchors[2] = true;
                        index = 2;
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
            Column(
              children: [
                const Divider(
                  color: Color.fromARGB(255, 89, 89, 89),
                ),
                ListTileBtn(
                  title: 'Exit',
                  textSize: Dimensions.font16,
                  textColor: const Color.fromARGB(255, 89, 89, 89),
                  visualD: -2,
                  trailing: const Icon(
                    Icons.exit_to_app,
                    color: Color.fromARGB(255, 89, 89, 89),
                  ),
                  hr: Dimensions.sizedBoxWidth10 * 2,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
