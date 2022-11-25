import 'package:flutter/material.dart';
import 'package:schoolproj/routes/route_helper.dart';
import 'package:schoolproj/utils/dimensions.dart';
import 'package:schoolproj/widgets/ListTileBtnWidget.dart';
import 'package:schoolproj/widgets/headSectionWidget.dart';
import 'package:schoolproj/widgets/txtButtonWidget.dart';

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
                  ListTileBtn(title: 'Orders', leading: Icon(Icons.store_rounded, size: 23,), page: RouteHelper.getOrdersPage(),),
                  ListTileBtn(title: 'Inbox', leading: Icon(Icons.mail_outline_rounded, size: 23,),),
                  ListTileBtn(title: 'Saved Items', leading: Icon(Icons.favorite_outline_outlined, size: 23,),),
                  ListTileBtn(title: 'Recently Viewed', leading: Icon(Icons.history_rounded, size: 23,),),
                  ListTileBtn(title: 'Recently Searched', leading: Icon(Icons.youtube_searched_for_rounded, size: 23,),)
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
                children: const [
                  ListTileBtn(title: 'Account Management'),
                  ListTileBtn(title: 'Close Account'),
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
