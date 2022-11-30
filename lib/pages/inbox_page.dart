import 'package:flutter/material.dart';
import 'package:schoolproj/components/information_box.dart';
import 'package:schoolproj/utils/dimensions.dart';

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
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
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
