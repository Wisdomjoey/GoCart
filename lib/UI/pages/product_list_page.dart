import 'package:flutter/material.dart';
import 'package:GOCart/UI/components/home_app_bar.dart';
import 'package:GOCart/UI/components/product_box.dart';

import '../utils/dimensions.dart';

class ProductListPage extends StatefulWidget {
  final String title;

  const ProductListPage({super.key, required this.title});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        implyLeading: true,
        showCart: true,
        showPopUp: true,
        textSize: Dimensions.font23,
        title: widget.title,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: Dimensions.sizedBoxHeight10),
          child: const ProductBox(),
        ),
      ),
    );
  }
}
