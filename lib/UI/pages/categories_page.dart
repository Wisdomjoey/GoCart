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
  int data = 0;
  List<bool> selected = List.generate(Constants.categories.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Dimensions.sizedBoxWidth10 * 9,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: ListView.builder(
            addAutomaticKeepAlives: false,
            itemCount: Constants.categories.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: data == index
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
                  tileColor: data == index
                      ? Colors.transparent
                      : (selected[index]
                          ? Colors.transparent
                          : Constants.white),
                  onTap: () {
                    setState(() {
                      selected[data] = false;
                      data = index;
                      selected[index] = true;
                    });
                  },
                ),
              );
            },
          ),
        ),
        Expanded(
          child: CategoryList(
            index: data,
          ),
        ),
      ],
    );
  }
}
