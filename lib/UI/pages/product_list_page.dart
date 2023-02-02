import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/PREFS/preferences.dart';
import 'package:GOCart/PROVIDERS/global_provider.dart';
import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:GOCart/UI/components/home_app_bar.dart';
import 'package:GOCart/UI/components/product_box.dart';
import 'package:provider/provider.dart';

import '../utils/dimensions.dart';

class ProductListPage extends StatefulWidget {
  final String title;
  final bool isSearched;

  const ProductListPage({super.key, required this.title, required this.isSearched});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  getHistory() async {
    await Preferences().getListData(Constants.prefsSearchHistory).then((value) {
      if (value != null) {
        if (!value.contains(widget.title)) {
          Preferences().saveListData(
              Constants.prefsSearchHistory, [...value, widget.title]);

          Provider.of<GlobalProvider>(context, listen: false)
              .setHistory([...value, widget.title]);
        }
      } else {
        Preferences()
            .saveListData(Constants.prefsSearchHistory, [widget.title]);

        Provider.of<GlobalProvider>(context, listen: false)
            .setHistory([widget.title]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isSearched) {
      getHistory();
    }
  }

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
      body: FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false)
            .searchProducts(widget.title),
        builder: (context, AsyncSnapshot snapshot) {
          return Container(
            margin: EdgeInsets.only(top: Dimensions.sizedBoxHeight10),
            child: snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                  child: CircularProgressIndicator(
                      color: Constants.tetiary,
                    ),
                )
                : (snapshot.data.isNotEmpty
                    ? SingleChildScrollView(
                        child: ProductBox(
                          snapshotDocs: snapshot.data,
                        ),
                      )
                    : const Center(
                        child: Text('No Product'),
                      )),
          );
        },
      ),
    );
  }
}
