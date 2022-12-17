import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/utils/dimensions.dart';

class ListTileBtn extends StatelessWidget {
  final double visualD;
  final double? textSize;
  final String? title;
  final Widget? leading;
  final Widget? trailing;
  final Widget? child;
  final FontWeight? weight;
  final void Function()? onTap;
  final String? page;
  final bool showTrailing;
  const ListTileBtn(
      {super.key,
      this.visualD = -1,
      this.textSize,
      this.title,
      this.leading,
      this.weight,
      this.page,
      this.child,
      this.showTrailing = true,
      this.trailing,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      contentPadding:
          EdgeInsets.symmetric(horizontal: Dimensions.sizedBoxWidth10),
      title: child ??
          Text(
            title!,
            style: TextStyle(fontSize: textSize, fontWeight: weight),
          ),
      trailing: showTrailing
          ? (trailing ??
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: textSize ?? Dimensions.font12,
              ))
          : const Text(''),
      iconColor: const Color(0XFF111111),
      minLeadingWidth: 2.0,
      visualDensity: VisualDensity(vertical: visualD),
      onTap: page != null
          ? () {
              Timer(
                  const Duration(milliseconds: 200), () => Get.toNamed(page!));
            }
          : onTap,
    );
  }
}
