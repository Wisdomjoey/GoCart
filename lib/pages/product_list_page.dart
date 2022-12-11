import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:GOCart/components/home_app_bar.dart';
import 'package:GOCart/components/product_box.dart';

import '../utils/dimensions.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

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
        textSize: Dimensions.font24,
        title: '',
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: Dimensions.sizedBoxHeight10),
          child: ProductBox(),
        ),
      ),
    );
  }
}
