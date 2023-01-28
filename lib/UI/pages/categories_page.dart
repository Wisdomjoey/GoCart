import 'package:flutter/material.dart';
import 'package:GOCart/UI/components/category_list.dart';
import 'package:GOCart/UI/utils/dimensions.dart';

import '../../CONSTANTS/constants.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String cat = Constants.categories[0];
  // List<bool> selected = List.generate(Constants.categories.length, (index) => false);
  Map<String, bool> selected = { for (var element in Constants.categories) element : false };

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Dimensions.sizedBoxWidth10 * 9,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: ListView.builder(
            addAutomaticKeepAlives: false,
            itemCount: Constants.categories.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: cat == Constants.categories[index]
                    ? BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: Constants.secondary,
                                width: Dimensions.sizedBoxWidth10 / 2)))
                    : const BoxDecoration(),
                margin:
                    EdgeInsets.only(bottom: Dimensions.sizedBoxHeight10 / 5),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.sizedBoxHeight10 / 2,
                      horizontal: Dimensions.sizedBoxWidth10),
                  title: Center(
                    child: Text(
                      Constants.categories[index],
                      style: TextStyle(fontSize: Dimensions.font13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  tileColor: cat == Constants.categories[index]
                      ? Colors.transparent
                      : (selected[Constants.categories[index]]!
                          ? Colors.transparent
                          : Constants.white),
                  onTap: () {
                    setState(() {
                      selected[cat] = false;
                      cat = Constants.categories[index];
                      selected[Constants.categories[index]] = true;
                    });
                  },
                ),
              );
            },
          ),
        ),
        Expanded(
          child: CategoryList(
            cat: cat,
          ),
        ),
      ],
    );
  }
}
