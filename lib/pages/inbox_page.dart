import 'package:flutter/material.dart';
import 'package:GOCart/components/information_box.dart';
import 'package:GOCart/utils/dimensions.dart';

import '../components/home_app_bar.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Inbox',
        showCart: true,
        implyLeading: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: Dimensions.sizedBoxHeight10),
        itemCount: 5,
        itemBuilder: (context, index) {
          return const InformationBox();
        },
      ),
    );
  }
}
