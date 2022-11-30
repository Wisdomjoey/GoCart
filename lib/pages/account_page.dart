import 'package:flutter/material.dart';
import 'package:schoolproj/routes/route_helper.dart';
import 'package:schoolproj/utils/dimensions.dart';
import 'package:schoolproj/widgets/list_tile_btn_widget.dart';
import 'package:schoolproj/widgets/head_section_widget.dart';
import 'package:schoolproj/widgets/txt_button_widget.dart';

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
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
              child: Column(
                children: [
                  ListTileBtn(title: 'Orders', leading: Icon(Icons.store_rounded, size: Dimensions.font20 + 2,), textSize: Dimensions.font14, page: RouteHelper.getOrdersPage(),),
                  ListTileBtn(title: 'Inbox', leading: Icon(Icons.mail_outline_rounded, size: Dimensions.font20 + 2,), textSize: Dimensions.font14, page: RouteHelper.getInboxPage(),),
                  ListTileBtn(title: 'Saved Items', leading: Icon(Icons.favorite_outline_outlined, size: Dimensions.font20 + 2,), textSize: Dimensions.font14, page: RouteHelper.getSavedItemsPage(),),
                  ListTileBtn(title: 'Recently Viewed', leading: Icon(Icons.history_rounded, size: Dimensions.font20 + 2,), textSize: Dimensions.font14, page: RouteHelper.getRecentlyViewedPage(),),
                  ListTileBtn(title: 'Recently Searched', leading: Icon(Icons.youtube_searched_for_rounded, size: Dimensions.font20 + 2,), textSize: Dimensions.font14, page: RouteHelper.getRecentlySearchedPage(),)
                ],
              ),
            ),
            HeadSedction(
              text: 'MY SETTINGS',
              textSize: Dimensions.font13,
              weight: FontWeight.w500,
            ),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
              child: Column(
                children: [
                  ListTileBtn(title: 'Account Management', textSize: Dimensions.font14),
                  ListTileBtn(title: 'Close Account', textSize: Dimensions.font14),
                ],
              ),
            ),
            const TxtButton(text: 'LOGOUT')
          ],
        ),
      ),
    );
  }
}
