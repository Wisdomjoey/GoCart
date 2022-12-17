import 'package:flutter/material.dart';

import '../components/home_app_bar.dart';
import '../utils/dimensions.dart';
import '../widgets/head_section_widget.dart';
import '../widgets/list_tile_btn_widget.dart';

class AccountManagementPage extends StatefulWidget {
  const AccountManagementPage({super.key});

  @override
  State<AccountManagementPage> createState() => _AccountManagementPageState();
}

class _AccountManagementPageState extends State<AccountManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        textSize: Dimensions.font24,
        title: 'Account Management',
        implyLeading: true,
        showCart: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadSedction(
                text: 'PROFILE DETAILS',
                weight: FontWeight.w500,
              ),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
                child: Column(
                  children: [
                    ListTileBtn(
                        title: 'Basic Details', textSize: Dimensions.font14),
                    ListTileBtn(
                        title: 'Edit Phone Number',
                        textSize: Dimensions.font14),
                  ],
                ),
              ),
              const HeadSedction(
                text: 'SECURITY SETTINGS',
                weight: FontWeight.w500,
              ),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.sizedBoxWidth4),
                child: Column(
                  children: [
                    ListTileBtn(
                        title: 'Change Password', textSize: Dimensions.font14),
                    ListTileBtn(
                        title: 'Pin Settings', textSize: Dimensions.font14),
                    ListTileBtn(
                        title: 'Delete Account', textSize: Dimensions.font14),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
