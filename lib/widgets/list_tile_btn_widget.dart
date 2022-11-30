import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolproj/utils/dimensions.dart';

class ListTileBtn extends StatelessWidget {
  final double visualD;
  final double? textSize;
  final String? title;
  final Widget? leading;
  final Widget? child;
  final FontWeight? weight;
  final String? page;
  const ListTileBtn(
      {super.key,
      this.visualD = -1,
      this.textSize,
      this.title,
      this.leading,
      this.weight,
      this.page,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      animationDuration: const Duration(milliseconds: 100),
      child: ListTile(
        leading: leading,
        contentPadding:
            EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
        title: child ??
            Text(
              title!,
              style: TextStyle(fontSize: textSize, fontWeight: weight),
            ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: textSize ?? Dimensions.font12,
        ),
        iconColor: const Color(0XFF111111),
        minLeadingWidth: 2.0,
        visualDensity: VisualDensity(vertical: visualD),
        onTap: () {
          Timer(const Duration(milliseconds: 200), () => Get.toNamed(page!));
        },
      ),
    );
  }
}
