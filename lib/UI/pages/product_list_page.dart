import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:GOCart/UI/components/home_app_bar.dart';
import 'package:GOCart/UI/components/product_box.dart';
import 'package:provider/provider.dart';

import '../utils/dimensions.dart';

class ProductListPage extends StatefulWidget {
  final String title;

  const ProductListPage({super.key, required this.title});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  searchProducts() async {
    return await Provider.of<ProductProvider>(context)
        .searchProducts(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    List products = searchProducts();

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
          child: products.isEmpty &&
                  Provider.of<ProductProvider>(context).process ==
                      Process.processing
              ? const CircularProgressIndicator(
                  color: Constants.tetiary,
                )
              : (products.isNotEmpty
                  ? ProductBox(
                      snapshotDocs: products,
                    )
                  : const Center(
                      child: Text('No Product'),
                    )),
        ),
      ),
    );
  }
}
