import 'package:GOCart/PROVIDERS/auth_provider.dart';
import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:GOCart/UI/widgets/list_tile_btn_widget.dart';
import 'package:GOCart/UI/widgets/head_section_widget.dart';
import 'package:GOCart/UI/widgets/txt_button_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../CONSTANTS/constants.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadSedction(
              text: 'MY ACCOUNT',
              textSize: Dimensions.font13,
              weight: FontWeight.w500,
            ),
            Material(
              color: Constants.white,
              borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
              child: Column(
                children: [
                  Provider.of<UserProvider>(context)
                          .userData[Constants.userIsSeller]
                      ? ListTileBtn(
                          title: 'Dashboard',
                          leading: Icon(
                            Icons.dashboard_outlined,
                            size: Dimensions.font20 + 2,
                          ),
                          textSize: Dimensions.font14,
                          page: RouteHelper.getDashboardPage(),
                        )
                      : ListTileBtn(
                          title: 'Become a Seller',
                          leading: Icon(
                            Icons.handshake_outlined,
                            size: Dimensions.font20 + 2,
                          ),
                          showTrailing: false,
                          textSize: Dimensions.font14,
                          page: RouteHelper.getShopRegisterPage(),
                        ),
                  ListTileBtn(
                    title: 'Orders',
                    leading: Icon(
                      Icons.receipt_outlined,
                      size: Dimensions.font20 + 2,
                    ),
                    textSize: Dimensions.font14,
                    page: RouteHelper.getOrdersPage(),
                  ),
                  ListTileBtn(
                    title: 'Inbox',
                    leading: Icon(
                      Icons.mail_outline_rounded,
                      size: Dimensions.font20 + 2,
                    ),
                    textSize: Dimensions.font14,
                    page: RouteHelper.getInboxPage(),
                  ),
                  ListTileBtn(
                    title: 'Saved Items',
                    leading: Icon(
                      Icons.favorite_outline_outlined,
                      size: Dimensions.font20 + 2,
                    ),
                    textSize: Dimensions.font14,
                    page: RouteHelper.getSavedItemsPage(),
                  ),
                  // ListTileBtn(
                  //   title: 'Recently Viewed',
                  //   leading: Icon(
                  //     Icons.history_rounded,
                  //     size: Dimensions.font20 + 2,
                  //   ),
                  //   textSize: Dimensions.font14,
                  //   page: RouteHelper.getRecentlyViewedPage(),
                  // ),
                  ListTileBtn(
                    title: 'Recently Searched',
                    leading: Icon(
                      Icons.youtube_searched_for_rounded,
                      size: Dimensions.font20 + 2,
                    ),
                    textSize: Dimensions.font14,
                    page: RouteHelper.getRecentlySearchedPage(),
                  )
                ],
              ),
            ),
            HeadSedction(
              text: 'MY SETTINGS',
              textSize: Dimensions.font13,
              weight: FontWeight.w500,
            ),
            Material(
              color: Constants.white,
              borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
              child: Column(
                children: [
                  ListTileBtn(
                    title: 'Settings',
                    textSize: Dimensions.font14,
                    page: RouteHelper.getSettingsPage(),
                  ),
                  ListTileBtn(
                    title: 'Account Management',
                    textSize: Dimensions.font14,
                    page: RouteHelper.getAccountManagementPage(),
                  ),
                  ListTileBtn(
                      title: 'Close Account', textSize: Dimensions.font14),
                ],
              ),
            ),
            TxtButton(
              text: 'LOGOUT',
              pressed: () async {
                await Provider.of<AuthProvider>(context, listen: false)
                    .signOut()
                    .then((value) {
                  if (value != null) {
                    Constants(context).snackBar(value, Colors.red);
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
